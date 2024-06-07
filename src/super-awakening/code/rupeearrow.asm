SuperAwakening_QuickRestock::
    ; Skip restocking logic and always return
    jp .return

.Powder:
    ; Skip if we have powder
    ld   a, [wMagicPowderCount]     ; Load magic powder count into register A
    cp $00                           ; Compare with 0
    jp nz, .return                   ; If not zero (meaning we have powder), skip restocking
    ; Skip if we have the toadstool
    ld   a, [wHasToadstool]          ; Load toadstool count into register A
    cp $00                           ; Compare with 0
    jp nz, .return                   ; If not zero (meaning we have toadstool), skip restocking
    ; Check if we have rupees
    ld a, [wRupeeCountLow]           ; Load low byte of rupee count into register A
    cp $00                           ; Compare with 0
    jp nz, .Powder_Purchase          ; If not zero (meaning we have rupees), proceed to powder purchase
    ld a, [wRupeeCountHigh]          ; Load high byte of rupee count into register A
    cp $00                           ; Compare with 0
    jp nz, .Powder_Purchase          ; If not zero (meaning we have rupees), proceed to powder purchase
    jp .return                       ; If we don't have powder, toadstool, or rupees, skip restocking


.Powder_Purchase    
    ld a, $01                        ; Load 1 into register A (to restock 1 powder)
    ld [wMagicPowderCount], a        ; Store the value in the memory location for powder count
    ld hl, wSubstractRupeeBufferLow  ; Load address of the buffer for subtracting rupees into HL
    ld a, [hl]                       ; Load current rupee count into register A

    ; Costs 5 rupees
    inc a                            ; Increment rupee count (5 times)
    inc a
    inc a
    inc a
    inc a
    ld [hl], a                       ; Store updated rupee count back to memory
    jp .return                       ; Return from this subroutine

.Arrow:
    ; Skip if we have arrows
    ld   a, [wArrowCount]            ; Load arrow count into register A
    cp $00                           ; Compare with 0
    jp nz, .return                   ; If not zero (meaning we have arrows), skip restocking
    ; Check if we have rupees
    ld a, [wRupeeCountLow]           ; Load low byte of rupee count into register A
    cp $00                           ; Compare with 0
    jp nz, .Arrow_Purchase           ; If not zero (meaning we have rupees), proceed to arrow purchase
    ld a, [wRupeeCountHigh]          ; Load high byte of rupee count into register A
    cp $00                           ; Compare with 0
    jp nz, .Arrow_Purchase           ; If not zero (meaning we have rupees), proceed to arrow purchase
    jp .return                       ; If we don't have arrows or rupees, skip restocking

.Arrow_Purchase    
    ld a, $01                        ; Load 1 into register A (to restock 1 arrow)
    ld [wArrowCount], a              ; Store the value in the memory location for arrow count
    ld hl, wSubstractRupeeBufferLow  ; Load address of the buffer for subtracting rupees into HL
    ld a, [hl]                       ; Load current rupee count into register A
    inc a                            ; Increment rupee count by 1
    ld [hl], a                       ; Store updated rupee count back to memory
    jp .return                       ; Return from this subroutine

.Bomb:
    ; Skip if we have bombs
    ld   a, [wBombCount]             ; Load bomb count into register A
    cp $00                           ; Compare with 0
    jp nz, .return                   ; If not zero (meaning we have bombs), skip restocking
    ; Check if we have rupees
    ld a, [wRupeeCountLow]           ; Load low byte of rupee count into register A
    cp $00                           ; Compare with 0
    jp nz, .Bomb_Purchase            ; If not zero (meaning we have rupees), proceed to bomb purchase
    ld a, [wRupeeCountHigh]          ; Load high byte of rupee count into register A
    cp $00                           ; Compare with 0
    jp nz, .Bomb_Purchase            ; If not zero (meaning we have rupees), proceed to bomb purchase
    jp .return                       ; If we don't have bombs or rupees, skip restocking

.Bomb_Purchase    
    ld a, $01                        ; Load 1 into register A (to restock 1 bomb)
    ld [wBombCount], a               ; Store the value in the memory location for bomb count
    ld a, $05                        ; Load 5 into register A (cost of 1 bomb)
    ld hl, wSubstractRupeeBufferLow  ; Load address of the buffer for subtracting rupees into HL
    ld a, [hl]                       ; Load current rupee count into register A

    ; Costs 5 rupees
    inc a                            ; Increment rupee count (5 times)
    inc a
    inc a
    inc a
    inc a
    ld [hl], a                       ; Store updated rupee count back to memory
    jp .return                       ; Return from this subroutine

.return
    ; Restore the rombank
    ld   a, BANK(JoypadToLinkDirection)   ; Load bank address of JoypadToLinkDirection into register A
    jp SuperAwakening_Trampoline.returnToBank   ; Jump to the returnToBank subroutine in SuperAwakening_Trampoline
