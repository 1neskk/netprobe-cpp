#include <cstdint>
#include <cstring>

#include <arpa/inet.h>

namespace Utils {
    bool read_u16(const u_char* data, size_t len, size_t offset, uint16_t& out);
}