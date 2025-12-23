#!/bin/bash
trap "exit 1" INT
choice=""
dir1="./ogg/FIRE"
dir2="./ogg/RAIN"
dir3="./ogg/SUNIK"
dir4="./ogg/XENO"
dir5="./ogg/CAVE"
dir6="./ogg/CRYSTAL"
dir7="./ogg/WOOD"
dir8="./ogg/WATERFALL"
dir9="./ogg/SEA"
dir10="./ogg/AQUA"
dir=""
USER_INPUT=""
while [[ "$choice" != "q" && "$choice" != "Q" ]]; do
clear
echo "Please make a choice:"
echo -e "1: FIRE 🔥"
echo -e "2: RAIN 💦"
echo -e "3: WATER 💧"
echo -e "4: XENO 🐸"
echo -e "5: CAVE 🪨"
echo -e "6: CRYSTAL 💎"
echo -e "7: BAMBOO 🌿"
echo -e "8: WATERFALL 🏞"
echo -e "9: SEASHORE 🌊"
echo -e "10: AQUATIC 🐬"
echo -e "q: Quit 🚪"
    read -p "Enter your choice: " USER_INPUT

    # Process the user input using a case statement
    case "$USER_INPUT" in
        1)
            echo "You selected Option 1 (CTRL-C exit)"
            dir=$dir1
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional, depends on use case)
            ;;
        2)
            echo "You selected Option 2 (CTRL-C exit)"
            dir=$dir2
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        3)
            echo "You selected Option 3 (CTRL-C exit)"
            dir=$dir3
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        4)
            echo "You selected Option 4 (CTRL-C exit)"
            dir=$dir4
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        5)
            echo "You selected Option 5 (CTRL-C exit)"
            dir=$dir5
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        6)
            echo "You selected Option 6 (CTRL-C exit)"
            dir=$dir6
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        7)
            echo "You selected Option 7 (CTRL-C exit)"
            dir=$dir7
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        8)
            echo "You selected Option 8 (CTRL-C exit)"
            dir=$dir8
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        9)
            echo "You selected Option 9 (CTRL-C exit)"
            dir=$dir9
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        10)
            echo "You selected Option 10 (CTRL-C exit)"
            dir=$dir10
            choice="q" # Set CHOICE to "q" to break the loop after the action (optional)
            ;;
        [qQ])
            echo "Quitting script."
            choice="q" # Set CHOICE to "q" to break the loop
            ;;
        *)
            echo "Invalid choice: $USER_INPUT"
            echo "Please try again."
            ;;
    esac
    echo "" # Add a newline for readability
done

cd $dir
for f in *.ogg; do
    if [ -f "$f" ]; then
nice -n -20 ffplay  -loop 0  -af "volume=0.5"  -nodisp -autoexit "$f" > /dev/null 2>&1 &
fi
done

if pgrep ffplay > /dev/null; then

function start_spinner {
    set +m
    echo -n "$1"
    { while : ; do for X in 'Playing     ' 'Playing.    ' 'Playing..   ' 'Playing...  ' 'Playing.... ' 'Playing.....'; do echo -en "\r$X" ; sleep 1 ; done ; done & } 2>/dev/null



spinner_pid=$!
}

function stop_spinner {
    { kill -9 $spinner_pid && wait; } 2>/dev/null
    set -m
    echo -en "\033[2K\r"
}
trap cleanup SIGINT
spinner_pid=
start_spinner ""
wait
kill "$spinner_pid" &>/dev/null

fi

wait

