#!/bin/bash

version='1.10.0'

echo "New Version : "$version

regex="([0-9]*)\.([0-9]*)\.([0-9]*)"
if [[ $version =~ $regex ]]; then
  # Mean that the third number is not the one that need to be decrease
  if [[ ${BASH_REMATCH[3]} == 0 ]]; then
    # Mean that the second number is not the one that need to be decrease
    if [[ ${BASH_REMATCH[2]} == 0 ]]; then
      # Mean that the first number is not the one that need to be decrease
      if [[ ${BASH_REMATCH[1]} == 0 ]]; then
        echo "This is the first version 0.0.0"
      else
        echo "Decrease the first number"
        PreviousVersion=$((${BASH_REMATCH[1]} -1 )).${BASH_REMATCH[2]}.${BASH_REMATCH[3]}
      fi
    else
      echo "Decrease the second number"
      PreviousVersion=${BASH_REMATCH[1]}.$((${BASH_REMATCH[2]} -1 )).${BASH_REMATCH[3]}
    fi
  else
    echo "Decrease the first number"
    PreviousVersion=${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.$((${BASH_REMATCH[3]} -1 ))
  fi
fi

echo "Previous Version : "$PreviousVersion
