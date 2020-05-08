#!/bin/bash

function msg() {
  echo "==========================================="
  echo "Fast Food Ranker - By David W. Arnold"
  echo "==========================================="
  echo "For when you can't decide on a fast food option,"
  echo "provide me with options and I'll randomly rank them for you :)"
  echo ""
  echo "- One food option per line."
  echo "- Press \"Enter\" to start a new line."
  echo "- To cease input, press \"Enter\" on a blank line."
  echo ""
  echo "(Example input:)"
  echo "" # "$ ./$(echo "$0" | sed "s/.*\///")"
  echo "Pizza"
  echo "Indian"
  echo "Fish and Chips"
  echo "Chinese"
  echo ""
  echo "(To exit script press: \"Ctrl + c\")"
  echo ""
  echo "-- Type your food options for ranking: --"
}

function readLine() {
  while IFS= read -r line; do
    if [ "" == "$line" ]; then
      break
    fi
    foods+=("$line")
  done
}

function addOptMsg() {
  if [ "$1" -eq 4 ]; then
    echo "-- Addition options --"
  fi
}

function removeFood() {
  new_array=()
  for value in "${foods[@]}"; do
    if [ "$value" != "$FOOD" ]; then
      new_array+=("$value")
    fi
  done
  foods=("${new_array[@]}")
}

function randomRanks() {
  RANDOM=$$
  echo "-- Top 3 options --"
  index=1
  for food in "${foods[@]}"; do
    addOptMsg "$index"
    Y="${#foods[@]}"
    R=$((RANDOM % Y))
    FOOD="${foods[$R]}"
    echo "$index) $FOOD"
    removeFood "$FOOD"
    index=$((index + 1))
  done
  echo ""
}

function errMsg() {
  echo "-- Warning Message: --"
  echo "I can't find any food option :("
  echo ""
  msg
}

msg
foods=()
while true; do
  readLine
  if [ ${#foods[@]} -gt 0 ]; then
    randomRanks
    break
  else
    errMsg
  fi
done
