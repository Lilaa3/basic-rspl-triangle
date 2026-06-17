## Auto-generated file, transpiled with RSPL
#include <rsp_queue.inc>
#include <rdpq_macros.h>
#include <rsp_rdpq_tri.inc>

.set noreorder
.set noat
.set nomacro

#undef zero
#undef at
#undef v0
#undef v1
#undef a0
#undef a1
#undef a2
#undef a3
#undef t0
#undef t1
#undef t2
#undef t3
#undef t4
#undef t5
#undef t6
#undef t7
#undef s0
#undef s1
#undef s2
#undef s3
#undef s4
#undef s5
#undef s6
#undef s7
#undef t8
#undef t9
#undef k0
#undef k1
#undef gp
#undef sp
#undef fp
#undef ra
.equ hex.$zero, 0
.equ hex.$at, 1
.equ hex.$v0, 2
.equ hex.$v1, 3
.equ hex.$a0, 4
.equ hex.$a1, 5
.equ hex.$a2, 6
.equ hex.$a3, 7
.equ hex.$t0, 8
.equ hex.$t1, 9
.equ hex.$t2, 10
.equ hex.$t3, 11
.equ hex.$t4, 12
.equ hex.$t5, 13
.equ hex.$t6, 14
.equ hex.$t7, 15
.equ hex.$s0, 16
.equ hex.$s1, 17
.equ hex.$s2, 18
.equ hex.$s3, 19
.equ hex.$s4, 20
.equ hex.$s5, 21
.equ hex.$s6, 22
.equ hex.$s7, 23
.equ hex.$t8, 24
.equ hex.$t9, 25
.equ hex.$k0, 26
.equ hex.$k1, 27
.equ hex.$gp, 28
.equ hex.$sp, 29
.equ hex.$fp, 30
.equ hex.$ra, 31
#define vco 0
#define vcc 1
#define vce 2

.data
  RSPQ_BeginOverlayHeader
    RSPQ_DefineCommand Cmd_DrawTriangle, 8
  RSPQ_EndOverlayHeader

  RSPQ_BeginSavedState
    STATE_MEM_START:
    .align 4
    vtx0: .ds.b 32
    .align 4
    vtx1: .ds.b 32
    .align 4
    vtx2: .ds.b 32
    STATE_MEM_END:
  RSPQ_EndSavedState

.text
OVERLAY_CODE_START:

Cmd_DrawTriangle:
  or $s0, $zero, $a1                                 ## L:16   |      ^ | dma_in(vtx0, verticePtr, 96);
  ori $t0, $zero, 95                                 ## L:16   |      2 | dma_in(vtx0, verticePtr, 96);
  addiu $t2, $zero, 12                               ## L:16   |      3 | dma_in(vtx0, verticePtr, 96);
  jal DMAExec                                        ## L:16   |      4 | dma_in(vtx0, verticePtr, 96); ## Args: $t0, $t1, $s0, $s4, $t2
  ori $s4, $zero, %lo(vtx0)                          ## L:16   |     *6 | dma_in(vtx0, verticePtr, 96);
  ori $a2, $zero, %lo(vtx1)                          ## L:20   |      7 | u16<$a2> v1 = vtx1;
  addiu $v0, $zero, 2                                ## L:24   |      8 | RDPQ_Triangle_Send_Async(triCmd, v0, v1, v2, 2);
  ori $a3, $zero, %lo(vtx2)                          ## L:21   |      9 | u16<$a3> v2 = vtx2;
  jal RDPQ_Triangle_Send_Async                       ## L:24   |     10 | RDPQ_Triangle_Send_Async(triCmd, v0, v1, v2, 2); ## Args: $a0, $a1, $a2, $a3, $v0
  ori $a1, $zero, %lo(vtx0)                          ## L:19   |    *12 | u16<$a1> v0 = vtx0;
  jal RDPQ_Triangle_Send_End                         ## L:26   |     13 | RDPQ_Triangle_Send_End();
  nop                                                ## L:26   |    *15 | RDPQ_Triangle_Send_End();
  j Exit                                             ## L:27   |     16 | goto Exit;
  nop                                                ## L:27   |    *18 | goto Exit;
  RDPQ_Triangle_Cull:
  nop # inline-ASM                                   ## L:30   |      0 | asm("nop");
  RDPQ_Triangle_Clip:
  nop # inline-ASM                                   ## L:32   |      0 | asm("nop");
  Exit:
  nop # inline-ASM                                   ## L:35   |      0 | asm("nop");
  j RSPQ_Loop                                        ## L:36   |     19 | }
  nop                                                ## L:36   |    *21 | }

OVERLAY_CODE_END:

#define zero $0
#define v0 $2
#define v1 $3
#define a0 $4
#define a1 $5
#define a2 $6
#define a3 $7
#define t0 $8
#define t1 $9
#define t2 $10
#define t3 $11
#define t4 $12
#define t5 $13
#define t6 $14
#define t7 $15
#define s0 $16
#define s1 $17
#define s2 $18
#define s3 $19
#define s4 $20
#define s5 $21
#define s6 $22
#define s7 $23
#define t8 $24
#define t9 $25
#define k0 $26
#define k1 $27
#define gp $28
#define sp $29
#define fp $30
#define ra $31

.set at
.set macro