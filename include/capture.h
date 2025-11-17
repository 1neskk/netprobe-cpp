#pragma once
#include <iostream>

#include <pcap/pcap.h>
#include <netinet/in.h>

#include "utils.h"

class PacketCapture {
public:
    PacketCapture(const char* device);
    ~PacketCapture();

    void startCapture();
    void stopCapture();

    void processPacket(const struct pcap_pkthdr* header, const u_char* packetData);
private:
    pcap_t* handle_;
    const char* device_;
    int datalink_ = -1;
};