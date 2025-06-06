; RUN: llvm-mc -triple avr -show-encoding < %s | FileCheck %s
;
; RUN: llvm-mc -filetype=obj -triple avr < %s \
; RUN:     | llvm-objdump -dr - \
; RUN:     | FileCheck --check-prefix=INST %s

foo:
  brlo .+12
  brlo .+28
  brlo bar

bar:

; CHECK: brlo .Ltmp0+12+2  ; encoding: [0bAAAAA000,0b111100AA]
; CHECK: brlo .Ltmp1+28+2  ; encoding: [0bAAAAA000,0b111100AA]
; CHECK: brlo bar            ; encoding: [0bAAAAA000,0b111100AA]

; INST-LABEL: <foo>:
; INST-NEXT: 30 f0      brlo .+12
; INST-NEXT: 70 f0      brlo .+28
; INST-NEXT: 00 f0      brlo .+0
