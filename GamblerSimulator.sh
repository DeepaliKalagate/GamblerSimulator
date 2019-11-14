#!/bin/bash -x
echo "Welcome in Gambler Game"

STAKE=100
BET=1
win=0

function gamble()
{
        bet=$((RANDOM%2))
        if [ $bet -eq $win ]
        then
                STAKE=$(( $STAKE+1 ))
        else
                STAKE=$(( $STAKE-1 ))
        fi
}
gamble

