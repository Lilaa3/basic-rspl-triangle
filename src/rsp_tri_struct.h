#include <stdint.h>
#include <libdragon.h>

constexpr float const_floorf(float x) {
    float i = (int)x;
    return (x < i) ? (i - 1.0f) : i;
}

// Screen Space Coords
constexpr int16_t float_to_s13_2(float f) {
    return (int16_t)const_floorf(f * 4.0f);
}

// Texture Coords
constexpr int16_t float_to_s10_5(float f) {
    return (int16_t)const_floorf(f * 32.0f);
}

// Z
constexpr int16_t float_to_s15(float f) {
    return (int16_t)(f * 32767.0f);
}

// W
constexpr int32_t float_to_s16_16(float f) {
    if (f >= 32768.0f) return 0x7FFFFFFF;
    if (f < -32768.0f) return 0x80000000;
    return (int32_t)const_floorf(f * 65536.0f);
}

constexpr int16_t s16_16_int(int32_t val) {
    return (int16_t)(val >> 16);
}

constexpr uint16_t s16_16_frac(int32_t val) {
    return (uint16_t)(val & 0xFFFF);
}

typedef struct {
    int16_t x;          // Screen X (s13.2 fixed-point)
    int16_t y;          // Screen Y (s13.2 fixed-point)
    int16_t z;          // Z depth (s15.0 fixed-point)
    uint8_t clipflags;  // Frustum clipping flags (Bit 0..5, 1=outside)
    uint8_t rejflags;   // Trivial reject flags (Bit 0..5, 1=inside)
    color_t rgba;
    int16_t s;          // Texture S coord (s10.5 fixed-point)
    int16_t t;          // Texture T coord (s10.5 fixed-point)
    
    // W representation (1.0f / inv_w) in s16.16
    int16_t wi;         // Integer part of W
    uint16_t wf;        // Fractional part of W
    
    // 1/W representation (inv_w) in s16.16
    int16_t inv_wi;     // Integer part of 1/W
    uint16_t inv_wf;    // Fractional part of 1/W

    uint16_t pad[4];
} __attribute__((packed)) __attribute__((aligned(16))) rdpq_vertex_t;