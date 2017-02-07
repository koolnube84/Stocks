clear
cd ~/Desktop/Stocks
echo "$(tput setaf 2)[System]$(tput sgr0) Starting a.sh"
echo "$(tput setaf 2)[System]$(tput sgr0) Press Any Key to exit"
while [ true ] ; do
   read -t 1 -n 1
   if [ $? = 0 ] ; then
   	echo ""
   	echo "$(tput setaf 2)[System]$(tput sgr0) pull.sh stopped by user"
    exit ;
   else
   	cd Lists
   	LINESINLETTERFILE=$(awk 'END {print NR}' A.txt)
   	echo "$LINESINLETTERFILE lines"
   	for i in `seq 1 $LINESINLETTERFILE`;
   	Name=$(sed -n $i\p A.txt)
   	echo $NAME
   	cd ..
   fi
   echo "Done"
done