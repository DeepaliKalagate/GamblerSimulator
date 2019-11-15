#!/bin/bash -x  
echo "Welcome in Gambler Game"

declare -A daywiseAmountTrack

declare BET_AMOUNT=1;
declare WIN=1;
declare DAYS=20;

declare stake=100;
declare maxAllowance=$(( $stake+ (( $stake /2 )) )); 
declare leastAllowance=$(( $stake/2 ))
declare totalAmount=0;
declare initialDayStake=100;
declare dayslost=0;
declare dayswon=0;

function bet()
{
	checkBet=$(( RANDOM % 2 ))
	if [ $checkBet -eq $WIN ]
		then
		stake=$(( $stake + 1 ))
		else
		stake=$(( $stake - 1 ))
	fi
}
function calculativeGame() 
{

	while [[ $stake -lt $maxAllowance ]] && [[ $stake -gt $leastAllowance ]]
	do
		bet
	done
}
function daywiseDictionary()
{

	if [ $stake -eq $leastAllowance ]
          then
          daywiseAmountTrack[$day]=$(($stake-$initialDayStake))
          totalAmount=$(($totalAmount-stake))
			else
          daywiseAmountTrack[$day]=$(($stake-$initialDayStake))
          totalAmount=$(($totalAmount+$stake-$initialDayStake))
	fi
}
function winlostDays()
{
	for dayy in ${!daywiseAmountTrack[@]}
	do
		if [ ${daywiseAmountTrack[$dayy]} -ge $leastAllowance ]
			then
			((dayswon++))
			echo "------day"$dayy "he won" ${daywiseAmountTrack[$dayy]}
			elif [ ${daywiseAmountTrack[$dayy]} -le $leastAllowance ]
			then
			dayslost=$(($dayslost+1))
			echo "------day"$dayy "he lost " ${daywiseAmountTrack[$dayy]}
			fi
	done
}



function 20dayPlay() 
{

   for(( day=1; day <= $DAYS; day++ ))
   do
         echo "--------------day"$day"-------"
         stake=100;
         calculativeGame
         daywiseDictionary
   done
   winlostDays
}

#bet
#calculativeGame
20dayPlay
echo "Max total at the end of he day is=" $totalAmount
echo "Days he won the bets= $dayswon"
echo "Days he lost the bets= $dayslost"
echo ${#daywiseAmountTrack[@]}
