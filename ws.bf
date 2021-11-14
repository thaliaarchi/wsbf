[ Copyright (c) 2021 Andrew Archibald                                 ]
[                                                                     ]
[ This Source Code Form is subject to the terms of the Mozilla Public ]
[ License, v. 2.0. If a copy of the MPL was not distributed with this ]
[ file, You can obtain one at https://mozilla.org/MPL/2.0/.           ]

Encode instructions in trinary with leading 1:
char acc triple_flag
>+>+<<,[
  >>[-<[->+++<]>[-<+>]]+<< Triple acc if last char valid
                   --------- T 0
                      [->++< L 2
  [---------------------->-< S 1
                  [[-]>>-<-< Bad char
                         ]]]
  ,
]

                                           id b10 base3 tok  inst
                         ------------->+<  1  13  111   SS   push n
                       [-------------->+<  2  27  1000  TTT  retrieve
                                    [->+<  3  28  1001  TTS  store
                            [--------->+<  4  37  1101  STS  copy n
                                    [->+<  5  38  1102  STL  slide n
                                 [---->+<  6  42  1120  SLT  swap
                                    [->+<  7  43  1121  SLS  dup
                                    [->+<  8  44  1122  SLL  drop
                                    [->+<  9  45  1200  LTT  jn l
                                    [->+<  10 46  1201  LTS  jz l
                                    [->+<  11 47  1202  LTL  ret
                                    [->+<  12 48  1210  LST  call l
                                    [->+<  13 49  1211  LSS  label l
                                    [->+<  14 50  1212  LSL  jmp l
                                  [--->+<  15 53  1222  LLL  end
[------------------------------------->+<  16 90  10100 TSTT mod
                                    [->+<  17 91  10101 TSTS div
                                   [-->+<  18 93  10110 TSST sub
                                    [->+<  19 94  10111 TSSS add
                                    [->+<  20 95  10112 TSSL mul
                                 [---->+<  21 99  10200 TLTT readi
                                    [->+<  22 100 10201 TLTS readc
                                   [-->+<  23 102 10210 TLST printi
                                    [->+<  24 103 10211 TLSS printc
                                [[-]>[-]<  0
                 ]]]]]]]]]]]]]]]]]]]]]]]]

Interspersed values:
  inst_op
  inst_arg
  heap_addr
  heap_val
  stack_val
  call_addr
