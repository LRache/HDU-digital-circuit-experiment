#include "nvboard.h"
#include "VTop/VTop.h"
#include "pins.h"

#include <chrono>

#define CLK_FREQ 200000 // 200KHz

VTop top;

void bind_pin() {
    nvboard_bind_pin(&top.seg_ah, 7, SEG0G, SEG0F, SEG0E, SEG0D, SEG0C, SEG0B, SEG0A);
    nvboard_bind_pin(&top.seg_al, 7, SEG1G, SEG1F, SEG1E, SEG1D, SEG1C, SEG1B, SEG1A);
    nvboard_bind_pin(&top.seg_bh, 7, SEG2G, SEG2F, SEG2E, SEG2D, SEG2C, SEG2B, SEG2A);
    nvboard_bind_pin(&top.seg_bl, 7, SEG3G, SEG3F, SEG3E, SEG3D, SEG3C, SEG3B, SEG3A);
    nvboard_bind_pin(&top.led_a, 3, LD0, LD1, LD2);
    nvboard_bind_pin(&top.led_b, 3, LD3, LD4, LD5);
    nvboard_bind_pin(&top.rst, 1, BTNC);
    nvboard_bind_pin(&top.start, 1, BTNL);
    nvboard_bind_pin(&top.pause, 1, BTNR);
    nvboard_bind_pin(&top.stopa, 1, BTNU);
    nvboard_bind_pin(&top.stopb, 1, BTND);
}

void exec_once() {
    top.clk = 0;
    top.eval();
    nvboard_update();
    top.clk = 1;
    top.eval();
    nvboard_update();
}

int main() {
    bind_pin();
    nvboard_init();
    while (true) {
        exec_once();
    }
    nvboard_quit();
    return 0;
}