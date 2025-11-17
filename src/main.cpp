#include "capture.h"

// TODO: Add device as a command line argument
int main() {
    PacketCapture pcap("enp3s0");
    pcap.startCapture();
    return 0;
}