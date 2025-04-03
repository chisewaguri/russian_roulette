#!/bin/sh
# action.sh
# this is part of russian roulette

MODDIR="/data/adb/modules/roulette"
PERSIST_DIR="/data/adb/roulette"
SAVE_FILE="$PERSIST_DIR/chamber.txt"

# if the file doesn't exist or is invalid, start with 6 chambers
if [ ! -f "$SAVE_FILE" ] || ! CHAMBERS=$(cat "$SAVE_FILE" 2>/dev/null); then
    CHAMBERS=6
fi

# ensure chambers are within 1-6 (prevent weird corruption)
if [ "$CHAMBERS" -lt 1 ] || [ "$CHAMBERS" -gt 6 ]; then
    CHAMBERS=6
fi

# only spin the cylinder when starting fresh
if [ "$CHAMBERS" -eq 6 ]; then
    echo "spinning the cylinder..."
    sleep 1
fi

echo "click... click... click..."
sleep 1

SHOT=$(( RANDOM % CHAMBERS ))

if [ "$SHOT" -eq 0 ]; then
    echo "you've dead"
    rm -f "$SAVE_FILE"  # reset the game
    exit 1
fi

CHAMBERS=$(( CHAMBERS - 1 ))

# if all rounds are survived, reset the game
if [ "$CHAMBERS" -eq 0 ]; then
    echo "you've survived all rounds. luck or fate?"
    rm -f "$SAVE_FILE"
else
    echo "$CHAMBERS" > "$SAVE_FILE"  # save progress
    echo "you survived this round... next shot: 1 in $CHAMBERS"
fi

# EOF