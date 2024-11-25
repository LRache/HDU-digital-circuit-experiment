#include "VShifter/VShifter.h"
#include <cassert>

VShifter top;

void exec_once() {
    top.clk = 0;
    top.eval();
    top.clk = 1;
    top.eval();
}


int main() {
    uint16_t lastQ = top.q;

    // set
    for (uint16_t d; d <= 0xff; d++) {
        top.d = d;
        top.s = 0b11;
        top.eval();
        assert(top.q == lastQ);
        exec_once();
        assert(top.q == d);
        lastQ = top.q;
    }

    // shift_right
     for (uint16_t d; d <= 0xff; d++) {
        top.d = d;
        top.s = 0b01;
        top.eval();
        exec_once();
    };
}
