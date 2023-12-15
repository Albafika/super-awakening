.p816   ; 65816 processor
.i16    ; X/Y are 16 bits
.a8     ; A is 8 bits

.include "snes.inc"
.segment "CODE"
CODE:

MOSAIC_SHADER:

MOSAIC_SHADER_LOOP:
   ; Load counter value
   lda $7f0100

   ; Break if counter empty
   CMP $00
   BEQ MOSAIC_SHADER_LOOP_end

   ; Decrement counter value
   dec
   CMP $00
   BEQ STORE_COUNTER

   dec
   CMP $00
   BEQ STORE_COUNTER

   dec
   CMP $00
   BEQ STORE_COUNTER

   dec
   CMP $00
   BEQ STORE_COUNTER
   
   dec
   CMP $00
   BEQ STORE_COUNTER

STORE_COUNTER:
   sta $7f0100

Do_MOASIC:

   ; Moasic value is high bits, so we will just clip off the low bits of the counter
   and #$F0

   ; Set 3layer flag (0100)
   ora #$04
   ; Set PPU flag
   sta MOSAIC 

MOSAIC_SHADER_LOOP_end:

   JMP @injected_label

@some_data:
   .byte $01,$02,$01,$00

@counter1:
   .byte $00

@injected_label:
   JML $000814

   ; EOF marker
   .byte 0,0,0