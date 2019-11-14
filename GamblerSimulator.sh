#!/bin/bash -x  
echo "Welcome in Gambler Game"

STAKE=100
BET=1
win=0
winCount=0
winLimit=0
loseLimit=0
stakeOfGame=$STAKE
stakeLimit=50
totalDays=20

stake=$(( ($stakeOfGame * stakeLimit) / 100 ))
loseLimit=$(($stakeOfGame-$stake))
winLimit=$(($stakeOfGame+$stake ))


function gamble()
{
	totalAmount=0
	for (( day=1; day<=$totalDays; day++ ))
	do
		STAKE=100
		while [ true ]
		do
			if [ $STAKE -gt $winLimit ] || [ $STAKE -lt $loseLimit ]
         then
            toContinue="Resign for the day"
            break
         fi

      		bet=$((RANDOM%2))
      		if [ $bet -eq $win ]
        		then
            	STAKE=$(($STAKE+1))
					((winCount++))
        		else
               STAKE=$(($STAKE-1))
					((winCount--))
        		fi
				 echo "winCount" $winCount
		done
	totalAmount=$(($totalAmount+$winCount)) 
	done
}
gamble

