set IxOS_version 10.00.1000.17
source "C:/Program Files (x86)/Ixia/IxOS/$IxOS_version/TclScripts/bin/IxiaWish.tcl"
package require IxTclHal

set hostname "192.168.11.109"
set userName user
set portList {{1 1 1} {1 1 2}}
set retCode $::TCL_OK
set test_duration 30
set test_speed 800
set serdes 112

array set port_list {
	112,800,1 "1"
	112,800,2 "2"
	112,800,3 "3"
	112,800,4 "4"
	112,800,5 "5"
	112,800,6 "6"
	112,800,7 "7"
	112,800,8 "8"
	112,400,1 "9 10"
	112,400,2 "11 12"
	112,400,3 "13 14"
	112,400,4 "15 16"
	112,400,5 "17 18"
	112,400,6 "19 20"
	112,400,7 "21 22"
	112,400,8 "23 24"
	112,200,1 "25 26 27 28"
	112,200,2 "29 30 31 32"
	112,200,3 "33 34 35 36"
	112,200,4 "37 38 39 40"
	112,200,5 "41 42 43 44"
	112,200,6 "45 46 47 48"
	112,200,7 "49 50 51 52"
	112,200,8 "53 54 55 56"
	112,100,1 "57 58 59 60 61 62 63 64"
	112,100,2 "65 66 67 68 69 70 71 72"
	112,100,3 "73 74 75 76 77 78 79 80"
	112,100,4 "81 82 83 84 85 86 87 88"
	112,100,5 "89 90 91 92 93 94 95 96"
	112,100,6 "97 98 99 100 101 102 103 104"
	112,100,7 "105 106 107 108 109 110 111 112"
	112,100,8 "113 114 115 116 117 118 119 120"
	56,400,1 "121"
	56,400,2 "122"
	56,400,3 "123"
	56,400,4 "124"
	56,400,5 "125"
	56,400,6 "126"
	56,400,7 "127"
	56,400,8 "128"
	56,200,1 "129 130"
	56,200,2 "131 132"
	56,200,3 "133 134"
	56,200,4 "135 136"
	56,200,5 "137 138"
	56,200,6 "139 140"
	56,200,7 "141 142"
	56,200,8 "143 144"
	56,100,1 "145 146 147 148"
	56,100,2 "149 150 151 152"
	56,100,3 "153 154 155 156"
	56,100,4 "157 158 159 160"
	56,100,5 "161 162 163 164"
	56,100,6 "165 166 167 168"
	56,100,7 "169 170 171 172"
	56,100,8 "173 174 175 176"
	56,50,1 "177 178 179 180 181 182 183 184"
	56,50,2 "185 186 187 188 189 190 191 192"
	56,50,3 "193 194 195 196 197 198 199 200"
	56,50,4 "201 202 203 204 205 206 207 208"
	56,50,5 "209 210 211 212 213 214 215 216"
	56,50,6 "217 218 219 220 221 222 223 224"
	56,50,7 "225 226 227 228 229 230 231 232"
	56,50,8 "233 234 235 236 237 238 239 240"
	28,200,1 "241"
	28,200,2 "242"
	28,200,3 "243"
	28,200,4 "244"
	28,200,5 "245"
	28,200,6 "246"
	28,200,7 "247"
	28,200,8 "248"
	28,100,1 "249 250"
	28,100,2 "251 252"
	28,100,3 "253 254"
	28,100,4 "255 256"
	28,100,5 "257 258"
	28,100,6 "259 260"
	28,100,7 "261 262"
	28,100,8 "263 264"
	28,50,1 "265 266 267 268"
	28,50,2 "269 270 271 272"
	28,50,3 "273 274 275 276"
	28,50,4 "277 278 279 280"
	28,50,5 "281 282 283 284"
	28,50,6 "285 286 287 288"
	28,50,7 "289 290 291 292"
	28,50,8 "293 294 295 296"
	28,25,1 "297 298 299 300 301 302 303 304"
	28,25,2 "305 306 307 308 309 310 311 312"
	28,25,3 "313 314 315 316 317 318 319 320"
	28,25,4 "321 322 323 324 325 326 327 328"
	28,25,5 "329 330 331 332 333 334 335 336"
	28,25,6 "337 338 339 340 341 342 343 344"
	28,25,7 "345 346 347 348 349 350 351 352"
	28,25,8 "353 354 355 356 357 358 359 360"
	28,40,1 "361 362"
	28,40,2 "363 364"
	28,40,3 "365 366"
	28,40,4 "367 368"
	28,40,5 "369 370"
	28,40,6 "371 372"
	28,40,7 "373 374"
	28,40,8 "375 376"
	28,10,1 "377 378 379 380 381 382 383 384"
	28,10,2 "385 386 387 388 389 390 391 392"
	28,10,3 "393 394 395 396 397 398 399 400"
	28,10,4 "401 402 403 404 405 406 407 408"
	28,10,5 "409 410 411 412 413 414 415 416"
	28,10,6 "417 418 419 420 421 422 423 424"
	28,10,7 "425 426 427 428 429 430 431 432"
	28,10,8 "433 434 435 436 437 438 439 440"
}

proc timeFormatLog {msg} {
    set timeFormat [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]
    return "\[$timeFormat\] $msg"
}

proc createActivePortList {portId} {
    global port_list serdes test_speed
    set activePortList []
    foreach port $port_list($serdes,$test_speed,$portId) {
        lappend activePortList "1 1 $port"
    } 
    return $activePortList
}

if {[ixConnectToChassis $hostname]} {
    exit
}

set loop 1
while true {

    foreach port $portList {
        scan $port "%d %d %d" chassisId cardId portId
        resourceGroupEx get $chassisId $cardId $portId
        resourceGroupEx config -attributes "{bert serdesModePam4}"
        resourceGroupEx config -activePortList [createActivePortList $portId]
        if {[resourceGroupEx set $chassisId $cardId $portId]} {
            logMsg [timeFormatLog "Error calling resourceGroupEx set $chassisId $cardId $portId"]
            exit $::TCL_ERROR
        }
    }
    resourceGroupEx writeAll $chassisId $cardId
    after 20000

    foreach port $portList {
        scan $port "%d %d %d" chassisId cardId portId
        resourceGroupEx get $chassisId $cardId $portId
        resourceGroupEx config -attributes "{serdesModePam4}"
        resourceGroupEx config -activePortList [createActivePortList $portId]
        if {[resourceGroupEx set $chassisId $cardId $portId]} {
            logMsg [timeFormatLog "Error calling resourceGroupEx set $chassisId $cardId $portId"]
            exit $::TCL_ERROR
        }
    }

    resourceGroupEx writeAll $chassisId $cardId
    after 20000

    foreach port $portList {
        scan $port "%d %d %d" chassisId cardId portId
        port get $chassisId $cardId $portId
        port setFactoryDefaults $chassisId $cardId $portId
        port config -enableAutoDetectInstrumentation    true
        port config -autoDetectInstrumentationMode      portAutoInstrumentationModeFloating
        port config -transmitMode                       portTxModeAdvancedScheduler
        port config -receiveMode                        [expr $::portCapture|$::portRxDataIntegrity|$::portRxSequenceChecking|$::portRxModeWidePacketGroup]
        port config -transmitExtendedTimestamp          1
        port config -enableRxNonIEEEPreamble            true

        if {[port set $chassisId $cardId $portId]} {
            puts "Error calling port set $chassisId $cardId $portId"
            exit $::TCL_ERROR
        }
        ### Received Mode ###
        packetGroup setDefault 
        packetGroup config -groupIdMask                        32768
        packetGroup config -enable128kBinMode                  true
        packetGroup config -numTimeBins                        1
        if {[packetGroup setRx $chassisId $cardId $portId]} {
            errorMsg "Error calling packetGroup setRx $chassisId $cardId $portId"
            set retCode $::TCL_ERROR
        }

        dataIntegrity setDefault 
        dataIntegrity config -signature                          "08 71 18 00"
        dataIntegrity config -enableTimeStamp                    true
        if {[dataIntegrity setRx $chassisId $cardId $portId]} {
            errorMsg "Error calling dataIntegrity setRx $chassisId $cardId $portId"
            set retCode $::TCL_ERROR
        }

        autoDetectInstrumentation setDefault 
        autoDetectInstrumentation config -startOfScan                        12
        if {[autoDetectInstrumentation setRx $chassisId $cardId $portId]} {
            puts "Error calling autoDetectInstrumentation setRx $chassisId $cardId $portId"
            exit $::TCL_ERROR
        }
    }
    ixWritePortsToHardware portList

    foreach port $portList {
        scan $port "%d %d %d" chassisId cardId portId
        ### Stream Config ###
        set streamId 1
        stream setDefault
        stream config -framesize                          64
        stream config -dma                                contPacket
        stream config -ifg                                0.12
        stream config -sa                                 "00 00 00 00 FF 00"
        stream config -da                                 "00 00 00 00 FF 00"
        stream config -enableTimestamp                    true
        stream config -asyncIntEnable                     true
        if {[stream set $chassisId $cardId $portId $streamId]} {
            puts "Error calling stream set $chassisId $cardId $portId $streamId"
            exit $::TCL_ERROR
        }
        ### Packet Group ###
        udf setDefault 
        udf config -continuousCount                            true
        udf config -initval                                    {00 00 00 00 }
        packetGroup setDefault 
        packetGroup config -groupIdMask                        32768
        packetGroup config -signatureOffset                    12
        packetGroup config -insertSignature                    true
        packetGroup config -groupId                            1
        packetGroup config -groupIdOffset                      26
        packetGroup config -groupIdMask                        4294934528
        packetGroup config -sequenceNumberOffset               28
        packetGroup config -insertSequenceSignature            true
        packetGroup config -enable128kBinMode                  true
        packetGroup config -numTimeBins                        1
        if {[packetGroup setTx $chassisId $cardId $portId $streamId]} {
            puts "Error calling packetGroup setTx $chassisId $cardId $portId $streamId"
            exit  $::TCL_ERROR
        }
        ### Data Integrity ###
        dataIntegrity setDefault 
        dataIntegrity config -signatureOffset                    12
        dataIntegrity config -signature                          "08 71 18 00"
        dataIntegrity config -insertSignature                    true
        if {[dataIntegrity setTx $chassisId $cardId $portId $streamId]} {
        puts "Error calling dataIntegrity setTx $chassisId $cardId $portId $streamId"
        exit  $::TCL_ERROR
        }
        ### Auto Detect Instrumentation ###
        autoDetectInstrumentation setDefault 
        autoDetectInstrumentation config -enableTxAutomaticInstrumentation   true
        #autoDetectInstrumentation config -signature  {87 73 67 49 42 87 11 80 08 71 18 05}
        if {[autoDetectInstrumentation setTx $chassisId $cardId $portId $streamId]} {
            puts "Error calling autoDetectInstrumentation setTx $chassisId $cardId $portId $streamId"
            exit  $::TCL_ERROR
        }
    }
    ixWriteConfigToHardware portList -noProtocolServer

    if {[ixStopTransmit portList]} {
        puts "Error calling ixStopTransmit $portList"
        exit $::TCL_ERROR
    }
    if {[ixClearPacketGroups portList]} {
        puts "Error calling ixClearPacketGroups $portList"
        exit $::TCL_ERROR
    }
    if {[ixClearStats portList]} {
        puts  "Error calling ixClearStats $portList"
        exit $::TCL_ERROR
    }

    after 2000
    puts  "Running Traffic"
    if {[ixStartTransmit portList]} {
        puts "Error calling ixStartTransmit $portList"
        exit $::TCL_ERROR
    }
    if {[ixStartPacketGroups portList]} {
        puts "Error calling ixStartPacketGroups $portList"
        exit $::TCL_ERROR
    }
    if {[ixSetScheduledTransmitTime portList $test_duration]} {
        puts "Error calling ixSetScheduledTransmitTime $portList"
        exit $::TCL_ERROR
    }
    after 4000
    
    if {[ixCheckTransmitDone portList]} {
        puts "Transmit is Done, Wait 4 second for statistics"
        after 4000
    }
    if {[ixStopPacketGroups portList]} {
        puts "Error calling ixStopPacketGroup $portList"
        exit $::TCL_ERROR
    }

    ixRequestStats portList

    puts "Loop - $loop"
    foreach port $portList {
        scan $port "%d %d %d" chassisId cardId portId
        packetGroupStats get $chassisId $cardId $portId 1 1
        set minLatency [packetGroupStats cget -minLatency]
        set averageLatency [packetGroupStats cget -averageLatency]
        set maxLatency [packetGroupStats cget -maxLatency]
        puts "port-$portId    min: $minLatency, avg: $averageLatency, max: $maxLatency"
    }
    set loop [expr $loop+1]
}