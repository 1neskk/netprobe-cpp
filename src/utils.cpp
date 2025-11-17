#include "utils.h"

bool Utils::read_u16(const u_char* data, size_t len, size_t offset, uint16_t& out) {
    if (offset + sizeof(uint16_t) > len)
        return false;

    std::memcpy(&out, data + offset, sizeof(uint16_t));
    out = ntohs(out);
    return true;
}