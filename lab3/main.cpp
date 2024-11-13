#include "VMux83/VMux83.h"
#include <cassert>
#include <cstdint>
#include <cstdio>
#include <iostream>

int main() {
    VMux83 top;
    for (uint8_t g1 = 0; g1 < 2; g1++) {
        for (uint8_t not_g2_a = 0; not_g2_a < 2; not_g2_a++) {
            for (uint8_t not_g2_b = 0; not_g2_b < 2; not_g2_b++) {
                for (uint8_t c = 0; c < 2; c++) {
                    for (uint8_t b = 0; b < 2; b++) {
                        for (uint8_t a = 0; a < 2; a++) {
                            uint8_t ans_not_y = 0xff;
                            if (g1 != 0 && not_g2_a != 1 && not_g2_b != 1) {
                                uint8_t t = (c << 2) + (b << 1) + a;
                                ans_not_y = ~(1 << t);
                            }
                            top.g1 = g1;
                            top.not_g2a = not_g2_a;
                            top.not_g2b = not_g2_b;
                            top.a = a;
                            top.b = b;
                            top.c = c;
                            top.eval();  
                            assert(top.not_y == ans_not_y);
                        }
                    }
                }
            }
        }
    }
    std::cout << "\e[32mPASS\e[0m" << std::endl;
    return 0;
}
