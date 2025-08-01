main: ldi 0
      set r0 ; r0 = 0
      ldi 1
      set r1 ; r1 = 1
loop: add r0
      set r2 ; r2 = r1 + r0
      get r1
      set r0 ; r0 = r1
      get r2
      set r1 ; r1 = r2
      b   @loop
