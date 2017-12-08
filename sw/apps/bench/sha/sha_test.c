#include "sha.h"
#include "common.h"

SHA_INFO sha_info __sram;
uint8_t data[256] __sram;

void test_setup() {
  for (int i = 0; i != 256; ++i)
    data[i] = i;
}

void test_clear() {}

void test_run() {
  sha_init(&sha_info);
  for(int n = 0; n < 4; ++n) {
    sha_update(&sha_info, data + 4 * n, 256);
  }
  sha_final(&sha_info);
}

int test_check() {
  uint32_t check_digest[5] = {
    0x6df33e84,
    0xbfb762a3,
    0xd55acf9e,
    0xf2dd5e59,
    0xf4d61769
  };
  for (int i = 0; i < 5; i++) {
    if (sha_info.digest[i] != check_digest[i])
      return 0;
  }
  return 1;
}
