
source "../portArrays.tcl"
set test_mode "Framed"
set serdes "sert"
set test_speed "10"
set portList {}
# Test setup
set test_ports {1 2 3 4 5 6 7 8 9 10 11 12}
# Code under test
foreach port $test_ports {
    foreach fanout $port_list($test_mode,$serdes,$test_speed,$port) {
        lappend portList "1 1 $fanout"
    }
}

# Test assertion
if {$portList eq {{1 1 9} {1 1 10} {1 1 11} {1 1 12}}} {
    puts "Test passed: portList is correct"
} else {
    puts "Test failed: portList is $portList"
}