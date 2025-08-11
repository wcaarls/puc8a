; Example macros for ENG1448 processor

; Copy value from one register into another
; INPUT : Source value in register $1
; OUTPUT: Copied value in register $0
.macro mov
       get  $1
       set  $0
.endmacro

; Load immediate into register
; INPUT:  Immediate value in $1
; OUTPUT: Copied value in register $0
.macro ldr
       ldi  $1
       set  $0
.endmacro

; Push accumulator onto stack
; INPUT : None
; OUTPUT: None
.macro push
       sta  [sp]
       dec  sp
.endmacro

; Load accumulator from stack
; INPUT : None
; OUTPUT: None
.macro pop
       inc  sp
       lda  [sp]
.endmacro

; Return from subroutine
; INPUT : None
; OUTPUT: None
.macro ret
       pop             ; Pop return address from stack
       set pc          ; Jump to return address
.endmacro

; Call subroutine
; INPUT : Immediate destination address in $0
; OUTPUT: None
.macro call
       ldi  3
       add  pc         ; Calculate return address
       push            ; Push to stack
       b    $0         ; Jump to destination
.endmacro

; Wait for keyboard character.
; INPUT : None
; OUTPUT: Keyboard character in $0 and accumulator
       .macro waitkb
_wait: ldi  @kdr
       set  $0
       lda  [$0]       ; Read keyboard character
       set  $0
       and  $0         ; Set flags
       bz   @_wait     ; Wait until nonzero
       .endmacro

; Write LCD character.
; INPUT : LCD character in $0
; OUTPUT: None
; NOTE  : Clobbers r12
       .macro writelcd
_wait: ldi  @ldr
       set  r12
       lda  [r12]      ; Read LCD data
       set  r12
       and  r12        ; Set flags
       bnz  @_wait     ; Wait until zero
       ldi  @ldr
       set  r12
       get  $0
       sta  [r12]      ; Write character to LCD
       .endmacro

; Clear LCD.
; INPUT : None
; OUTPUT: None
; NOTE  : Clobbers r12
       .macro clearlcd
_wait: ldi  @lcr
       set  r12
       lda  [r12]      ; Read LCD command
       set  r12
       and  r12        ; Set flags
       bnz  @_wait     ; Wait until zero
       ldi  @ldr
       set  r12
       ldi  0x01
       sta  [r12]      ; Clear LCD
       .endmacro
