#include <libdragon.h>
#include <stdio.h>

#include "rsp_tri_struct.h"

#define RSPQ_DEBUG 1
#define RSPQ_PROFILE 1

DEFINE_RSP_UCODE(rsp_example);

enum { Cmd_DrawTriangle = 0x0 };

// Pre-calculate W = 1.0f in s16.16, we seperate this into integer and
// fractional parts later
static constexpr int32_t W1_0 = float_to_s16_16(1.0f);

const static __attribute__((aligned(8))) rdpq_vertex_t triangle_vertices[3] = {
    {
        .x = float_to_s13_2(100.0f),
        .y = float_to_s13_2(150.0f),
        .z = 0,
        .clip_flags = 0x00,
        .rej_flags = 0xFF,
        .rgba = RGBA32(255, 0, 0, 255),
        .s = 0,
        .t = 0,
        .wi = s16_16_int(W1_0),
        .wf = s16_16_frac(W1_0),
        .inv_wi = s16_16_int(W1_0),
        .inv_wf = s16_16_frac(W1_0),
    },
    {
        .x = float_to_s13_2(150.0f),
        .y = float_to_s13_2(90.0f),
        .z = 0,
        .clip_flags = 0x00,
        .rej_flags = 0xFF,
        .rgba = RGBA32(0, 255, 0, 255),
        .s = 0,
        .t = 0,
        .wi = s16_16_int(W1_0),
        .wf = s16_16_frac(W1_0),
        .inv_wi = s16_16_int(W1_0),
        .inv_wf = s16_16_frac(W1_0),
    },
    {
        .x = float_to_s13_2(200.0f),
        .y = float_to_s13_2(150.0f),
        .z = 0,
        .clip_flags = 0x00,
        .rej_flags = 0xFF,
        .rgba = RGBA32(0, 0, 255, 255),
        .s = 0,
        .t = 0,
        .wi = s16_16_int(W1_0),
        .wf = s16_16_frac(W1_0),
        .inv_wi = s16_16_int(W1_0),
        .inv_wf = s16_16_frac(W1_0),
    }
};

int main() {
    rspq_init();
    rdpq_init();
    display_init(RESOLUTION_320x240,
                 DEPTH_16_BPP,
                 3,
                 GAMMA_NONE,
                 FILTERS_RESAMPLE_ANTIALIAS);

    // Register overlay and record a block to run every frame
    auto rsp_example_id = rspq_overlay_register(&rsp_example);
    rspq_block_begin();
    uint16_t tri_cmd =
        format_tri_cmd(GEO_FLAG_SHADE_ENABLED | GEO_FLAG_Z_ENABLED);
    rdpq_write(-1,
               rsp_example_id,
               Cmd_DrawTriangle,
               tri_cmd,
               PhysicalAddr(
                   &triangle_vertices[0])); // Hardcoded triangle, nothing fancy
    auto block = rspq_block_end();

    for (;;) {
        auto disp = display_get();
        auto zbuf = display_get_zbuf();
        rdpq_attach(disp, zbuf);
        rdpq_clear_z(0);
        rdpq_clear(RGBA32(50, 50, 50, 255));

        // clang-format off
        rdpq_mode_begin();
          rdpq_set_mode_standard();
          rdpq_mode_combiner(RDPQ_COMBINER_SHADE); // Use vertex colors
          rdpq_set_prim_color(RGBA32(255, 255, 255, 255));
          rdpq_mode_antialias(AA_STANDARD);
        rdpq_mode_end();
        // clang-format on

        rspq_block_run(block);
        rdpq_detach_show(); // Display, change display
    }

    rspq_overlay_unregister(rsp_example_id);
    return 0;
}