function startup {
	clear
	echo "$(tput setaf 2)[System]$(tput sgr0) Starting Application"
	# Look for quotes folder
	if [ ! -d Quotes ]; then
		echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find Quotes Folder"
		mkdir "Quotes"
		echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created Quotes Folder"
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Found Quotes"
	fi
	# Look for Lists folder
	if [ ! -d Lists ]; then
		echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find Lists Folder"
		exit;
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Found Lists"
	fi
	# Look for All folder
	if [ ! -d All ]; then
		echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find All Folder"
		mkdir "All"
		echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created All Folder"
		cd All
		for i in {A..Z}
		do
			echo "$(tput setaf 1)[System Error]$(tput sgr0) Couldnt find $i Folder in All"
    		echo "$(tput setaf 3)[System Solve]$(tput sgr0) Making $i Folder in All"
    		mkdir $i
    		echo "$(tput setaf 2)[System]$(tput sgr0) $i Folder Created in All"
		done
		cd ..
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Found All"
	fi
	# Look for Letters.txt
	cd Lists
	for i in {A..Z}
		do
    		if [ ! -f "$i.txt" ]; then
    			echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find $i.txt"
    		else
    			echo "$(tput setaf 2)[System]$(tput sgr0) Found $i.txt"
    		fi
		done
	cd ..
	# Look for all.txt
	if [ ! -f all.txt ]; then
		echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find all.txt"
		touch "all.txt"
		echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created all.txt"
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Found all.txt"
	fi

	# Look for list.txt
	if [ ! -f list.txt ]; then
		echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find list.txt"
		touch "list.txt"
		echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created list.txt"
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Found list.txt"
	fi
	# Outputs list.txt's contents
	echo "$(tput setaf 2)[System]$(tput sgr0) Reading list.txt"
	echo "-------------------------"
	cat list.txt
	echo ""
	echo "-------------------------"
	# Counts the number of lines in list.txt and tells the user how many there are
	QUOTECOUNT=$(awk 'END {print NR}' list.txt)
	if [ $QUOTECOUNT \> 1 ]; then
		echo "$(tput setaf 2)[System]$(tput sgr0) Getting Quote for $QUOTECOUNT Stocks"
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Getting Quote for $QUOTECOUNT Stock"
	fi
	# Goes into Quotes and makes the folders for each quote
	for i in `seq 1 $QUOTECOUNT`;
	do
		# Gets the name for the quote by reading the line that it is assosciated with
		QUOTENAME1=$(sed -n $i\p list.txt)
		cd "Quotes"
		if [ ! -d "$QUOTENAME1" ]; then
			echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find $QUOTENAME1 folder"
			mkdir "$QUOTENAME1"
			echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created $QUOTENAME1 folder"
		else
			echo "$(tput setaf 2)[System]$(tput sgr0) Found $QUOTENAME1 folder"
		fi
		cd ..
	done
	# Look for info.txt
	if [ ! -f info.txt ]; then
		echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find info.txt"
		touch "info.txt"
		echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created info.txt"
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) Found info.txt"
	fi
	# Looks to see if the info.txt file is empty should contain in this order
	# Line 1 = Commission price
	# Line 2 = Total money into it
	if [ -s info.txt ]; then
			echo "$(tput setaf 2)[System]$(tput sgr0) info.txt verified"
		else
			echo "$(tput setaf 1)[System Error]$(tput sgr0) What is the commission price per trade? "
			read COMMISSION
			echo $COMMISSION >> info.txt
	fi
	# Looks for the price.txt file in each of the quotes names folders
	for i in `seq 1 $QUOTECOUNT`;
	do
		QUOTENAME1=$(sed -n $i\p list.txt)
		cd "Quotes/$QUOTENAME1"
		if [ ! -f "price.txt" ]; then
			echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find pice.txt in $QUOTENAME1"
			touch price.txt
			echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created price.txt in $QUOTENAME1"
		fi
		cd ../..
	done
	# Looks for the shares.txt file in each of the quotes names folders
	for i in `seq 1 $QUOTECOUNT`;
	do
		QUOTENAME1=$(sed -n $i\p list.txt)
		cd "Quotes/$QUOTENAME1"
		if [ ! -f "shares.txt" ]; then
			echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find shares.txt in $QUOTENAME1"
			touch shares.txt
			echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created shares.txt in $QUOTENAME1"
		fi
		cd ../..
	done
	# Looks for the buy.txt file in each of the quotes names folders and populates it
	for i in `seq 1 $QUOTECOUNT`;
	do
		QUOTENAME1=$(sed -n $i\p list.txt)
		cd "Quotes/$QUOTENAME1"
		if [ ! -f "buy.txt" ]; then
			echo "$(tput setaf 1)[System Error]$(tput sgr0) Failed to find buy.txt in $QUOTENAME1"
			touch buy.txt
			echo "$(tput setaf 3)[System Solve]$(tput sgr0) Created buy.txt in $QUOTENAME1"
		fi
		if [ -s shares.txt ]; then
			echo "$(tput setaf 2)[System]$(tput sgr0) $QUOTENAME1 shares.txt verified"
		else
			echo "$(tput setaf 1)[System Error]$(tput sgr0) How many shares of $QUOTENAME1 do you have? "
			read SHARES
			echo $SHARES >> shares.txt
		fi
		if [ -s buy.txt ]; then
			echo "$(tput setaf 2)[System]$(tput sgr0) $QUOTENAME1 buy.txt verified"
		else
			echo "$(tput setaf 1)[System Error]$(tput sgr0) What did you buy each share of $QUOTENAME1 for? "
			read BOUGHTAT
			echo $BOUGHTAT >> buy.txt
		fi
		cd ../..
	done
	echo "$(tput setaf 2)[System]$(tput sgr0) Opening pull.sh"
	sleep 2
	open -a Terminal.app ./pull.sh
#	while :
#	do
#		if [ ! -f "pull.run" ]; then
#			echo -ne "$(tput setaf 3)[System Solve]$(tput sgr0) Waiting for pull.sh to start\r"
#		else
#			echo ""
#			echo "$(tput setaf 2)[System]$(tput sgr0) pull.sh started"
#			break
#		fi
#	done
	echo "$(tput setaf 2)[System]$(tput sgr0) Startup Complete"
	# afplay /System/Library/Sounds/Glass.aiff
}


function countlines {
	echo "$(tput setaf 2)[System]$(tput sgr0) Press Any Key to stop line counter"
	while [ true ] ; do
   	read -t 1 -n 1
   	if [ $? = 0 ] ; then
   		echo ""
   		echo "$(tput setaf 2)[System]$(tput sgr0) line count stopped by user"
      	break
   	else
   		while :
      	do
      	LINES=$(awk 'END {print NR}' list.txt)
      	for i in `seq 1 $LINES`;
        	do
            COUNT="0"
            SEARCHNAME=$(sed -n $i\p list.txt)
            cd Quotes
            FILENAME="$SEARCHNAME.txt"
            ADD=$(find . -name '*.txt' | xargs cat | wc -l)
            COUNT=$[$COUNT+$ADD]
            echo -ne "Total Lines Wrote = $COUNT\r"
            cd ..
        	done
        	break
      	done
   	fi
	done
}




function systemshutdown {
	while :
	do
		if [ -f "pull.run" ]; then
			echo -en "$(tput setaf 2)[System]$(tput sgr0) Please close pull.run\r"
		else
			echo ""
			echo "$(tput setaf 2)[System]$(tput sgr0) pull.run closed"
			break
		fi
	done
	echo "$(tput setaf 2)[System]$(tput sgr0) Shutting down"
	echo "$(tput setaf 4)[User]$(tput sgr0) Would you like to delete saved data? (y/n) "
	read ERASEQUOTES
	if [ $ERASEQUOTES == "y" ]; then
		echo "$(tput setaf 2)[System]$(tput sgr0) Quotes Deleted"
		rm -r Quotes
		echo "$(tput setaf 2)[System]$(tput sgr0) All Deleted"
		rm -r All
		echo "$(tput setaf 2)[System]$(tput sgr0) info.txt Deleted"
		rm -r "info.txt"
	else
		echo "$(tput setaf 2)[System]$(tput sgr0) info saved"
	fi
	echo "$(tput setaf 2)[System]$(tput sgr0) Thank you for using Stock Watcher"
}
startup
countlines
systemshutdown