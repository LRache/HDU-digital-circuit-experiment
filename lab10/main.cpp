#include <iostream>
#include "VFdiv/VFdiv.h"

#define FREQ (20000000)

VFdiv top;
uint8_t clk_0_5;
uint8_t clk_1;
uint8_t clk_2;
uint8_t clk_6s;

void update_clk() {
    clk_0_5 = top.clk_0_5;
    clk_1   = top.clk_1;
    clk_2   = top.clk_2;
    clk_6s  = top.clk_6s;
}

int main() {
    uint32_t clkCount = 0;
    uint8_t *watcher[] = {&clk_0_5, &clk_1, &clk_2, &clk_6s};
    while (true) {
        top.clk_20M = 0;
        top.eval();
        top.clk_20M = 1;
        top.eval();
        update_clk();
        bool f = false;
        for (int i = 0; i < 4; i++) {
            if (watcher[i] == nullptr) continue;
            else f = true;
            
            if (*watcher[i] == 1) {
                watcher[i] = nullptr;
                std::cout << "CLK" << i << "=1" << "@clkCount=" << clkCount << " time=" << (double)clkCount / FREQ << "s" << std::endl; 
            }
        }
        if (!f) break;
        clkCount += 1;
    }
    return 0;
}
