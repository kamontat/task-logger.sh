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

WORKING=circle

working -n "Taking a nap"
log_cmd sleep1 sleep 4 || ko

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
sleep_and_dead() {
	sleep 3
	return 1
}

LOOP_SECONDS=1
WORKING=dot

working -n "Failing a command"
log_cmd fail sleep_and_dead || ko

LOOP_SECONDS=0.2
WORKING=random

working -n "Failing a command but it's ok"
log_cmd warn sleep_and_dead || warn

LOOP_SECONDS=0.2
WORKING=spinner

working -n "This is a critical task"
log_cmd -c crit crit || warn

finish
