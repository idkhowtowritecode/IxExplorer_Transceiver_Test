############################################
############### Test Process ###############
############################################
source "utils.tcl"
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
