set hostname [lindex $argv 0]
set ixos_version [lindex $argv 1]
set tester [lindex $argv 2]
set test_ports [lindex $argv 3]
set test_mode [lindex $argv 4]
set test_speed [lindex $argv 5]
set serdes [lindex $argv 6]
set test_duration [lindex $argv 7]
set test_frameSize_list [lindex $argv 8]
set wait_time_before_startTest [lindex $argv 9]
set log_dir [lindex $argv 10]
set tmp_dir [lindex $argv 11]
set result_option [lindex $argv 12]

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
    Framed,sert,25,1 "13 14"
    Framed,sert,25,2 "15 16"
    Framed,sert,25,3 "17 18"
    Framed,sert,25,4 "19 20"
    Framed,sert,25,5 "21 22"
    Framed,sert,25,6 "23 24"
    Framed,sert,25,7 "25 26"
    Framed,sert,25,8 "27 28"
    Framed,sert,25,9 "29 30"
    Framed,sert,25,10 "31 32"
    Framed,sert,25,11 "33 34"
    Framed,sert,25,12 "35 36"
    Framed,sert,10,1 "13 14"
    Framed,sert,10,2 "15 16"
    Framed,sert,10,3 "17 18"
    Framed,sert,10,4 "19 20"
    Framed,sert,10,5 "21 22"
    Framed,sert,10,6 "23 24"
    Framed,sert,10,7 "25 26"
    Framed,sert,10,8 "27 28"
    Framed,sert,10,9 "29 30"
    Framed,sert,10,10 "31 32"
    Framed,sert,10,11 "33 34"
    Framed,sert,10,12 "35 36"
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

array set maxLane {
    800 32
    400 16
    100 8
}

array set realLane {
    800 8
    400 8
    100 4
}

array set mapLane {
    800 4
    400 2
    100 1
}

array set serdes_mode {
        Framed,112 "{serdesModePam4}"
		Framed,56 "{highStream serdesModePam4Encoding53G}"
		Framed,28 "{highStream serdesModeNrz}"
        Unframed,112 "{bert serdesModePam4}"
        Unframed,56 "{bert serdesModePam4Encoding53G}"
        Unframed,28 "{bert serdesModeNrz}"
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

proc timeFormatLog {msg} {
    set timeFormat [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]
    return "\[$timeFormat\] $msg"
}
#
proc clearOwnershipAndLogout {} {
    global portList
    ixClearOwnership $portList
    ixLogout
    cleanUp
}

proc logAndTakeOwnership {{tester "ixiaTester"}} {
    global portList
    ixLogin $tester
    ixTakeOwnership $portList
}

proc createActivePortList {portId} {
    global port_list serdes test_speed test_mode
    set activePortList []
    foreach port $port_list($test_mode,$serdes,$test_speed,$portId) {
        lappend activePortList "1 1 $port"
    } 
    return $activePortList
}


# switchPortSpeed - switch the port speed of aresone800Gm machine
# need to extend this into sert
proc switchPortSpeed {} {
    global portList tester port_list test_mode serdes_mode serdes test_speed test_ports
    if {$tester == "AresONE800MDUAL"} {
        foreach port $test_ports {
            foreach _fanoutPort $portList {
                scan $_fanoutPort "%d %d %d" chassisId cardId portId
                set first_port [lindex $port_list($test_mode,$serdes,$test_speed,$port) 0]
                if {$portId == $first_port} {
                    resourceGroupEx get $chassisId $cardId $portId
                    resourceGroupEx config -mode $test_speed
                    resourceGroupEx config -attributes $serdes_mode($test_mode,$serdes)
                    resourceGroupEx config -activePortList [createActivePortList $port]
                    if {[resourceGroupEx set $chassisId $cardId $portId]} {
                        logMsg [timeFormatLog "Error calling resourceGroupEx set $chassisId $cardId $portId"]
                        exit $::TCL_ERROR
                    }
                }
            }
        }
    }

    if {$tester == "SERT100G"} {
        resourceGroupEx get 1 1 1
        resourceGroupEx setDefault
        set modeValue [expr {$test_speed * 1000}]
        resourceGroupEx config -mode $modeValue
        resourceGroupEx setAll 1 1
    }
    resourceGroupEx writeAll 1 1
    after 20000
}

proc configPort {} {
    global portList test_mode test_speed maxLane txPrbsPattern rxPrbsPattern prbsPattern
    foreach port $portList {
        scan $port "%d %d %d" chassisId cardId portId
        if {$test_mode == "Unframed"} {
            if {$test_speed == "800"} {
                for {set i 0} {$i < $maxLane($test_speed)} {incr i} {
                    bert setDefault
                    bert config -txPatternIndex         $txPrbsPattern($prbsPattern)
                    bert config -rxPatternIndex         $txPrbsPattern($prbsPattern)

                    if {[bert set $chassisId $cardId $portId $i]} {
                        logMsg [timeFormatLog "Error calling bert set $chassisId $cardId $portId"]
                        exit $::TCL_ERROR
                    }
                }
            }
        } else {
            port get $chassisId $cardId $portId
            port config -enableAutoDetectInstrumentation    true
            port config -autoDetectInstrumentationMode      portAutoInstrumentationModeFloating
            port config -transmitMode                       portTxModeAdvancedScheduler
            port config -receiveMode                        [expr $::portCapture|$::portRxDataIntegrity|$::portRxSequenceChecking|$::portRxModeWidePacketGroup]
            port config -transmitExtendedTimestamp          1
            port config -enableRxNonIEEEPreamble            true

            if {[port set $chassisId $cardId $portId]} {
                logMsg [timeFormatLog "Error calling port set $chassisId $cardId $portId"]
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
                logMsg [timeFormatLog "Error calling autoDetectInstrumentation setRx $chassisId $cardId $portId"]
                exit $::TCL_ERROR
            }
        }
    }
    ixWritePortsToHardware portList
}

proc configStream {} {
    global portList test_mode frameSize
    if {$test_mode == "Unframed"} {
        # BERT Config
        # Nothing
    } else {   
        foreach port $portList {
            scan $port "%d %d %d" chassisId cardId portId
            ### Stream Config ###
            set streamId 1
            stream setDefault
            stream config -framesize                          $frameSize
            stream config -dma                                contPacket
            stream config -ifg                                0.12
            stream config -sa                                 "00 00 00 00 FF 00"
            stream config -da                                 "00 00 00 00 FF 10"
            stream config -enableTimestamp                    true
            stream config -asyncIntEnable                     true
            if {[stream set $chassisId $cardId $portId $streamId]} {
                logMsg [timeFormatLog "Error calling stream set $chassisId $cardId $portId $streamId"]
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
                logMsg [timeFormatLog "Error calling packetGroup setTx $chassisId $cardId $portId $streamId"]
                exit  $::TCL_ERROR
            }
            ### Data Integrity ###
            dataIntegrity setDefault 
            dataIntegrity config -signatureOffset                    12
            dataIntegrity config -signature                          "08 71 18 00"
            dataIntegrity config -insertSignature                    true
            if {[dataIntegrity setTx $chassisId $cardId $portId $streamId]} {
            logMsg [timeFormatLog "Error calling dataIntegrity setTx $chassisId $cardId $portId $streamId"]
            exit  $::TCL_ERROR
            }
            ### Auto Detect Instrumentation ###
            autoDetectInstrumentation setDefault 
            autoDetectInstrumentation config -enableTxAutomaticInstrumentation   true
            #autoDetectInstrumentation config -signature  {87 73 67 49 42 87 11 80 08 71 18 05}
            if {[autoDetectInstrumentation setTx $chassisId $cardId $portId $streamId]} {
                logMsg [timeFormatLog "Error calling autoDetectInstrumentation setTx $chassisId $cardId $portId $streamId"]
                exit  $::TCL_ERROR
            }
        }
        ixWriteConfigToHardware portList -noProtocolServer
    }
}

proc startTest {} {
    global portList test_mode wait_time_before_startTest test_duration
    after [expr $wait_time_before_startTest*1000]
    if {$test_mode == "Unframed"} {
        foreach port $portList {
            scan $port "%d %d %d" chassisId cardId portId
            stat clearBertLane $chassisId $cardId $portId
        }
        logMsg [timeFormatLog "Running Traffic"]
        after [expr $test_duration*1000]
    } else {
        if {[ixStopTransmit portList]} {
            logMsg [timeFormatLog "Error calling ixStopTransmit $portList"]
            exit $::TCL_ERROR
        }
        if {[clearPcsLaneStatistics portList]} {
            logMsg [timeFormatLog "Error calling clearPcsLaneStatistics $portList"]
            exit $::TCL_ERROR
        }
        if {[ixClearPacketGroups portList]} {
            logMsg [timeFormatLog "Error calling ixClearPacketGroups $portList"]
            exit $::TCL_ERROR
        }
        if {[ixClearStats portList]} {
            logMsg [timeFormatLog "Error calling ixClearStats $portList"]
            exit $::TCL_ERROR
        }

        after 2000
        logMsg [timeFormatLog "Running Traffic"]
        if {[ixStartTransmit portList]} {
            logMsg [timeFormatLog "Error calling ixStartTransmit $portList"]
            exit $::TCL_ERROR
        }
        if {[ixStartPacketGroups portList]} {
            logMsg [timeFormatLog "Error calling ixStartPacketGroups $portList"]
            exit $::TCL_ERROR
        }
        if {[ixSetScheduledTransmitTime portList $test_duration]} {
            logMsg [timeFormatLog "Error calling ixSetScheduledTransmitTime $portList"]
            exit $::TCL_ERROR
        }
        after 4000
        
        if {[ixCheckTransmitDone portList]} {
            logMsg [timeFormatLog "Transmit is Done, Wait 4 second for statistics"]
            after 4000
        }
        if {[ixStopPacketGroups portList]} {
            logMsg [timeFormatLog "Error calling ixStopPacketGroup $portList"]
            exit $::TCL_ERROR
        }

        #if [ixStopTransmit portList] {
        #    logMsg [timeFormatLog "Error calling ixStopTransmit $portList"]
        #   exit $::TCL_ERROR
        #}
    }
}

### Port Stats ###
if {$tester == "AresONE800MDUAL"} {
    set portStats(Framed) "link lineSpeed transmitDuration framesSent framesReceived fragments undersize oversizeAndCrcErrors vlanTaggedFramesRx flowControlFrames bitsSent bitsReceived pcsSyncErrorsReceived pcsRemoteFaultsReceived pcsLocalFaultsReceived fecTotalBitErrors fecMaxSymbolErrors fecCorrectedCodewords fecTotalCodewords fecFrameLossRatio preFecBer fecMaxSymbolErrorsBin0 fecMaxSymbolErrorsBin1 fecMaxSymbolErrorsBin2 fecMaxSymbolErrorsBin3 fecMaxSymbolErrorsBin4 fecMaxSymbolErrorsBin5 fecMaxSymbolErrorsBin6 fecMaxSymbolErrorsBin7 fecMaxSymbolErrorsBin8 fecMaxSymbolErrorsBin9 fecMaxSymbolErrorsBin10 fecMaxSymbolErrorsBin11 fecMaxSymbolErrorsBin12 fecMaxSymbolErrorsBin13 fecMaxSymbolErrorsBin14 fecMaxSymbolErrorsBin15 fecUncorrectableCodewords fecTranscodingUncorrectableErrors l1BitsSent l1BitsReceived transceiverTemp encoding fecStatus transceiverVoltage"
} else {
    set portStats(Framed) "link lineSpeed transmitDuration framesSent framesReceived fragments undersize oversizeAndCrcErrors vlanTaggedFramesRx flowControlFrames bitsSent bitsReceived pcsSyncErrorsReceived pcsRemoteFaultsReceived pcsLocalFaultsReceived fecCorrectedCodewords fecTotalCodewords fecFrameLossRatio fecUncorrectableCodewords l1BitsSent l1BitsReceived transceiverTemp transceiverVoltage"
}
set portStats(Unframed) "link transmitState lineSpeed bertBitsSent bertBitsReceived bertBitErrorsReceived bertBitErrorRatio centralTemperature portTemperature pcpuFpgaTemperature bertTransmitDuration encoding transceiverTemp transceiverVoltage"
set portStatsDict [dict create]
proc getPortStats {} {
    global portList tmp_dir portStats portStatsDict test_mode  frameSize

    ixRequestStats portList
    set portJson "\{"
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        statList setDefault
        statList get $chassisId $cardId $portId
        
        set portJson "$portJson\"$chassisId,$cardId,$portId\":\{"
        foreach portStat $portStats($test_mode) {
            puts "$portStat"
            set portStatValue [statList cget "-$portStat"]
            puts "$portStatValue"
            set portStatsDict [dict set portStatsDict "($chassisId,$cardId,$portId)-$portStat" $portStatValue]
            set portJson "$portJson\"$portStat\":\"$portStatValue\","
        }

        ### Latency Stats ###
        packetGroupStats get $chassisId $cardId $portId 1 1
        set portJson "$portJson\"minLatency\":\"[packetGroupStats cget -minLatency]\","
        set portJson "$portJson\"averageLatency\":\"[packetGroupStats cget -averageLatency]\","
        set portJson "$portJson\"maxLatency\":\"[packetGroupStats cget -maxLatency]\","

        set portJson "[string range $portJson 0 end-1]\},"
    }
    set portJson "[string range $portJson 0 end-1]\}"

    if {$test_mode == "Framed"} {
        set portjsonfile [open "[pwd]$tmp_dir/portStats_${frameSize}Byte.json" w+]
    } else {
        set portjsonfile [open "[pwd]$tmp_dir/portStats_BERT.json" w+]
    }
    puts -nonewline $portjsonfile $portJson
    close $portjsonfile
}

### Port PCS Stats ###
set pcsLaneStat "syncHeaderLock pcsLaneMarkerLock pcsLaneMarkerMap relativeLaneSkew syncHeaderErrorCount pcsLaneMarkerErrorCount bip8ErrorCount lostSyncHeaderLock lostPcsLaneMarkerLock fecSymbolErrorCount fecCorrectedBitsCount fecSymbolErrorRate fecCorrectedBitRate"
set pcsLaneStatDict [dict create]
proc getPortPcsLaneStats {} {
    global portList tmp_dir pcsLaneStat pcsLaneStatDict test_mode frameSize

    set pcsJson "\{"
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        set pcsLanes [txLane getLaneList $chassisId $cardId $portId]

        set pcsJson "$pcsJson\"$chassisId,$cardId,$portId\":\["
        foreach pcsLane $pcsLanes {
            pcsLaneStatistics setDefault
            pcsLaneStatistics get $chassisId $cardId $portId
            pcsLaneStatistics getLane $pcsLane

            set pcsJson "$pcsJson\{"
            foreach laneStat $pcsLaneStat {
                set laneStatValue [pcsLaneStatistics cget "-$laneStat"]
                set pcsLaneStatDict [dict set pcsLaneStatDict "$chassisId,$cardId,$portId-Lane$pcsLane-$laneStat" $laneStatValue]
                set pcsJson "$pcsJson\"$laneStat\":\"$laneStatValue\","
            }
            set pcsJson "[string range $pcsJson 0 end-1]\},"

        }
        set pcsJson "[string range $pcsJson 0 end-1]\],"
    }
    set pcsJson "[string range $pcsJson 0 end-1]\}"


    if {$test_mode == "Framed"} {
        set pcsjsonfile [open "[pwd]$tmp_dir/pcsLane_${frameSize}Byte.json" w+]
    } else {
        set pcsjsonfile [open "[pwd]$tmp_dir/pcsLane_BERT.json" w+]
    }
    puts -nonewline $pcsjsonfile $pcsJson
    close $pcsjsonfile
}

### Transceiver DOM Stats ###
set xcvrLaneDOMCaption "portName hostDataPathState hostToMediaLane hostConfigStatus hostTxLos hostTxCdrLol mediaTxOpticalPower txOpticalPowerLimitFlag mediaTxBiasCurrent txBiasCurrentLimitFlag mediaRxOpticalPower rxOpticalPowerLimitFlag mediaRxLos mediaRxCdrLol"
set xcvrDOMCaption "temperatureHighAlarm temperatureHighWarn temperatureLowWarn temperatureLowAlarm temperatureLimitFlag supplyVolHighAlarm supplyVolHighWarn supplyVolLowWarn supplyVolLowAlarm supplyVolLimitFlag txOpticalPowerHighAlarm txOpticalPowerHighWarn txOpticalPowerLowWarn txOpticalPowerLowAlarm txBiasCurrentHighAlarm txBiasCurrentHighWarn txBiasCurrentLowWarn txBiasCurrentLowAlarm rxOpticalPowerHighAlarm rxOpticalPowerHighWarn rxOpticalPowerLowWarn rxOpticalPowerLowAlarm"
set xcvrPropCaption "laneSelectionProperty laneCountProperty manufacturerProperty modelProperty laserOnProperty transceiverPresentProperty transceiverTypeProperty cableLengthProperty serialNumberProperty revComplianceProperty mediaConnectorProperty mediaTechProperty powerClassProperty maxPowerProperty mfgRevProperty firmwareRevProperty hardwareRevProperty dateCodeProperty identifierTypeProperty txPre3TapControlValueProperty txPre3TapControlValueMinProperty txPre3TapControlValueMaxProperty txPre3TapControlValueDefaultProperty txPre2TapControlValueProperty txPre2TapControlValueMinProperty txPre2TapControlValueMaxProperty txPre2TapControlValueDefaultProperty txPreTapControlValueProperty txPreTapControlValueMinProperty txPreTapControlValueMaxProperty txPreTapControlValueDefaultProperty txMainTapControlValueProperty txMainTapControlValueMinProperty txMainTapControlValueMaxProperty txMainTapControlValueDefaultProperty txPostTapControlValueProperty txPostTapControlValueMinProperty txPostTapControlValueMaxProperty txPostTapControlValueDefaultProperty txPost2TapControlValueProperty txPost2TapControlValueMinProperty txPost2TapControlValueMaxProperty txPost2TapControlValueDefaultProperty txPost3TapControlValueProperty txPost3TapControlValueMinProperty txPost3TapControlValueMaxProperty txPost3TapControlValueDefaultProperty precoderControlValueProperty precoderControlValueDefaultProperty rxPrecoderControlValueProperty rxPrecoderControlValueDefaultProperty hwInitControlValueProperty hwInitControlValueDefaultProperty rxOutputAmplitudeControlValueProperty rxOutputAmplitudeControlValueMinProperty rxOutputAmplitudeControlValueMaxProperty rxOutputAmplitudeControlValueDefaultProperty txCdrControlValueProperty txCdrControlValueDefaultProperty rxCdrControlValueProperty rxCdrControlValueDefaultProperty rxOutputPreTapControlValueProperty rxOutputPreTapControlValueMinProperty rxOutputPreTapControlValueMaxProperty rxOutputPreTapControlValueDefaultProperty rxOutputPostTapControlValueProperty rxOutputPostTapControlValueMinProperty rxOutputPostTapControlValueMaxProperty rxOutputPostTapControlValueDefaultProperty explicitControlValueProperty explicitControlValueDefaultProperty appSelRequestValueProperty appSelRequestValueMinProperty appSelRequestValueMaxProperty appSelRequestValueDefaultProperty appSelCurrentValueProperty"
set xcvrDOMDict [dict create]
proc getTransceiverDomStats {} {
    global portList tmp_dir xcvrLaneDOMCaption xcvrDOMCaption xcvrPropCaption xcvrDOMDict test_mode frameSize i2cStats
    
    set domJson "\{"
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        transceiverDOM get $chassisId $cardId $portId

        set domJson "$domJson\"$chassisId,$cardId,$portId\":\{"

        transceiver get $chassisId $cardId $portId
        foreach i2cStat $i2cStats {
            set i2cStaValue [transceiver cget "-$i2cStat"]
            #set i2cStatDict [dict set i2cStatDict "$chassisId,$cardId,$portId-$i2cStat" $i2cStaValue]
            #set xcvrDOMDict [dict set xcvrDOMDict ($chassisId,$cardId,$portId)-$i2cStat $i2cStaValue]
            set domJson "$domJson\"$i2cStat\":\"$i2cStaValue\","
        }

        foreach xcvrProp $xcvrPropCaption {
            set xcvrPropValue [transceiver getValue $xcvrProp]
            #set xcvrDOMDict [dict set xcvrDOMDict ($chassisId,$cardId,$portId)-$xcvrProp $xcvrPropValue]
            set domJson "$domJson\"$xcvrProp\":\"$xcvrPropValue\","
        }

        foreach xcvr $xcvrDOMCaption {
            set xcvrStat [string trim [transceiverDOM getValue $xcvr] "{}"]
            set xcvrDOMDict [dict set xcvrDOMDict ($chassisId,$cardId,$portId)-$xcvr $xcvrStat]
            set domJson "$domJson\"$xcvr\":\"$xcvrStat\","
        }

        foreach xcvrLane $xcvrLaneDOMCaption {
            set xcvrLaneStat [string trim [transceiverDOM getValue $xcvrLane] "{}"]
            set xcvrDOMDict [dict set xcvrDOMDict ($chassisId,$cardId,$portId)-$xcvrLane $xcvrLaneStat]
            set domJson "$domJson\"$xcvrLane\":\["
            foreach xcvrPerLaneStat [lrange [split $xcvrLaneStat ":"] 1 end] {
                set domJson "$domJson\"$xcvrPerLaneStat\","
            }
            set domJson "[string range $domJson 0 end-1]\],"
        }
        set domJson "[string range $domJson 0 end-1]\},"
    }
    set domJson "[string range $domJson 0 end-1]\}"

    if {$test_mode == "Framed"} {
        set domjsonfile [open "[pwd]$tmp_dir/transceiverDOM_${frameSize}Byte.json" w+]
    } else {
        set domjsonfile [open "[pwd]$tmp_dir/transceiverDOM_BERT.json" w+]
    }
    puts -nonewline $domjsonfile $domJson
    close $domjsonfile
}

### Transceiver Application Selection Stats ###
set xcvrAppSel "moduleMediaType hostElectricalIfID hostElectricalIfName hostModulation hostLaneCount hostLaneSpeed hostLaneMap hostLaneGroup mediaIfID mediaIfName mediaLaneCount mediaLaneSpeed mediaLaneMap mediaLaneGroup"
set xcvrAppSelDict [dict create]
set xcvrAppSelPre "portMode appSelId link portModulation portLaneCount portFanouts moduleHostElectricalIfName moduleHostLaneCount moduleHostLaneGroup note"
set xcvrAppSelPreDict [dict create]
set xcvrAppselPreMode "800G-R8 400G-R4 200G-R2 100G-R 400G-R8 200G-R4 100G-R2 50G-R 200G-R8 100G-R4 50G-R2 25G-R"
proc getTransceiverAppSelStats {} {
    global portList tmp_dir xcvrAppSel xcvrAppSelDict xcvrAppSelPre xcvrAppSelPreDict xcvrAppselPreMode
    set appSel "\{"
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        set AppSel_c [transceiverAppSel getCount $chassisId $cardId $portId]

        set appSel "$appSel\"$chassisId,$cardId,$portId\":\{\"transceiverAppSel\":\["
        for {set i 1} {$i <= $AppSel_c} {incr i} {
            transceiverAppSel setDefault
            if [transceiverAppSel get $chassisId $cardId $portId $i] {
                #puts "$chassisId $cardId $portId doesn't have transceiver AppSel with Page$i"
                continue
            }
            set appSel "$appSel\{"
            foreach xcvr $xcvrAppSel {
                set appSelvalue [transceiverAppSel cget "-$xcvr"]
                set xcvrAppSelDict [dict set xcvrAppSelDict "($chassisId,$cardId,$portId)-Page$i:$xcvr" $appSelvalue]
                set appSel "$appSel\"$xcvr\":\"$appSelvalue\","
            }
            set appSel "[string range $appSel 0 end-1]\},"
        }
        set appSel "[string range $appSel 0 end-1]\],"

        set appSel "$appSel\"transceiverAppSelPreview\":\{ "
        foreach speedMode $xcvrAppselPreMode {
            transceiverAppSelPreview setDefault
            if [transceiverAppSelPreview get $chassisId $cardId $portId $speedMode] {
                #puts "$chassisId $cardId $portId doesn't have transceiver AppSel Preview with $speedMode"
                continue
            }
            set appSel "$appSel\"$speedMode\":\{"
            foreach xcvrPre $xcvrAppSelPre {
                set preAppSel [transceiverAppSelPreview cget "-$xcvrPre"]
                set xcvrAppSelPreDict [dict set xcvrAppSelPreDict "($chassisId,$cardId,$portId)_$speedMode:$xcvrPre" $preAppSel]
                set appSel "$appSel\"$xcvrPre\":\"$preAppSel\","
            }
            set appSel "[string range $appSel 0 end-1]\},"
        }
        set appSel "[string range $appSel 0 end-1]\}\},"
    }
    set appSel "[string range $appSel 0 end-1]\}"

    set appseljsonfile [open "[pwd]$tmp_dir/appSel.json" w+]
    puts -nonewline $appseljsonfile $appSel
    close $appseljsonfile
}

### Port BERT Lane Stats ###
set berLaneStats "bertBitsSent bertBitsReceived bertBitErrorsReceived bertPatternLock bertPatternLockLost bertPatternTransmitted bertPatternReceived bertBitErrorRatio bertNumberMismatchedOnes bertMismatchedOnesRatio bertNumberMismatchedZeros bertMismatchedZerosRatio bertPam4SymbolsSent bertPam4SymbolsReceived bertPam4SymbolErrorsReceived bertMismatched00s bertMismatched01s bertMismatched10s bertMismatched11s bertPam4SymbolsErrorsRatio bertMismatched00sRatio bertMismatched01sRatio bertMismatched10sRatio bertMismatched11sRatio bertLockLostCount bertPam4QPattern"
set mapBerLaneStats "bertBitsSent bertBitsReceived bertBitErrorsReceived bertBitErrorRatio bertNumberMismatchedOnes bertMismatchedOnesRatio bertNumberMismatchedZeros bertMismatchedZerosRatio bertPam4SymbolsSent bertPam4SymbolsReceived bertPam4SymbolErrorsReceived bertMismatched00s bertMismatched01s bertMismatched10s bertMismatched11s bertPam4SymbolsErrorsRatio bertMismatched00sRatio bertMismatched01sRatio bertMismatched10sRatio bertMismatched11sRatio"
set berLaneStatDict [dict create]
proc getBertLaneStats {} {
    global portList tmp_dir berLaneStats mapBerLaneStats berLaneStatDict maxLane realLane mapLane test_speed
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        
        for {set berLane 0} {$berLane < $maxLane($test_speed)} {incr berLane}  {
            stat setDefault
            stat getBertLane $chassisId $cardId $portId $berLane

            foreach berLaneStat $berLaneStats {
                set berLaneStatDict [dict set berLaneStatDict "$chassisId,$cardId,$portId-Lane$berLane-$berLaneStat" [stat cget "-$berLaneStat"]]
            }
        }
    }

    set berLaneJson "\{"
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        set berLaneJson "$berLaneJson\"$chassisId,$cardId,$portId\":\["
        for {set mapBerLane 0} {$mapBerLane < $realLane($test_speed)} {incr mapBerLane} {
            
            set berLaneJson "$berLaneJson\{"
            foreach berLaneStat $berLaneStats {
                set mapBerLaneStatArray($mapBerLane) 0
                if {[lsearch -exact $mapBerLaneStats $berLaneStat] >= 0} {
                    if {$test_speed=="800"} {
                        for {set perBerLane 0} {$perBerLane < $mapLane($test_speed)} {incr perBerLane} {
                            set berLane [expr 4*$mapBerLane+$perBerLane]
                            set mapBerLaneStatArray($mapBerLane) [expr $mapBerLaneStatArray($mapBerLane)+[dict get $berLaneStatDict "$chassisId,$cardId,$portId-Lane$berLane-$berLaneStat"]]
                        }
                    } elseif {$test_speed=="400"} {
                        for {set perBerLane 0} {$perBerLane < $mapLane($test_speed)} {incr perBerLane} {
                            set berLane [expr 2*$mapBerLane+$perBerLane]
                            set mapBerLaneStatArray($mapBerLane) [expr $mapBerLaneStatArray($mapBerLane)+[dict get $berLaneStatDict "$chassisId,$cardId,$portId-Lane$berLane-$berLaneStat"]]
                        }
                    }
                    set berLaneJson "$berLaneJson\"$berLaneStat\":\"$mapBerLaneStatArray($mapBerLane)\","
                } else {
                    if {$test_speed=="800"} {
                        set berLane [expr 4*$mapBerLane]
                        set mapBerLaneStatArray($mapBerLane) [dict get $berLaneStatDict "$chassisId,$cardId,$portId-Lane$berLane-$berLaneStat"]
                    } elseif {$test_speed=="400"} {
                        set berLane [expr 2*$mapBerLane]
                        set mapBerLaneStatArray($mapBerLane) [dict get $berLaneStatDict "$chassisId,$cardId,$portId-Lane$berLane-$berLaneStat"]
                    }
                    set berLaneJson "$berLaneJson\"$berLaneStat\":\"$mapBerLaneStatArray($mapBerLane)\","
                }
            }
            set berLaneJson "[string range $berLaneJson 0 end-1]\},"
        }
        set berLaneJson "[string range $berLaneJson 0 end-1]\],"
    }
    set berLaneJson "[string range $berLaneJson 0 end-1]\}"

    set berLanejsonfile [open "[pwd]$tmp_dir/berLane.json" w+]
    puts -nonewline $berLanejsonfile $berLaneJson
    close $berLanejsonfile
}

### Transceiver I2C Stats ###

# CMIS 5.0
set page_list {0x00 0x01 0x10 0x11 0x12 0x24 0x25 0x26 0x27}
set i2cStats "manufacturer model serialNumber"
set i2cStatDict [dict create]
# SFF-8636
# set page_list {0x00 0x01 0x02 0x03}
### Function ###
# Get a management page's deviceNum based on the management version used
proc getDeviceNum {page {msa CMIS5} {addr 0x80}} {
    switch $msa {
        SFF-8472 {
            # SFF-8472 has two devices, 0xA0 (160d) which maps to deviceNum 0, and 0xA2
            (162d)
            #-In order to disambiguate for 0xA2, we'll add +20 to the page number parameter
            set deviceNum [expr {$page >= 20 ? 0xA2 : 0x0}]
        }
        "SFF-8636" -
        "SFF-8436" {
            switch $page {
                "0" -
                "0x00" {set deviceNum [expr {$addr < 0x80 ? 0 : 1}]}
                "1" -
                "0x01" {set deviceNum 2}
                "2" -
                "0x02" {set deviceNum 3}
                "3" -
                "0x03" {set deviceNum 4}
            default {set deviceNum 0}
            }
        }
        CMIS5 {
            # Summary of the CMIS 5 pages
            # Pages 0x00-0x14: Standard CMIS pages
            # Page  0x15     : Timing characteristics
            # Pages 0x20-0x2F: VDM
            # Pages 0x30-0x43: C-CMIS
            # Pages 0x9F-0xAF: CDB (bank 0)
            switch $page {
                "0" -
                "0x00" {set deviceNum [expr {$addr < 0x80 ? 0 : 1}]}
                "1" -
                "0x01" {set deviceNum 2}
                "2" -
                "0x02" {set deviceNum 3}
                "4" -
                "0x04" {set deviceNum 4}
                "16" -
                "0x10" {set deviceNum 5}
                "17" -
                "0x11" {set deviceNum 6}
                "18" -
                "0x12" {set deviceNum 7}
                "19" -
                "0x13" {set deviceNum 8}
                "20" -
                "0x14" {set deviceNum 9}
                "21" -
                "0x15" {set deviceNum 10}
            default {
                if {$page >= 0x20 && $page <= 0x2F} {
                    # VDM 0x20..0x2F map to 11..26
                    set deviceNum [expr {$page-21}]
                    } else {
                        set deviceNum 0
                    }
                }
            }
        }
        CMIS4 {
            # Summary of the CMIS 4 pages
            # Pages 0x00-0x14: Standard CMIS pages
            # Pages 0x20-0x2F: VDM
            # Pages 0x30-0x43: C-CMIS
            # Pages 0x9F-0xAF: CDB (bank 0)
            switch [expr {$page}] {
                "0" - 
                "0x00" {set deviceNum [expr {$addr < 0x80 ? 0 : 1}]}
                "1" - 
                "0x01" {set deviceNum 2}
                "2" - 
                "0x02" {set deviceNum 3}
                "4" - 
                "0x04" {set deviceNum 4}
                "16" -
                "0x10" {set deviceNum 5}
                "17" -
                "0x11" {set deviceNum 6}
                "18" -
                "0x12" {set deviceNum 7}
                "19" -
                "0x13" {set deviceNum 8}
                "20" -
                "0x14" {set deviceNum 9}
                "21" -
                "0x15" {set deviceNum 10}
                default {
                    if {$page >= 0x20 && $page <= 0x2F} {
                        # VDM 0x20..0x2F map to 10..25
                        set deviceNum [expr {$page-22}]
                    } else {
                        set deviceNum 0
                    }
                }
            }
        }
        default {
            # CMIS3
            switch [expr {$page}] {
                0 {set deviceNum [expr {$addr < 0x80 ? 0 : 1}]}
                1 {set deviceNum 2}
                2 {set deviceNum 3}
                16 {set deviceNum 5}
                17 {set deviceNum 6}
            default {set deviceNum 0}
            }
        }
    }
    return $deviceNum
}
# Read one page from transceiver management
proc readTxcvrPage {port page {msa CMIS5} {addr 0x80} {mdioIndex 1}} {
    scan $port {%d %d %d} chassisId cardId portId
    # Configure register access preset of 128 registers
    set deviceNum [getDeviceNum $page $msa $addr]
    miiae setDefault
    miiae presetPage $page
    miiae presetDeviceNumber $deviceNum
    miiae presetBaseRegister $addr
    miiae presetNumberOfRegisters 128
    # Perform read
    if {[miiae get $chassisId $cardId $portId $mdioIndex]} {
        logMsg [timeFormatLog [format "ERROR-Could not read transceiver management on port {$portId}"]]
        exit 1
    }
    miiae getDevice $deviceNum
    return 0
}

# Access a register from a page that has already been read
proc accessTxcvrReg {port addr {page 0} {options None}} {
    scan $port {%d %d %d} chassisId cardId portId
    # (assumes a call to readTxcvrPage has already been done)
    mmd getRegister $addr
    set regName [mmdRegister cget -name]
    set regVal [mmdRegister cget -registerValue]
    scan $regVal %x decVal
    if {$options == "verbose"} {
        puts [format "Page 0x%02X, reg %3d (0x%02X)-%-60s=> 0x%02X" \
                        $page $addr $addr $regName $decVal]
    }
    #puts $i2cJson
    set registerValue ""
    set registerValue "$registerValue\{\"name\":\"$regName\","
    set registerValue "$registerValue\"value\":\"0x$regVal\"\},"
    #set i2cJson "$i2cJson\{\"name\":\"$regName\","
    #set i2cJson "$i2cJson\"value\":\"0x$regVal\"\},"

    return $registerValue
}
proc getI2cStats {} {
    ### Start Read I2C ###
    global portList tmp_dir page_list i2cStats i2cStatDict

    set i2cJson "\{"
    foreach port $portList {
        scan $port {%d %d %d} chassisId cardId portId
        set i2cJson "$i2cJson\"$chassisId,$cardId,$portId\":\{"

        transceiver get $chassisId $cardId $portId
        foreach i2cStat $i2cStats {
            set i2cStaValue [transceiver cget "-$i2cStat"]
            set i2cStatDict [dict set i2cStatDict "$chassisId,$cardId,$portId-$i2cStat" $i2cStaValue]
            set i2cJson "$i2cJson\"$i2cStat\":\"$i2cStaValue\","
        }

        # Decode MSA information from transceiver's RevCompliance
        set msaRev 0.0
        set msaType "Unknown"
        set revCompliance [transceiver getValue revComplianceProperty]
        if {[llength [split $revCompliance " "]] > 1} {
            set revComplianceList [split [lindex $revCompliance 0] " "]
            set msaType [lindex $revComplianceList 0]
            set msaRev  [lindex $revComplianceList 1]
        }
        set i2cJson "$i2cJson\"revCompliance\":\"$revComplianceList\","
        set i2cJson "$i2cJson\"msaType\":\"$msaType\","
        set i2cJson "$i2cJson\"msaRev\":\"$msaRev\","
    
        # Figure-out which MSA to apply
        set msaName "CMIS5"
        switch $msaType {
            SFF-8472 {
                set msaName "SFF-8472"
            }
            SFF-8636 {
                set msaName "SFF-8636"
            }
            CMIS {
                switch $msaRev {
                    "4.1" -
                    "5.0" -
                    "5.1" -
                    "5.2" {
                        set msaName "CMIS5"
                    }
                    4.0 {
                        set msaName "CMIS4"
                    }
                    default {
                        set msaName "CMIS3"
                    }
                }
            }
        }

        foreach page $page_list {
            # Read a transceiver management page on an AresONE platform
            set base_addr 0
            set i2cJson "$i2cJson\"$page\":\["
            if {$page == "0x00"} {
                readTxcvrPage $port $page $msaName $base_addr
                # Now display the registers values from the page that has been read
                set addr_start 0
                set addr_end   127
                for {set addr $addr_start} {$addr <= $addr_end} {incr addr} {
                    set regValue [accessTxcvrReg $port $addr $page]
                    set i2cJson "$i2cJson$regValue"
                }
            }

            set base_addr 128
            readTxcvrPage $port $page $msaName $base_addr

            # Now display the registers values from the page that has been read
            set addr_start 128
            set addr_end   255
            for {set addr $addr_start} {$addr <= $addr_end} {incr addr} {
                    set regValue [accessTxcvrReg $port $addr $page]
                    set i2cJson "$i2cJson$regValue"
            }
            set i2cJson "[string range $i2cJson 0 end-1]\],"
        }
        set i2cJson "[string range $i2cJson 0 end-1]\},"
    }
    set i2cJson "[string range $i2cJson 0 end-1]\}"

    set i2cjsonfile [open "[pwd]$tmp_dir/i2c.json" w+]
    puts -nonewline $i2cjsonfile $i2cJson
    close $i2cjsonfile
}
## getResult
# Collects the results based on the options specified in result_option

proc getResult {index} {
    global result_option test_mode
    foreach option $result_option {
        if {$option == "portStats"} {
            logMsg [timeFormatLog "Collecting $option"]
            getPortStats
        } elseif {$option == "portPcsLaneStats" && $test_mode == "Framed"} {
            logMsg [timeFormatLog "Collecting $option"]
            getPortPcsLaneStats
        } elseif {$option == "transceiverDomStats" && $index == "1"} {
            logMsg [timeFormatLog "Collecting $option"]
            getTransceiverDomStats
        } elseif {$option == "transceiverAppSelStats" && $index == "1"} {
            logMsg [timeFormatLog "Collecting $option"]
            getTransceiverAppSelStats
        } elseif {$option == "bertLaneStats" && $test_mode == "Unframed"} {
            logMsg [timeFormatLog "Collecting $option"]
            getBertLaneStats
        } elseif {$option == "i2cStats" && $index == "1"} {
            logMsg [timeFormatLog "Collecting $option"]
            getI2cStats
        }
    }
}

############################################
############### Test Process ###############
############################################
source "C:/Program Files (x86)/Ixia/IxOS/$ixos_version/TclScripts/bin/IxiaWish.tcl"
package req IxTclHal
enableEvents false
logOn "[pwd]$log_dir/transceivertest.log"
set retCode $::TCL_OK
set portList []
set frameSize ""
set prbsPattern "PRBS-31"
logMsg [timeFormatLog "Start $test_mode Test"]

foreach port $test_ports {
    foreach fanout $port_list($test_mode,$serdes,$test_speed,$port) {
        lappend portList "1 1 $fanout"
    }
}

if {[isUNIX]} {
    set retCode [ixConnectToTclServer $tclsrver]
    if {$retCode != $::TCL_OK} {
        logMsg [timeFormatLog "ConnectToTclServer Fail, Return Code is: $retCode"]
        exit $retCode
    }
}

set recCode [ixConnectToChassis $hostname]
if {$retCode != $::TCL_OK} {
    logMsg [timeFormatLog "ConnectToChassis Fail, Return Code is: $retCode"]
    exit $retCode
}

logAndTakeOwnership $tester

logMsg [timeFormatLog "Switch Speed to ${test_speed}G"]
switchPortSpeed 

logMsg [timeFormatLog "Config Port"]
configPort

if {$test_mode == "Unframed"} {
    configStream

    startTest

    logMsg [timeFormatLog "Collect Result"]
    getResult "1"
} else {
    set _index 1
    foreach frameSize $test_frameSize_list {
        configStream

        startTest 

        logMsg [timeFormatLog "Collect Result"]
        getResult "$_index"
        set _index [expr $_index+1]
    }
}

clearOwnershipAndLogout
