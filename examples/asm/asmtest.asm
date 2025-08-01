        b @inst

; .org
        .org 0x5

; label, .equ
mylbl:  .equ equ1, 0x2a

; .db
.section data
        .org 0x20
        .db 123
        .db 0x2a
        .db @mylbl2
        .org 0x40
mylbl2: .db "Hello, world"
        .db 123, 0x2a, @mylbl2, "Hello, world"

.section code

; .macro
; local labels
        .macro macro1
_loop:  b @_loop
        .endmacro
        macro1
        macro1

; .macro
; arguments
        .macro macro2
_loop:  ldi $0
        ldi $1
        macro1
        b @_loop
        .endmacro
        macro2 0xAA, 0x55

; Instructions
inst:   lda  [r1]
        sta  [r1]

        get  r1
        set  r1

        inc  r1
        dec  r1

        add  r1
        sub  r1
        and  r1
        or   r1
        xor  r1
        shft r1

        b 1
        b @mylbl

        bz 1
        beq 1
        bnz 1
        bne 1
        bcs 1
        bhs 1
        bcc 1
        blo 1
