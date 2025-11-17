#include "capture.h"

#define ETH_HDR_LEN 14
#define VLAN_HDR_LEN 4
#define IP_HDR_MIN_LEN 20

PacketCapture::PacketCapture(const char* device) : device_(device), handle_(nullptr) {
    char errbuf[PCAP_ERRBUF_SIZE];
    handle_ = pcap_create(device, errbuf);
    if (!handle_)
        std::cerr << "Failed to create PCAP handle: " << errbuf << "\n";
}

PacketCapture::~PacketCapture() {
    if (handle_) {
        pcap_close(handle_);
        handle_ = nullptr;
    }
}

void PacketCapture::startCapture() {
    if (handle_ == nullptr) {
        std::cerr << "PCAP handle is not initialized.\n";
        return;
    }

    pcap_set_snaplen(handle_, 65535);
    pcap_set_promisc(handle_, 1);
    pcap_set_timeout(handle_, 1000);

    if (pcap_activate(handle_) != 0) {
        std::cerr << "Failed to activate PCAP handle: " << pcap_geterr(handle_) << "\n";
        pcap_close(handle_);
        handle_ = nullptr;
        return;
    }

    datalink_ = pcap_datalink(handle_);

    struct bpf_program program;
    const char* filter = "ip";
    if (pcap_compile(handle_, &program, filter, 0, PCAP_NETMASK_UNKNOWN) == 0) {
        if (pcap_setfilter(handle_, &program) != 0)
            std::cerr << "Failed to set filter: " << pcap_geterr(handle_) << "\n";
        pcap_freecode(&program);
    } else {
        std::cerr << "Failed to compile filter: " << pcap_geterr(handle_) << "\n";
    }

    std::cout << "Packet capture started on device " << device_ << "\n";
    int status = pcap_loop(handle_, 0, [](u_char* userData, const struct pcap_pkthdr* header, const u_char* packetData) {
        PacketCapture* self = reinterpret_cast<PacketCapture*>(userData);
        self->processPacket(header, packetData);
    }, reinterpret_cast<u_char*>(this));

    if (status == -1)
        std::cerr << "Error during packet capture: " << pcap_geterr(handle_) << "\n";
    else if (status == -2)
        std::cout << "Packet capture stopped by user.\n";
}

void PacketCapture::stopCapture() {
    if (handle_ != nullptr) {
        pcap_breakloop(handle_);
        pcap_close(handle_);
        handle_ = nullptr;
    }
}

void PacketCapture::processPacket(const struct pcap_pkthdr* header, const u_char* packetData) {
    const size_t caplen = header->caplen;
    const u_char* data = packetData;

    size_t l2 = 0; // Layer 2 header length
    uint16_t eth_type = 0;

    if (datalink_ == DLT_EN10MB) {
        if (caplen < ETH_HDR_LEN) {
            std::cout << "Packet too short for Ethernet header\n";
            return;
        }
        
        l2 = ETH_HDR_LEN;
        if (!Utils::read_u16(data, caplen, 12, eth_type)) {
            std::cerr << "Failed to read Ethernet type\n";
            return;
        }

        if (eth_type == 0x8100 || eth_type == 0x88A8) {
            if (caplen < (ETH_HDR_LEN + VLAN_HDR_LEN)) {
                std::cout << "Packet too short for VLAN header\n";
                return;
            }
            if (!Utils::read_u16(data, caplen, 16, eth_type)) {
                std::cerr << "Failed to read VLAN encapsulated Ethernet type\n";
                return;
            }
            l2 += VLAN_HDR_LEN;
        }
    } else {
        std::cerr << "Unsupported datalink type: " << datalink_ << ", len=" << header->len << "\n";
        return;
    }

    if (eth_type == 0x0800 && caplen >= l2 + IP_HDR_MIN_LEN) {
        // IPv4
        const u_char* ip = data + l2;
        const uint8_t ip_header_len = (ip[0] & 0x0F) * 4;
        if ((ip[0] >> 4) != 4 || caplen < l2 + ip_header_len) {
            std::cout << "Not a valid IPv4 packet\n";
            return;
        }

        uint8_t protocol = ip[9];
        uint16_t totlen_n = 0;
        std::memcpy(&totlen_n, ip + 2, sizeof(uint16_t));
        uint16_t totlen = ntohs(totlen_n);

        char src[INET_ADDRSTRLEN], dst[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, ip + 12, src, sizeof(src));
        inet_ntop(AF_INET, ip + 16, dst, sizeof(dst));

        if (protocol == IPPROTO_TCP && caplen >= l2 + ip_header_len + IP_HDR_MIN_LEN) {
            const u_char* tcp = ip + ip_header_len;
            uint16_t src_port_n = 0, dst_port_n = 0;
            std::memcpy(&src_port_n, tcp, sizeof(uint16_t));
            std::memcpy(&dst_port_n, tcp + 2, sizeof(uint16_t));
            uint16_t src_port = ntohs(src_port_n);
            uint16_t dst_port = ntohs(dst_port_n);

            std::cout << "TCP Packet: " << src << ":" << src_port << " -> " << dst << ":" << dst_port
                      << " Length: " << totlen << "\n";
        } else if (protocol == IPPROTO_UDP && caplen >= l2 + ip_header_len + 8) {
            const u_char* udp = ip + ip_header_len;
            uint16_t src_port_n = 0, dst_port_n = 0;
            std::memcpy(&src_port_n, udp, sizeof(uint16_t));
            std::memcpy(&dst_port_n, udp + 2, sizeof(uint16_t));
            uint16_t src_port = ntohs(src_port_n);
            uint16_t dst_port = ntohs(dst_port_n);

            std::cout << "UDP Packet: " << src << ":" << src_port << " -> " << dst << ":" << dst_port
                      << " Length: " << totlen << "\n";
        } else if(protocol == IPPROTO_ICMP && caplen >= l2 + ip_header_len + 8) {
            const u_char* icmp = ip + ip_header_len;
            uint8_t icmp_type = icmp[0];
            uint8_t icmp_code = icmp[1];

            std::cout << "ICMP Packet: " << src << " -> " << dst
                      << " Type: " << static_cast<int>(icmp_type)
                      << " Code: " << static_cast<int>(icmp_code)
                      << " Length: " << totlen << "\n";
        } else {
            std::cout << "Other IPv4 Packet: " << src << " -> " << dst
                      << " Protocol: " << static_cast<int>(protocol)
                      << " Length: " << totlen << "\n";
        }
    } else if (eth_type == 0x86DD && caplen >= l2 + 40) {
        // IPv6
        const u_char* ip6 = data + l2;
        char src[INET6_ADDRSTRLEN], dst[INET6_ADDRSTRLEN];
        inet_ntop(AF_INET6, ip6 + 8, src, sizeof(src));
        inet_ntop(AF_INET6, ip6 + 24, dst, sizeof(dst));

        uint32_t payload_len_n = 0;
        std::memcpy(&payload_len_n, ip6 + 4, sizeof(uint16_t));
        uint16_t payload_len = ntohs(static_cast<uint16_t>(payload_len_n));
        uint8_t next_header = ip6[6];

        std::cout << "IPv6 Packet: " << src << " -> " << dst
                  << " Next Header: " << static_cast<int>(next_header)
                  << " Payload Length: " << payload_len << "\n";
    } else {
        std::cout << "Non-IP Packet or unsupported EtherType: 0x" << std::hex << eth_type << std::dec << "\n";
    }
}
