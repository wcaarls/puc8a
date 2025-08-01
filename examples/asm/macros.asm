; Example macros for ENG1448 processor

; Call subroutine
; INPUT : Immediate destination address in $0
; OUTPUT: None
.macro call
       ldi 6
       add pc          ; Calculate return address
       sta [sp]
       dec sp          ; Push to stack
       ldi $0
       set pc          ; Jump to destination
.endmacro

; Return from subroutine
; INPUT : None
; OUTPUT: None
.macro ret
       inc sp
       lda [sp]        ; Pop return address from stack
       set pc          ; Jump to return address
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
