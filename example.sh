#! /bin/bash

shell=$(ps -p $$ | grep sh | sed 's/.* -*//')
if [ "$shell" = "sh" ]; then
	. task-logger.sh
else
	source task-logger.sh
fi

info "Hello There"
warning "Make sure all computers are turned on before going on"

important "Logs will be available at $LOG_DIR"

#read -p "<Press ENTER to continue>"

WORKING=turning_circle
WORKING_END=turning_circle_end

working -n "Taking a nap"
log_cmd sleep1 sleep 3 || ko

space_print() {
	printf " "
}
crit() {
	sleep 1
	printf "Hello world 1"
	echo
	echo "This log from critical task"
	sleep 1
}

WORKING=space_print
WORKING_END=true

working -n "Failing a command"
log_cmd fail idontexist || ko

working -n "Failing a command but it's ok"
log_cmd warn idontexist || warn

WORKING=turning_circle
WORKING_END=turning_circle_end

working -n "This is a critical task"
log_cmd -c crit crit || warn

finish
