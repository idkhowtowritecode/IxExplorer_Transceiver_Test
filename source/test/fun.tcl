proc timeFormatLog {msg} {
    set timeFormat [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]
    return "\[$timeFormat\] $msg"
}