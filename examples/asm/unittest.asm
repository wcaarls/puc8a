; Unit tests for ENG1448 processor
; When successful, halts at instruction 254, showing 0b01010101
; When unsuccessful, halts at instruction 255, showing test number (1-38)

       .macro setled
       ldi  $0
       sta  [r12]
       .endmacro

       .macro mov
       ldi  $1
       set  $0
       .endmacro

.section data

       .org 17

data:  .db  0x55
data2: .db  0xAA
tmp1:  .db  0
       .db  0
tmp2:  .db  0
tmp3:  .db  0

.section code

; Preparation
main:  mov  r12, 5
       setled 1
       mov  r5, 0x55
       mov  r10, 0xAA

; Load immediate
ldi1:  setled 2
       ldi  0x55

       sub  r5
       bnz  @err

; Get from register
mov2:  setled 3
       get  r10
       sub  r10
       bnz  @err

; Load from address contained in register
ldr2:  setled 5
       mov  r0, @data
       lda  [r0]
       sub  r5
       bnz  @err

; Store to address contained in register
str2:  setled 9
       mov  r0, @tmp2
       get  r5
       sta  [r0]
       ldi  0
       lda  [r0]
       sub  r5
       bnz  @err

; Unconditional branch to immediate address
b1:    setled 12
       b    @b2
       b    @err
b2:

; Add two registers
add1:  setled 17
       get  r5
       add  r10
       set  r0
       ldi  0xFF
       sub  r0
       bnz  @err

; Subtract two registers
sub1:  setled 19
       get  r10
       sub  r5
       set  r0
       ldi  0x55
       sub  r0
       bnz  @err

; Shift left (always 1)
shl1:  setled 21
       mov  r1, 1
       get  r5
       shft r1
       sub  r10
       bnz  @err

; Shift right (always 1)
shr1:  setled 23
       mov  r2, -1
       get  r10
       shft r2
       sub  r5
       bnz  @err

; Bit-wise AND of two registers
and1:  setled 25
       get  r5
       and  r10
       bnz  @err
       get  r5
       and  r5
       sub  r5
       bnz  @err

; Bit-wise OR of two registers
orr1:  setled 27
       mov  r3, 255
       get  r5
       or   r10
       sub  r3
       bnz  @err
       get  r5
       or   r5
       sub  r5
       bnz  @err

; Bit-wise XOR of two registers
eor1:  setled 29
       get  r5
       xor  r10
       sub  r3
       bnz  @err
       get  r5
       xor  r3
       sub  r10
       bnz  @err

; Branch when zero flag set
bz1:   setled 31
       get  r5
       sub  r5
       bz   @bz2
       b    @err
bz2:   get  r10
       sub  r5
       bz   @err

; Branch when zero flag not set
bnz1:  setled 32
       get  r10
       sub  r5
       bnz  @bnz2
       b    @err
bnz2:  get  r5
       sub  r5
       bnz  @err

; Branch when carry flag set, carry flag set by shift left
bcs1:  setled 33
       get  r10
       shft r1
       bcs  @bcs2
       b    @err

; Branch when carry flag set, carry flag set by addition
bcs2:  setled 34
       get  r5
       shft r1
       bcs  @err
       get  r10
       add  r10
       bcs  @bcs3
       b    @err

; Branch when carry flag set, carry flag set by subtraction
bcs3:  setled 35
       get  r5
       sub  r10
       bcs  @err

; Branch when carry flag not set, carry flag set by shift left
bcc1:  setled 36
       get  r5
       shft r1
       bcc  @bcc2
       b    @err

; Branch when carry flag not set, carry flag set by subtraction
bcc2:  setled 37
       get  r10
       shft r1
       bcc  @err
       get  r10
       sub  r5
       bcc  @err

       b    @succ

       .org 0xF9

succ:  setled 0x55
ends:  b    @ends

       .org 0xFE

err:   b    @err
