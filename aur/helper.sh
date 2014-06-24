first_log="true"
logfile="update.log"

# Write message to log file
log() {
    local mesg=$1; shift
    if [ "${first_log}" = "true" ]; then
        printf "${mesg}\n" "$@" >${logfile}
        first_log="false"
    else
        printf "${mesg}\n" "$@" >>${logfile}
    fi
}
log_success() {
    log "[SUCCESS]  $@"
}
log_failed() {
    log "[FAILED]   $@"
}
