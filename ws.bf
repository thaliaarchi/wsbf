[ ==========  wsbf - Whitespace interpreter in Brainfuck  =========== ]
[                                                                     ]
[ Copyright (c) 2021, 2025 Thalia Archibald                           ]
[                                                                     ]
[ This Source Code Form is subject to the terms of the Mozilla Public ]
[ License, v. 2.0. If a copy of the MPL was not distributed with this ]
[ file, You can obtain one at https://mozilla.org/MPL/2.0/.           ]

>>+<<

Read opcode until NUL and encode it in ternary with leading 1
Cells: *char=0 digit=0 ternary=1
,[
                      char digit
                ---------T     0
                       [-L  >++2 <
  [----------------------S   >-1 <
                  [[-]else  >--c <
                       ]]]
  >+[->[-<+++>]<[->+<]]< If not a comment: triple ternary and add digit
  ,
]
>>

Map from ternary to opcode ID and argument type
Cells: 0 0 *ternary opcode=0 type=0
                                  base10   id  type     inst     toks base3
                         -------------13  >+1  >++2 <<  push n   SS   111
                       [--------------27  >+2  >--0 <<  retrieve TTT  1000
                                    [-28  >+3     0 <   store    TTS  1001
                            [---------37  >+4  >++2 <<  copy n   STS  1101
                                    [-38  >+5     2 <   slide n  STL  1102
                                 [----42  >+6  >--0 <<  swap     SLT  1120
                                    [-43  >+7     0 <   dup      SLS  1121
                                    [-44  >+8     0 <   drop     SLL  1122
                                    [-45  >+9   >+1 <<  jn l     LTT  1200
                                    [-46  >+10    1 <   jz l     LTS  1201
                                    [-47  >+11  >-0 <<  ret      LTL  1202
                                    [-48  >+12  >+1 <<  call l   LST  1210
                                    [-49  >+13    1 <   label l  LSS  1211
                                    [-50  >+14    1 <   jmp l    LSL  1212
                                  [---53  >+15  >-0 <<  end      LLL  1222
[-------------------------------------90  >+16    0 <   mod      TSTT 10100
                                    [-91  >+17    0 <   div      TSTS 10101
                                   [--93  >+18    0 <   sub      TSST 10110
                                    [-94  >+19    0 <   add      TSSS 10111
                                    [-95  >+20    0 <   mul      TSSL 10112
                                 [----99  >+21    0 <   readi    TLTT 10200
                                    [-100 >+22    0 <   readc    TLTS 10201
                                   [--102 >+23    0 <   printi   TLST 10210
                                    [-103 >+24    0 <   printc   TLSS 10211
                                 [[-]else >[-]0   0 <   invalid
                 ]]]]]]]]]]]]]]]]]]]]]]]]
>>

Read argument
Cells: 0 0 0 opcode *type
[
  [->+<]>

  Read sign if signed
  Cells: 0 0 0 opcode char=0 *continue=type neg=0
  -[-
    <,
                         char cont neg
                          EOF    0
                  [---------T   >0 >+1 <<
                          [-L   >0 >-0 <<
    [-----------------------S    0   0
                     [[-]else  >+1     <
                         ]]]]
    >
  ]
  >>>

  Read unsigned bits until LF
  Cells: 0 0 0 opcode 0 0 neg char=0 *continue=0 bit=0 arg=0
  +[-
    <,
                         char cont bit
                          EOF    0
                 [----------L    0
                          [+T  >+1 >+1 <<
    [-----------------------S   >1 >-0 <<
                     [[-]else   >1 >-c <<
                           ]]
    >>+[->[-<++>]<[->+<]]<< If not a comment: double arg and add bit
                           ]]
    >
  ]
  <<

  Negate argument if negative
  Cells: 0 0 0 opcode 0 0 *neg 0 0 0 arg
  [->>>>[-<+>]<[->-<]<<<]
  <<
]

Cells: 0 0 0 opcode *0 0 0 0 0 0 arg
<.>>>>>>>.

Interspersed values:
  inst_op
  inst_arg
  heap_addr
  heap_val
  stack_val
  call_addr
