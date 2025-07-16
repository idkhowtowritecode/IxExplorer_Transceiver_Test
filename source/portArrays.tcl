# portArrays.tcl
# This file defines the port arrays used in the test setup.
# It contains an array that maps combinations of test modes, serdes types, test speeds, and ports to their respective fanout values.
# The fanout values are used to determine the port list for each test configuration.
array set port_list {
	Framed,112,800,1 "1"
	Framed,112,800,2 "2"
	Framed,112,800,3 "3"
	Framed,112,800,4 "4"
	Framed,112,800,5 "5"
	Framed,112,800,6 "6"
	Framed,112,800,7 "7"
	Framed,112,800,8 "8"
	Unframed,112,800,1 "1"
	Unframed,112,800,2 "2"
	Unframed,112,800,3 "3"
	Unframed,112,800,4 "4"
	Unframed,112,800,5 "5"
	Unframed,112,800,6 "6"
	Unframed,112,800,7 "7"
	Unframed,112,800,8 "8"
	Framed,112,400,1 "9 10"
	Framed,112,400,2 "11 12"
	Framed,112,400,3 "13 14"
	Framed,112,400,4 "15 16"
	Framed,112,400,5 "17 18"
	Framed,112,400,6 "19 20"
	Framed,112,400,7 "21 22"
	Framed,112,400,8 "23 24"
	Framed,112,200,1 "25 26 27 28"
	Framed,112,200,2 "29 30 31 32"
	Framed,112,200,3 "33 34 35 36"
	Framed,112,200,4 "37 38 39 40"
	Framed,112,200,5 "41 42 43 44"
	Framed,112,200,6 "45 46 47 48"
	Framed,112,200,7 "49 50 51 52"
	Framed,112,200,8 "53 54 55 56"
	Framed,112,100,1 "57 58 59 60 61 62 63 64"
	Framed,112,100,2 "65 66 67 68 69 70 71 72"
	Framed,112,100,3 "73 74 75 76 77 78 79 80"
	Framed,112,100,4 "81 82 83 84 85 86 87 88"
	Framed,112,100,5 "89 90 91 92 93 94 95 96"
	Framed,112,100,6 "97 98 99 100 101 102 103 104"
	Framed,112,100,7 "105 106 107 108 109 110 111 112"
	Framed,112,100,8 "113 114 115 116 117 118 119 120"
	Framed,56,400,1 "121"
	Framed,56,400,2 "122"
	Framed,56,400,3 "123"
	Framed,56,400,4 "124"
	Framed,56,400,5 "125"
	Framed,56,400,6 "126"
	Framed,56,400,7 "127"
	Framed,56,400,8 "128"
	Unframed,56,400,1 "1"
	Unframed,56,400,2 "2"
	Unframed,56,400,3 "3"
	Unframed,56,400,4 "4"
	Unframed,56,400,5 "5"
	Unframed,56,400,6 "6"
	Unframed,56,400,7 "7"
	Unframed,56,400,8 "8"
	Framed,56,200,1 "129 130"
	Framed,56,200,2 "131 132"
	Framed,56,200,3 "133 134"
	Framed,56,200,4 "135 136"
	Framed,56,200,5 "137 138"
	Framed,56,200,6 "139 140"
	Framed,56,200,7 "141 142"
	Framed,56,200,8 "143 144"
	Framed,56,100,1 "145 146 147 148"
	Framed,56,100,2 "149 150 151 152"
	Framed,56,100,3 "153 154 155 156"
	Framed,56,100,4 "157 158 159 160"
	Framed,56,100,5 "161 162 163 164"
	Framed,56,100,6 "165 166 167 168"
	Framed,56,100,7 "169 170 171 172"
	Framed,56,100,8 "173 174 175 176"
	Framed,56,50,1 "177 178 179 180 181 182 183 184"
	Framed,56,50,2 "185 186 187 188 189 190 191 192"
	Framed,56,50,3 "193 194 195 196 197 198 199 200"
	Framed,56,50,4 "201 202 203 204 205 206 207 208"
	Framed,56,50,5 "209 210 211 212 213 214 215 216"
	Framed,56,50,6 "217 218 219 220 221 222 223 224"
	Framed,56,50,7 "225 226 227 228 229 230 231 232"
	Framed,56,50,8 "233 234 235 236 237 238 239 240"
	Framed,28,200,1 "241"
	Framed,28,200,2 "242"
	Framed,28,200,3 "243"
	Framed,28,200,4 "244"
	Framed,28,200,5 "245"
	Framed,28,200,6 "246"
	Framed,28,200,7 "247"
	Framed,28,200,8 "248"
	Unframed,28,200,1 "1"
	Unframed,28,200,2 "2"
	Unframed,28,200,3 "3"
	Unframed,28,200,4 "4"
	Unframed,28,200,5 "5"
	Unframed,28,200,6 "6"
	Unframed,28,200,7 "7"
	Unframed,28,200,8 "8"
	Framed,28,100,1 "249 250"
	Framed,28,100,2 "251 252"
	Framed,28,100,3 "253 254"
	Framed,28,100,4 "255 256"
	Framed,28,100,5 "257 258"
	Framed,28,100,6 "259 260"
	Framed,28,100,7 "261 262"
	Framed,28,100,8 "263 264"
	Unframed,28,100,1 "1"
	Unframed,28,100,2 "2"
	Unframed,28,100,3 "3"
	Unframed,28,100,4 "4"
	Unframed,28,100,5 "5"
	Unframed,28,100,6 "6"
	Unframed,28,100,7 "7"
	Unframed,28,100,8 "8"
	Framed,28,50,1 "265 266 267 268"
	Framed,28,50,2 "269 270 271 272"
	Framed,28,50,3 "273 274 275 276"
	Framed,28,50,4 "277 278 279 280"
	Framed,28,50,5 "281 282 283 284"
	Framed,28,50,6 "285 286 287 288"
	Framed,28,50,7 "289 290 291 292"
	Framed,28,50,8 "293 294 295 296"
	Framed,28,25,1 "297 298 299 300 301 302 303 304"
	Framed,28,25,2 "305 306 307 308 309 310 311 312"
	Framed,28,25,3 "313 314 315 316 317 318 319 320"
	Framed,28,25,4 "321 322 323 324 325 326 327 328"
	Framed,28,25,5 "329 330 331 332 333 334 335 336"
	Framed,28,25,6 "337 338 339 340 341 342 343 344"
	Framed,28,25,7 "345 346 347 348 349 350 351 352"
	Framed,28,25,8 "353 354 355 356 357 358 359 360"
	Framed,28,40,1 "361 362"
	Framed,28,40,2 "363 364"
	Framed,28,40,3 "365 366"
	Framed,28,40,4 "367 368"
	Framed,28,40,5 "369 370"
	Framed,28,40,6 "371 372"
	Framed,28,40,7 "373 374"
	Framed,28,40,8 "375 376"
	Framed,28,10,1 "377 378 379 380 381 382 383 384"
	Framed,28,10,2 "385 386 387 388 389 390 391 392"
	Framed,28,10,3 "393 394 395 396 397 398 399 400"
	Framed,28,10,4 "401 402 403 404 405 406 407 408"
	Framed,28,10,5 "409 410 411 412 413 414 415 416"
	Framed,28,10,6 "417 418 419 420 421 422 423 424"
	Framed,28,10,7 "425 426 427 428 429 430 431 432"
	Framed,28,10,8 "433 434 435 436 437 438 439 440"

    Framed,sert,100,1 "1"
    Framed,sert,100,2 "2"
    Framed,sert,100,3 "3"
    Framed,sert,100,4 "4"
    Framed,sert,100,5 "5"
    Framed,sert,100,6 "6"
    Framed,sert,100,7 "7"
    Framed,sert,100,8 "8"
    Framed,sert,100,9 "9"
    Framed,sert,100,10 "10"
    Framed,sert,100,11 "11"
    Framed,sert,100,12 "12"
    Framed,sert,25,1 "13 14 15 16"
    Framed,sert,25,2 "17 18 19 20"
    Framed,sert,25,3 "21 22 23 24"
    Framed,sert,25,4 "24 25 26 27"
    Framed,sert,25,5 "29 30 31 32"
    Framed,sert,25,6 "33 34 35 36"
    Framed,sert,25,7 "37 38 39 40"
    Framed,sert,25,8 "41 42 43 44"
    Framed,sert,25,9 "45 46 47 48"
    Framed,sert,25,10 "49 50 51 52"
    Framed,sert,25,11 "53 54 55 56"
    Framed,sert,25,12 "57 58 59 60"
    Framed,sert,10,1 "13 14 15 16"
    Framed,sert,10,2 "17 18 19 20"
    Framed,sert,10,3 "21 22 23 24"
    Framed,sert,10,4 "24 25 26 27"
    Framed,sert,10,5 "29 30 31 32"
    Framed,sert,10,6 "33 34 35 36"
    Framed,sert,10,7 "37 38 39 40"
    Framed,sert,10,8 "41 42 43 44"
    Framed,sert,10,9 "45 46 47 48"
    Framed,sert,10,10 "49 50 51 52"
    Framed,sert,10,11 "53 54 55 56"
    Framed,sert,10,12 "57 58 59 60"
    Framed,sert,50,1 "61 62"
    Framed,sert,50,2 "63 64"
    Framed,sert,50,3 "65 66"
    Framed,sert,50,4 "67 68"
    Framed,sert,50,5 "69 70"
    Framed,sert,50,6 "71 72"
    Framed,sert,50,7 "73 74"
    Framed,sert,50,8 "75 76"
    Framed,sert,50,9 "77 78"
    Framed,sert,50,10 "79 80"
    Framed,sert,50,11 "81 82"
    Framed,sert,50,12 "83 84"
}


 array set txPrbsPattern {
    PRBS-7       24
    PRBS-9       25
    PRBS-11      12    
    PRBS-15      13
    PRBS-13      30
    PRBS-20      14
    PRBS-23      15
    PRBS-31      11
    PRBS-7INV    16
    PRBS-9INV    17
    PRBS-11INV   4    
    PRBS-15INV   5
    PRBS-13INV   22
    PRBS-20INV   6
    PRBS-23INV   7
    PRBS-31INV   3
}

 array set rxPrbsPattern {
    PRBS-7       24
    PRBS-9       25
    PRBS-11      12    
    PRBS-15      13
    PRBS-13      30
    PRBS-20      14
    PRBS-23      15
    PRBS-31      11
    PRBS-7INV    16
    PRBS-9INV    17
    PRBS-11INV   4    
    PRBS-15INV   5
    PRBS-13INV   22
    PRBS-20INV   6
    PRBS-23INV   7
    PRBS-31INV   3
    Auto        32
}

array set lockLostIcon {
    0 Yes
    2 No
    3 Pre
}