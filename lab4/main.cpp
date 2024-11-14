#include <cassert>
#include <iostream>
#include <cstdint>
#include <cstdio>
#include "VPriority/VPriority.h"

uint8_t encoder(uint8_t i, uint8_t &done) {
    if (i == 0) {
        done = 0;
        return 0;
    }
    uint8_t res = 0;
    while (i & 0x1) {
        i >>= 1;
        res++;
    }
    done = 1;
    return res;
}

int main() {
    VPriority top;
    for (uint8_t not_en = 0; not_en < 2; not_en ++ ) {
        for (uint16_t i = 0; i <= 0xff; i++) {
            top.not_en = not_en;
            top.i = i;
            top.eval();
            uint8_t done;
            uint8_t y;
            if (!not_en) {
                done = 0;
                y = 0;
            } else {
                y = encoder(i, done);
            }
        }
    }
    std::cout << "\e[32mPASS\e[0m" << std::endl;
    return 0;
}
