clear
cd ~/Desktop/Stocks
echo "$(tput setaf 2)[System]$(tput sgr0) Starting pull.sh"
echo "$(tput setaf 2)[System]$(tput sgr0) Press Any Key to exit"
echo "$(tput setaf 2)[Quote Name] $(tput sgr0) ---> $(tput setaf 2)[Current Price] $(tput sgr0) ---> $(tput setaf 2)[Total Gain/Loss] $(tput sgr0)"
touch pull.run
while [ true ] ; do
   read -t 1 -n 1
   if [ $? = 0 ] ; then
   	rm -r pull.run
   	echo ""
   	echo "$(tput setaf 2)[System]$(tput sgr0) pull.sh stopped by user"
      exit ;
   else
   	touch total.txt
   	QUOTECOUNT=$(awk 'END {print NR}' list.txt)
   	for i in `seq 1 $QUOTECOUNT`;
   	do
         #Gets the name of the Stock (AAPL)
   		QUOTENAME1=$(sed -n $i\p list.txt)
         #Gets the price per trade (5)
   		COMMISION=$(sed -n 1\p info.txt)
   		cd Quotes/"$QUOTENAME1"
         #Gets the price you paid for the stock (100)
   		BOUGHTAT=$(sed -n 1\p buy.txt)
         #Gets the current number of shares (100)
         SHARES=$(sed -n 1\p shares.txt)
         #Gets the total amount into it you are
         TOTALBOUGHTAT=$(echo "$BOUGHTAT*$SHARES" | bc)
         #Gets the current price of the stock
   		QUOTESEARCH1="http://download.finance.yahoo.com/d/quotes.csv?s=$QUOTENAME1"
   		QUOTESEARCH2="$QUOTESEARCH1&f=l1"
   		QUOTEPRICE=$(curl -s $QUOTESEARCH2)
         #Multiplies the quote price by the number of shares you have
         TOTALQUOTEPRICE=$(echo "$QUOTEPRICE*$SHARES" | bc)
   		DIFFERENCE=$(echo "$TOTALQUOTEPRICE-$TOTALBOUGHTAT" | bc)
   		TOTALDIFFERENCE=$(echo "$DIFFERENCE-$COMMISION" | bc)
         #echo "QUOTENAME1 = $QUOTENAME1"
         #echo "COMMISION = $COMMISION"
         #echo "BOUGHTAT = $BOUGHTAT"
         #echo "SHARES = $SHARES"
         #echo "TOTALBOUGHTAT = $TOTALBOUGHTAT"
         #echo "QUOTEPRICE = $QUOTEPRICE"
         #echo "TOTALQUOTEPRICE = $TOTALQUOTEPRICE"
         #echo "DIFFERENCE = $DIFFERENCE"
         #echo "TOTALDIFFERENCE = $TOTALDIFFERENCE"
         if [ 1 -eq "$(echo "${TOTALDIFFERENCE} > 0" | bc)" ]; then
   			echo "$(tput setaf $i)[$QUOTENAME1]$(tput sgr0) --> $(tput setaf $i)[$QUOTEPRICE]$(tput sgr0) --> $(tput setaf 2)[$TOTALDIFFERENCE]$(tput sgr0)"
         elif [ 1 -eq "$(echo "${TOTALDIFFERENCE} < 0" | bc)" ]; then
			   echo "$(tput setaf $i)[$QUOTENAME1]$(tput sgr0) --> $(tput setaf $i)[$QUOTEPRICE]$(tput sgr0) --> $(tput setaf 1)[$TOTALDIFFERENCE]$(tput sgr0)"
         elif [ 1 -eq "$(echo "${TOTALDIFFERENCE} == 0" | bc)" ]; then
			   echo "$(tput setaf $i)[$QUOTENAME1]$(tput sgr0) --> $(tput setaf $i)[$QUOTEPRICE]$(tput sgr0) --> $(tput setaf 3)[$TOTALDIFFERENCE]$(tput sgr0)"
   		fi
         echo $QUOTEPRICE >> price.txt
         cd ../../
         echo $TOTALDIFFERENCE >> total.txt
   	done
   	STANDING=$(awk '{s+=$1} END {print s}' total.txt)
   	echo "------------------"
      if [ 1 -eq "$(echo "${STANDING} > 0" | bc)" ]; then
         echo "$(tput setaf 2)[$STANDING]$(tput sgr0)"
      else
         echo "$(tput setaf 1)[$STANDING]$(tput sgr0)"
      fi
   	echo "------------------"
   	rm -r total.txt
   fi
done