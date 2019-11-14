#!/bin/bash -x 
echo "Welcome in Gambler Game"

STAKE=100
BET=1
win=0
winLimit=0
loseLimit=0
stakeOfGame=$STAKE

stake=$(( ($stakeOfGame * 50) / 100 ))
loseLimit=$(($stakeOfGame - $stake ))
winLimit=$(( $stakeOfGame + $stake ))


function gamble()
{
	while [[ true ]]
	do
		if [[ $stakeOfGame -gt $loseLimit ]] && [[ $stakeOfGame -lt $winLimit ]]
		then
			break
      bet=$((RANDOM%2))
      	if [ $bet -eq $win ]
        	then
               		STAKE=$(( $STAKE+1 ))
			break
        	else
                	STAKE=$(( $STAKE-1 ))
        	fi
		fi
	done
}
gamble

