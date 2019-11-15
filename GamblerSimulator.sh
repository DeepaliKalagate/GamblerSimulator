#!/bin/bash -x  
echo "Welcome in Gambler Game"

declare WIN=1
declare BET=1
declare DAYS=20
declare totalGambledAmount=0
declare totalGambledAmountWon=0
declare totalGambledAmountLose=0
declare loselimit=0
declare winlimit=0
declare TOTALSTAKE=10
declare cash=0
declare counter=1
declare continuePlay=1

declare -A monthHistory

read -p "Enter days to play : " days

while [ $continuePlay -eq 1 ]
do

	read -p "Enter number of games to play per day : " gamesCount

	function limit()
	{
		calc=$(( $TOTALSTAKE / 2 ))
		loselimit=$(( $TOTALSTAKE - $calc ))
		winlimit=$(( $TOTALSTAKE + $calc ))
	}


	function gamble()
	{
		echo "Playing for Month "$counter
		counter=$(($counter+1))
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
				echo day:$i $cash
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
			monthHistory["day"$3]=$difference
			totalGambledAmountWon=$(( $totalGambledAmountWon + $difference ))
		else
			difference="-"$(( $1 - $2 ))
			monthHistory["day"$3]=$difference
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
		for day in ${!monthHistory[@]}
		do
			echo $day" : "${monthHistory["$day"]}
		done
	}

	function FindluckyUnluckyDay()
	{
		luckyDay=$(printf "%s\n"  ${monthHistory[@]} | sort -nr | head -1 )
		unluckyDay=$(printf "%s\n"  ${monthHistory[@]} | sort -n | head -1 )
		PrintLuckyUnluckyDay $luckyDay $unluckyDay
	}

	function PrintLuckyUnluckyDay()
	{
		for day in ${!monthHistory[@]}
		do
			if [ ${monthHistory["$day"]} -eq $1 ]
			then
				echo "LuckyDay :" $day ":" ${monthHistory["$day"]}
			fi
			if [ ${monthHistory["$day"]} -eq $2 ]
			then
				echo "UnluckyDay :" $day ":" ${monthHistory["$day"]}
			fi
		done
	}

	gamble
	daysWonOrLose
	FindluckyUnluckyDay

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
