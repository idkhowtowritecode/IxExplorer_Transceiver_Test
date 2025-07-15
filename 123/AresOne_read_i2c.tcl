source "C:/Program Files (x86)/Ixia/IxOS/10.00.1000.17/TclScripts/bin/IxiaWish.tcl"

package require IxTclHal

set userName user
set hostName 192.168.11.121
set port [list 1 1 263]

# CMIS 5.0
set page_list {0x00 0x01 0x10 0x11 0x12 0x24 0x25 0x26 0x27}
# SFF-8636
# set page_list {0x00 0x01 0x02 0x03}

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
    scan $port {%d %d %d} chasId cardId portId
    # Configure register access preset of 128 registers
    set deviceNum [getDeviceNum $page $msa $addr]
    miiae presetPage $page
    miiae presetDeviceNumber $deviceNum
    miiae presetBaseRegister $addr
    miiae presetNumberOfRegisters 128
    # Perform read
    if {[miiae get $chasId $cardId $portId $mdioIndex]} {
        errorMsg [format "ERROR-Could not read transceiver management on port {$port}"]
        return-1
    }
    miiae getDevice $deviceNum
    return 0
}


# Access a register from a page that has already been read
proc accessTxcvrReg {port addr {page 0} {export 1} {options verbose}} {
    scan $port {%d %d %d} chasId cardId portId
    # (assumes a call to readTxcvrPage has already been done)
    mmd getRegister $addr
    set regName [mmdRegister cget -name]
    set regVal [mmdRegister cget -registerValue]
    scan $regVal %x decVal
    if {$options == "verbose"} {
        puts [format "Page 0x%02X, reg %3d (0x%02X)-%-60s=> 0x%02X" \
                        $page $addr $addr $regName $decVal]
    }
    if {$export == 1} {
        global regfile
        puts $regfile [format "Page 0x%02X, reg %3d (0x%02X)-%-60s, 0x%02X" \
                        $page $addr $addr $regName $decVal]
    }
    return $decVal
}


# Connect to chassis and take port ownership
ixConnectToChassis $hostName
ixLogin $userName
ixTakeOwnership [list $port]
# Display Transceiver Info
scan $port {%d %d %d} chasId cardId portId
puts  [format "Transceiver properties of port {%s}:" $port]
transceiver get $chasId $cardId $portId
puts [format "Vendor Name     : %s" [transceiver cget -manufacturer]]
puts [format "Part Number     : %s" [transceiver cget -model]]
puts [format "Serial Number   : %s" [transceiver cget -serialNumber]]
puts [format "Transceiver Type: %s" [transceiver getValue transceiverTypeProperty]]

# Decode MSA information from transceiver's RevCompliance
set msaRev 0.0
set msaType "Unknown"
set revCompliance [transceiver getValue revComplianceProperty]
if {[llength [split $revCompliance " "]] > 1} {
    set revComplianceList [split [lindex $revCompliance 0] " "]
    set msaType [lindex $revComplianceList 0]
    set msaRev  [lindex $revComplianceList 1]
}
puts [format "Rev Compliance  : %s" $revCompliance]
puts [format "MSA Type        : %s" $msaType]
puts [format "MSA Rev         : %s\n" $msaRev]

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
    puts "Reading $msaName page $page of port {$port}..."
    if {$page == "0x00"} {
        readTxcvrPage $port $page $msaName $base_addr
        # Now display the registers values from the page that has been read
        set addr_start 0
        set addr_end   127
        set regfile [open AresOne_reg_$page.csv w+]
        for {set addr $addr_start} {$addr <= $addr_end} {incr addr} {
            set reg_val [accessTxcvrReg $port $addr $page 1 verbose]
        };
        close $regfile
    }

    set base_addr 128
    readTxcvrPage $port $page $msaName $base_addr

    # Now display the registers values from the page that has been read
    set addr_start 128
    set addr_end   255
    if {$page == "0x00"} {
        set regfile [open AresOne_reg_$page.csv a+]
    } else {
        set regfile [open AresOne_reg_$page.csv w+]
    }
    for {set addr $addr_start} {$addr <= $addr_end} {incr addr} {
        set reg_val [accessTxcvrReg $port $addr $page 1 verbose]
    };
    close $regfile
}

ixClearOwnership [list $port]