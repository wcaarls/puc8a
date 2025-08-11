       .include "def.asm"
       .include "macros.asm"

; Write welcome message
main:  ldr  r0, 7
       ldr  r1, @msg1
       call @writemsg ; Write 7 characters from @msg1 to lcd
halt:  b    @halt

; Write message to LCD (r0 == length, r1 == address)
writemsg:
       get  r0
       add  r1
       set  r0        ; Set r0 to one past final character
wloop: lda  [r1]      ; Get character to write
       set  r2
       writelcd r2    ; Write character to LCD
       inc  r1        ; Advance
       get  r1
       sub  r0
       bnz  @wloop    ; Loop until last character was sent
       ret

.section data
       .org 0x10
msg1:  .db "welcome"
