#!/bin/bash -x  
echo "Welcome in Gambler Game"

#Constant Variables
declare WIN=1
declare BET=1
declare DAYS=20
declare TOTALSTAKE=1
#Variables
totalGambledAmount=0
totalGambledAmountWon=0
totalGambledAmountLose=0
loselimit=0
winlimit=0
cash=0
continuePlay=1

#Dictionary
declare -A monthHistory

function limit()
{
	calc=$(( $TOTALSTAKE / 2 ))
	loselimit=$(( $TOTALSTAKE - $calc ))
	winlimit=$(( $TOTALSTAKE + $calc ))
}


function gamble()
{
	echo "Playing for Month "
	for (( i=1; i<=$DAYS; i++ ))
	do
		cash=$TOTALSTAKE
		limit
		echo "Todays cash : " $cash
		echo "Todays goal : " $winlimit
		echo "Todays breakout : " $loselimit
		while [[ $cash -gt $loselimit ]] && [[ $cash -lt $winlimit ]]
		do
			winOrlose
			echo DAYS:$i $cash
		done
		echo "Gambling limit for the day reached.." $cash
		monthHistory $TOTALSTAKE  $cash $i
	done
	echo "Total Gambled Amount:" $totalGambledAmount
}


function monthHistory()
{
	if [ $2 -ge $1 ]
	then
		difference=$(( $2 - $1 ))
		monthHistory["DAYS"$3]=$difference
		totalGambledAmountWon=$(( $totalGambledAmountWon + $difference ))
	else
		difference="-"$(( $1 - $2 ))
		monthHistory["DAYS"$3]=$difference
		totalGambledAmountLose=$(( $totalGambledAmountlose + $difference ))
	fi
	totalGambledAmount=$(( $totalGambledAmount + $difference ))
}

function winOrlose()
{
	check=$((RANDOM%2))
	if [ $check -eq $WIN ]
	then
		cash=$(( $cash+$BET ))
	else
		cash=$(( $cash-$BET ))
	fi
}

function daysWonOrLose()
{
	echo "Days Won And Lose in a month"
	for DAYS in ${!monthHistory[@]}
	do
		echo $DAYS" : "${monthHistory["$DAYS"]}
	done
}

function findLuckyUnluckyDay()
{
	luckyDay=$(printf "%s\n"  ${monthHistory[@]} | sort -nr | head -1 )
	unluckyDay=$(printf "%s\n"  ${monthHistory[@]} | sort -n | head -1 )
	printLuckyUnluckyDay $luckyDay $unluckyDay
}

function printLuckyUnluckyDay()
{
	for day in ${!monthHistory[@]}
	do
		if [ ${monthHistory["$DAYS"]} -eq $1 ]
		then
			echo "LuckyDay :" $DAYS ":" ${monthHistory["$DAYS"]}
		fi
		if [ ${monthHistory["$DAYS"]} -eq $2 ]
		then
			echo "UnluckyDay :" $DAYS ":" ${monthHistory["$DAYS"]}
		fi
	done
}

	gamble
        daysWonOrLose
        findLuckyUnluckyDay


#Main Program Starts
while [ $continuePlay -eq 1 ]
do
	if [[ $totalGambledAmountWon -lt 0  ]] || [[ $month -eq 1 ]]
	then
		echo "terminated"
		break
	else
		read -p "Would you like to continue playing the Game? press 1 for yes : " userInput
		if [ $userInput -eq 1 ]
		then
			month=$(( $month - 1))
		else
			break
		fi
	fi
done
