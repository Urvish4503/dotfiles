#!/bin/bash


# define functions

print_error ()
{
cat << "EOF"
    ./volumecontrol.sh -[device] <actions>
    ...valid device are...
        i   -- input decive
        o   -- output device
        p   -- player application
    ...valid actions are...
        i   -- increase volume [+5]
        d   -- decrease volume [-5]
        m   -- mute [x]
EOF
exit 1
}

notify_vol ()
{
    bar=$(seq -s "." $(($vol / 15)) | sed 's/[0-9]//g')
    dunstify "${vol}${bar}" "${nsink}" -r 91190 -t 800
}

notify_mute ()
{
    mute=$(pamixer "${srce}" --get-mute | cat)
    [ "${srce}" == "--default-source" ] && dvce="mic" || dvce="speaker"
    if [ "${mute}" == "true" ] ; then
        dunstify "muted" "${nsink}" -r 91190 -t 1000
    else
        dunstify "unmuted" "${nsink}" -r 91190 -t 1000
    fi
}

action_pamixer ()
{
    pamixer "${srce}" -"${1}" "${step}"
    vol=$(pamixer "${srce}" --get-volume | cat)
}

action_playerctl ()
{
    [ "${1}" == "i" ] && pvl="+" || pvl="-"
    playerctl --player="${srce}" volume 0.0"${step}""${pvl}"
    vol=$(playerctl --player="${srce}" volume | awk '{ printf "%.0f\n", $0 * 100 }')
}


# eval device option

while getopts iop: DeviceOpt
do
    case "${DeviceOpt}" in
    i) nsink=$(pamixer --list-sources | grep "_input." | tail -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
        [ -z "${nsink}" ] && echo "ERROR: Input device not found..." && exit 0
        ctrl="pamixer"
        srce="--default-source" ;;
    o) nsink=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
        [ -z "${nsink}" ] && echo "ERROR: Output device not found..." && exit 0
        ctrl="pamixer"
        srce="" ;;
    p) nsink=$(playerctl --list-all | grep -w "${OPTARG}")
        [ -z "${nsink}" ] && echo "ERROR: Player ${OPTARG} not active..." && exit 0
        ctrl="playerctl"
        srce="${nsink}" ;;
    *) print_error ;;
    esac
done


# set default variables

shift $((OPTIND -1))
step="${2:-5}"


# execute action

case "${1}" in
    i) action_${ctrl} i ;;
    d) action_${ctrl} d ;;
    m) "${ctrl}" "${srce}" -t && notify_mute && exit 0 ;;
    *) print_error ;;
esac

notify_vol
