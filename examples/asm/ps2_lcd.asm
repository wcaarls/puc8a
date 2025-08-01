       .include "def.asm"
       .include "macros.asm"

; Write welcome message
main:  ldi  7
       set  r0
       ldi  @msg1
       set  r1
       call @writemsg ; Write 7 characters from @msg1 to lcd

; Echo PS/2 characters to LCD
loop:  ldi  0x0D
       set  r1
       waitkb r0      ; Read character from keyboard
       sub  r1
       bz   @clear    ; If enter, clear LCD
       writelcd r0    ; Otherwise, write to LCD
       b    @loop
clear: clearlcd r0    ; Clear LCD
       b    @loop

; Write message to LCD.
; r0 contains message length
; r1 contains message address
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
