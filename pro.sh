#Saja Asfour   1210737 sec 4
#Shahd Shreteh 1210444 sec 7

#!/bin/sh

#Add a new medical test record
add () 
{
	#read the new test from user
	echo  "-Enter patiant ID is 7 digit without character"
	read newID
	echo "-Enter Test Name from this list only: Hgb, LDL, BGT, systole, diastole"
	read newTestname
	echo "-Enter year in range from 1950 to 2050 without char"
	read newyear
	echo "-Enter month with range from 1 to 12 without char"
	read newmonth
	echo "Enter result in float represantiation without char:"
	read newres
	echo "Enter unit from this: g/dl , mg/dl , mm Hg"
	read newunit
	echo "Enter status which is one of the following : Pending, Completed, Reviewed"
	read newstatus
	
	#this to count error in test that user add
	count=0
	
	#to ensure that ID does not include any char and just number from 7 digit
	echo $newID | grep '[a-zA-Z]'
	if [ $? -eq 0 ]
	then
		echo "Id must include number only!!\n"
		count=$(( count + 1 ))
	fi 
	
	digit=$(echo -n $newID | wc -c)	#to count number of digit in ID
	# to ensure that Id just 7 digit
	if [ $digit -ne "7" ]
	then
		echo "ID must be 7 digit only!!\n"
		count=$(( count + 1 ))
	fi
	
	#to ensure that user enter test found in file with correct unit 
        if [ $newTestname = "LDL" -o $newTestname = "BGT" -o $newTestname = "ldl" -o $newTestname = "bgt" ]
        then 
        	if [ $newunit = "mg/dL" -o $newunit = "mg/dl" ]
        	then 
        	  :
        	else 
        		echo "the measuring unit test to LDL or BGT should be from this list mg/dl\n"
			count=$(( count + 1 ))
		fi
		
        elif [ $newTestname = "systole" -o $newTestname = "diastole" -o $newTestname = "SYSTOLE" -o $newTestname = "DIASTOLE" ]
        then
        	if [ "$newunit" = "mm Hg" -o "$newunit" = "mm hg" ]
        	then 
                  :
        	else 
        		echo "the measuring unit test to systole or diastole should be from this list mm Hg\n"
			count=$(( count + 1 ))
		fi
		
        elif [ $newTestname = "Hgb" -o $newTestname = "hgb" ]
        then
        	if [ $newunit = "g/dl" -o $newunit = "g/dL" ]
        	then 
        	  :
        	else 
        		echo "the measuring unit test to Hgb should be from this list m/dL\n"
			count=$(( count + 1 ))
		fi
		
        else 
         	echo "the test Name should be from this list Hgb, LDL, BGT, systole, diastole\n"
	 	count=$(( count + 1 ))
        fi

	#to ensure that user enter year without char and within range
	echo $newyear | grep '[a-zA-Z]'
	if [ $? -eq 0 ]
	then
		echo "year must include number only!!\n"
		count=$(( count + 1 ))
	
	#ensure that year within specific range
	elif [ $newyear -le "1950" -o $newyear -ge "2050" ]
	then
		echo "the year should be in range from 1950 to 2050\n"
		count=$(( count + 1 ))
	fi
	
	#to ensure that user enter month without char and within range
	echo $newmonth | grep '[a-zA-Z]'
	if [ $? -eq 0 ]
	then
		echo "month must include number only!!\n"
		count=$(( count + 1 ))
		
	#ensure that year within specific range
	elif [ $newmonth -lt "1" -o $newmonth -gt "12" ]
	then
		echo "the month should be in range from 1 to 12\n"
		count=$(( count + 1 ))
	fi 
	
	#to ensure that user enter res without char 
	echo $newres | grep '[a-zA-Z]'
	if [ $? -eq 0 ]
	then
		echo "result must include number only!!\n"
		count=$(( count + 1 ))
	fi

	#to ensure that user enter correct status
	if [ $newstatus = "Pending" -o $newstatus = "Completed" -o $newstatus = "Reviewed" -o $newstatus = "pending" -o $newstatus = "completed" -o $newstatus = "reviewed" ]
	then
	  :
	else
		echo "the status of test should be from this list Pending, Completed, Reviewed\n"
        	count=$(( count + 1 ))
        fi
        
        #if there is an error in test that user enter then call function add again ,else append the test to      medicalRecord file
        
        if [ $count -ne 0 ]
	then
		echo "Please Try again to save your add test\n"
		add
	else
		echo -n $newID >> midecalRecord.txt
		echo -n ":" >> midecalRecord.txt
	    echo -n $newTestname >> midecalRecord.txt
		echo -n "," >> midecalRecord.txt
		echo -n $newyear >> midecalRecord.txt
		echo -n "-" >> midecalRecord.txt
		echo -n $newmonth >> midecalRecord.txt
		echo -n "," >> midecalRecord.txt
		echo -n $newres >> midecalRecord.txt
		echo -n "," >> midecalRecord.txt
		echo -n $newunit >> midecalRecord.txt
		echo -n "," >> midecalRecord.txt
		echo  $newstatus >> midecalRecord.txt
	fi
}

#read Id from user 
read_ID () {
echo "Enter ID you want to search:"
	read ID 
	#to ensure that ID does not include any char and just number from 7 digit
	count=0
	echo $ID | grep '[a-zA-Z]'
	
	if [ $? -eq 0 ]
	then
		echo "Id must include number only!!\n"
		read_ID
	fi 
	
	#ensure that id has only 7 digit
	digit=$(echo -n $ID | wc -c)
	if [ $digit -ne "7" ]
	then
		echo "ID must be 7 digit only!!\n"
		read_ID
	fi
	#to check if ID exist in the file or not 
	a=$(grep $ID midecalRecord.txt)
	if [ $? -eq 1 ]
	then
		echo "this ID $ID not found in file\nplease Enter ID again"
		read_ID
	fi
}


# Search for a test by patient ID
searchID () {
	#print menu of search
	echo "1-Retrieve all patient tests"
	echo "2-Retrieve all up normal patient tests"
	echo "3-Retrieve all patient tests in a given specific period"
	echo "4-Retrieve all patient tests based on test status"
	echo "Enter choice from 1-4 depend on your request:"
	read num
	read_ID
	
case "$num" in
#Retrieve all patient tests
1) grep "$ID" midecalRecord.txt ;;
#Retrieve all up normal patient tests
2) IDline=$(grep $ID midecalRecord.txt | wc -l) 
	i=1 #counter for lines in file
	c=0 #counter for count normal test 
	
	#loop into all lines in the file , to read test and result for each line and test if it is normal or not
	while [ "$i" -le "$IDline" ]
	do
	
	#cut the testname and result in the file 
	testName=$(grep $ID midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f1 | cut -d ":" -f2 )
	res=$(grep $ID midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f3)
	
	if [ $testName = "LDL" -o $testName = "ldl" ]
	then
		#ensure from the range of LDL
		result=$(( $(echo "$res >= 100.0" | bc -l) )) #here we use bc to handel floating-point arithmetic 
		
		#if the result of comparison is true (1)
		if [ "$result" -eq 1 ]
		then
			# search for the record in the file with the given ID and print the line at position $i
			grep $ID midecalRecord.txt | sed -n ""$i"p"
			#increment the error counter 
			c=$((c + 1))
		fi
		
	elif [ $testName = "Hgb" -o $testName = "hgb" ]
	then
		#ensure from the range of Hgb
		result=$(( $(echo "$res <= 13.8 || $res >= 17.2" | bc -l) ))
		
		#if the result of comparison is true (1)
		if [ "$result" -eq 1 ]
		then
			# search for the record in the file with the given ID and print the line at position $i
			grep $ID midecalRecord.txt | sed -n ""$i"p"
			#increment the error counter 
			c=$((c + 1))
		fi
	elif [ $testName = "BGT" -o $testName = "bgt" ]
	then
		#ensure from the range of BGT
		result=$(( $(echo "$res <= 70.0 || $res >= 99.0" | bc -l) ))
		
		#if the result of comparison is true (1)
		if [ "$result" -eq 1 ]
		then
			# search for the record in the file with the given ID and print the line at position $i		
			grep $ID midecalRecord.txt | sed -n ""$i"p"
			#increment the error counter 
			c=$((c + 1))
		fi
		
	elif [ $testName = "systole" -o $testName = "SYSTOLE" ]
	then
		#ensure from the range of systole
		result=$(( $(echo "$res >= 120.0" | bc -l) ))
		
		#if the result of comparison is true (1)
		if [ "$result" -eq 1 ]
		then
			# search for the record in the file with the given ID and print the line at position $i				
			grep $ID midecalRecord.txt | sed -n ""$i"p"
			#increment the error counter 
			c=$((c + 1))
		fi
		
	elif [ $testName = "diastole" -o $testName = "DIASTOLE" ]
	then
		#ensure from the range of diastole
		result=$(( $(echo "$res >= 80.0" | bc -l) ))
		
		#if the result of comparison is true (1)
		if [ "$result" -eq 1 ]
		then
			# search for the record in the file with the given ID and print the line at position $i				
			grep $ID midecalRecord.txt | sed -n ""$i"p"
			#increment the error counter 
			c=$((c + 1))
		fi
	fi
	#increment the counter of line
	i=$((i + 1))
	done
	
	#if there is no error , then all test are normal
	if [ $c -eq 0 ]
	then
		echo "all test of this ID $ID are normal test"
	fi 	
;;
3) 
    #search for Id in the file and print the result in a.txt file
    grep $ID midecalRecord.txt > a.txt
    
    #read the period from the user
    echo "Please Enter the specific period\nfrom year-month : "
    read fromPeriod
    echo "Please Enter the specific period\nto year-month : "
    read toPeriod
    
    #count the number of lines for test in a.txt ( the file we put the test with id in it )
    IDline=$(cat a.txt | wc -l)
    
    
    i=1	#counter for line
    c=0	#counter for error
    c1=0 #count for correct
    
    #cut the year and month from the period that user enter
    fromYear=$(echo "$fromPeriod" | cut -d "-" -f1)
    toYear=$(echo "$toPeriod" | cut -d "-" -f1)
    fromMonth=$(echo "$fromPeriod" | cut -d "-" -f2)
    toMonth=$(echo "$toPeriod" | cut -d "-" -f2)
    
    #to ensure that user enter year without char and within range
    echo $fromYear | grep '[a-zA-Z]'
    if [ $? -eq 0 ]
    then
        echo "from year must include number only!!\n"
        #go out the if statement if the user enter year with character 
    	break
    #ensure that year in specific period 	
    elif [ $fromYear -lt "1950" -o $fromYear -gt "2050" ]
    then
    	echo "from year should be in range from 1950 to 2050\n"
        #go out the if statement if the user enter year not in the range
   	break
    fi
    
    #to ensure that user enter month without char and within range
    echo $fromMonth | grep '[a-zA-Z]'
    if [ $? -eq 0 ]
    then
        echo "from month must include number only!!\n"
        #go out the if statement if the user enter month with character 
    	break

    #ensure that month from 1 to 12 only  	
    elif [ $fromMonth -lt "1" -o $fromMonth -gt "12" ]
    then
    	echo "from month should be in range from 1 to 12\n"
        #go out the if statement if the user enter month not in the range
    	break
    fi
    
    #to ensure that user enter year without char and within range
    echo $toYear | grep '[a-zA-Z]'
    if [ $? -eq 0 ]
    then
        echo "to year must include number only!!\n"
    	break
    	
    elif [ $toYear -lt "1950" -o $toYear -gt "2050" ]
    then
    	echo "to year should be in range from 1950 to 2050\n"
    	break
    fi
    
    #to ensure that user enter month without char and within range
    echo $toMonth | grep '[a-zA-Z]'
    if [ $? -eq 0 ]
    then
        echo "to month must include number only!!\n"
    	break
    	
    elif [ $toMonth -lt "1" -o $toMonth -gt "12" ]
    then
   	 echo "to month should be in range from 1 to 12\n"
    	 break
    fi

    #to ensure that user enter correct period which from year less than to year
    if [ $fromYear -gt $toYear ]
    then
    	echo "from year must be less than to year..........."
    	break
    fi
   
   #loop in lines
   while [ "$i" -le "$IDline" ]
   do
    
    	#cut year and month for each line
    	year=$(sed -n ""$i"p" a.txt | cut -d "," -f2 | cut -d "-" -f1)
    	month=$(sed -n ""$i"p" a.txt | cut -d "," -f2 | cut -d "-" -f2)
    	
    	#get the date that within the range
    	#ensure that year in the line is grater than from year and less than to year 
       	if [ $year -lt $fromYear -o  $year -gt $toYear ] #here we make the opposite to count the error
    	then
    		c=$((c + 1))
    	#ensure that if year in the line equal from year then month in the line must be grater or equal than from month 
        elif [ $year -eq $fromYear -a $month -le $fromMonth ] #here we make the opposite to count the error
        then
    		c=$((c + 1))
    	#ensure that if year in the line equal to year then month in the line must be less or equal than from month
    	elif [ $year -eq $toYear -a $month -ge $toMonth ]   #here we make the opposite to count the error
    	then
    		c=$((c + 1))
    	#if the year is within the period then show the line to user
    	else
    		sed -n ""$i"p" a.txt
    		c1=$(( c1 + 1 )) #increment the counter of correct
   	fi
    
    #increment the line number
    i=$((i + 1))
    done
    
    # if there is no lines in system within the period
    if [ $c -gt 0  -a $c1 -eq 0 ]
    then
    	echo "No test to this ID $ID in specific period you entered............."
    fi
    ;;
4) 
   # search about id in the medical file and print its content into a.txt file
   grep $ID midecalRecord.txt > a.txt
   
   # read the status from the user
   echo "Enter status you want to search by Id based on your choice:"
   read searchstatus
   
   # search about the status in a.txt file which is the file that we print on it the test with same id that user enter
   grep $searchstatus a.txt
   
   #if there is no test with this status
   if [ $? -ne 0 ]
   then
   	echo "There is no test has $searchstatus in the midecalRecord "
   fi
   ;;
   
*) #default case 
   echo "Please Enter number from 1-4 only !";;
esac
}

#Delete a test
Delete () {
	#print the test inside file to user
	cat midecalRecord.txt
	
	#read the test from user 
	echo "\nEnter the whole test you want to delete"
	read deletetest
	
	#search about the test that user want to enter , if found print in a.txt to avoid show result in terminal
	grep $deletetest midecalRecord.txt > a.txt
	
	#if the test found in the file
	if [ $? -eq 0 ]
	then
		# print all test instead the test that user want to delete inside /tmp/midecalRecord.txt
		grep -v $deletetest midecalRecord.txt > /tmp/midecalRecord.txt
		
		#move the test without deleted test to original file
		mv /tmp/midecalRecord.txt midecalRecord.txt
		
		echo " The test was deleted!" 
	else 
		echo " This test not found "
	fi
	
}

#Update an existing test result.
Update () {
	#print the test inside file to user
	cat midecalRecord.txt
	
	#read the test from user
	echo " Enter the whole test you want to update"
	read updatetest
	
	#search about the test that user want to update , if found print in a.txt to avoid show result in terminal
	grep $updatetest midecalRecord.txt > a.txt
	
	#if the test found
	if [ $? -eq 0 ]
	then
		# print all test instead the test that user want to update inside /tmp/midecalRecord.txt
		grep -v $updatetest midecalRecord.txt > /tmp/midecalRecord.txt
		
		#move the test without deleted test to original file
		mv /tmp/midecalRecord.txt midecalRecord.txt
		
		#add the updated test
		add
		echo " The test was updated! "
	else 
		echo " This test not found "
	fi
}

#Searching for up normal tests: the system will retrieve all up normal patients’ tests based on the input medical test.
SearchName() {
	#read the test name from user
	echo "Enter Test Name you want to search:"
	read testName
	
	#check if the test name is match the test name from our system
	if [ $testName = "Hgb" -o $testName = "LDL" -o $testName = "BGT" -o $testName = "systole" -o $testName = "diastole" -o $testName = "hgb" -o $testName = "ldl" -o $testName = "bgt" -o $testName = "SYSTOLE" -o $testName = "DIASTOLE" ]
        then
        
        # in each test we handle the small and capital later and count lines that contains it 
        	if [ $testName = "Hgb"  -o $testName = "hgb"  ]
        	then
          		nameline=$(grep "\<[Hh]gb\>" midecalRecord.txt | wc -l) 
        	elif  [ $testName = "LDL" -o $testName = "ldl" ]
        	then
          		nameline=$(grep "\<[Ll][Dd][Ll]\>" midecalRecord.txt | wc -l) 
        	elif [ $testName = "BGT" -o $testName = "bgt" ]
        	then
          		nameline=$(grep "\<[Bb][Gg][Tt]\>" midecalRecord.txt | wc -l) 
        	elif [ $testName = "systole" -o $testName = "SYSTOLE" ]
        	then 
         		nameline=$(grep "\<[Ss][Yy][Ss][Tt][Oo][lL][Ee]\>" midecalRecord.txt | wc -l) 
		elif [ $testName = "diastole" -o $testName = "DIASTOLE" ]
		then
          		nameline=$(grep "\<[Dd][Ii][Aa][Ss][Tt][Oo][Ll][Ee]\>" midecalRecord.txt | wc -l)
        fi
        
	i=1 #counter for line
	c=0 #counter for error
	
	#loop in all line match the test name
	while [ "$i" -le "$nameline" ]
	do
		# in each test name we take a result and handle small and capital later
		if [ $testName = "Hgb"  -o $testName = "hgb"  ]
        	then
          		res=$(grep "\<[Hh]gb\>" midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f3) 
        	elif  [ $testName = "LDL" -o $testName = "ldl" ]
        	then
          		res=$(grep "\<[Ll][Dd][Ll]\>" midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f3) 
        	elif [ $testName = "BGT" -o $testName = "bgt" ]
        	then
          		res=$(grep "\<[Bb][Gg][Tt]\>" midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f3) 
        	elif [ $testName = "systole" -o $testName = "SYSTOLE" ]
        	then 
          		res=$(grep "\<[Ss][Yy][Ss][Tt][Oo][lL][Ee]\>" midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f3) 
		elif [ $testName = "diastole" -o $testName = "DIASTOLE" ]
		then
         		 res=$(grep "\<[Dd][Ii][Aa][Ss][Tt][Oo][Ll][Ee]\>" midecalRecord.txt | sed -n ""$i"p" | cut -d "," -f3)
        	fi

		#check the range for each test
		if [ $testName = "LDL" -o $testName = "ldl" ]
		then
			result=$(( $(echo "$res >= 100.0" | bc -l) ))
			if [ "$result" -eq 1 ]
			then
				grep "\<[Ll][Dd][Ll]\>" midecalRecord.txt | sed -n ""$i"p"
				c=$((c + 1))
			fi
		elif [ $testName = "Hgb" -o $testName = "hgb" ]
		then
			result=$(( $(echo "$res <= 13.8 || $res >= 17.2" | bc -l) ))
			if [ "$result" -eq 1 ]
			then
				grep "\<[Hh]gb\>" midecalRecord.txt | sed -n ""$i"p"
			c=$((c + 1))
			fi
		elif [ $testName = "BGT" -o $testName = "bgt" ]
		then

			result=$(( $(echo "$res <= 70.0 || $res >= 99.0" | bc -l) ))
			if [ "$result" -eq 1 ]
			then
				grep "\<[Bb][Gg][Tt]\>" midecalRecord.txt | sed -n ""$i"p"
			c=$((c + 1))
			fi
		elif [ $testName = "systole" -o $testName = "SYSTOLE" ]
		then

			result=$(( $(echo "$res >= 120.0" | bc -l) ))
			if [ "$result" -eq 1 ]
			then
				grep "\<[Ss][Yy][Ss][Tt][Oo][lL][Ee]\>" midecalRecord.txt | sed -n ""$i"p"
				c=$((c + 1))
			fi
		elif [ $testName = "diastole" -o $testName = "DIASTOLE" ]
		then
			result=$(( $(echo "$res >= 80.0" | bc -l) ))
			if [ "$result" -eq 1 ]
			then
				grep "\<[Dd][Ii][Aa][Ss][Tt][Oo][Ll][Ee]\>"  midecalRecord.txt | sed -n ""$i"p"
				c=$((c + 1))
			fi
		fi
		
		#increment the line number
		i=$((i + 1))
	done
	
	#if there is no error
	if [ $c -eq 0 ]
	then
		echo "all test of this ID $testName are normal test"
	fi 
        else
        	echo "the test Name should be from this list Hgb, LDL, BGT, systole, diastole"
        fi
}

#Average test value: the system will retrieve the average value of each medical test
Avg () {
	#count the number of line in the file
	IDline=$(cat midecalRecord.txt | wc -l) 
	
	#counters
	i=1 #line
	countLDL=0
	countHgb=0
	countBGT=0
	countS=0
	countD=0
	resultLDL=0
	resultHgb=0
	resultBGT=0
	resultS=0
	resultD=0
	
	#iteration at all lines in the file
	while [ "$i" -le "$IDline" ]
	do
		#cut the test name and the result
		testName=$(sed -n ""$i"p" midecalRecord.txt | cut -d "," -f1 | cut -d ":" -f2 )
		res=$(sed -n ""$i"p" midecalRecord.txt  | cut -d "," -f3)
	
		#for each test we count the number of it in the file , also sum the result
		if [ $testName = "LDL" -o $testName = "ldl" ]
		then
			countLDL=$(( countLDL +1 ))	
			resultLDL=$(echo "$resultLDL + $res" | bc)
		
		elif [ $testName = "Hgb" -o $testName = "hgb" ]
		then
			countHgb=$(( countHgb +1 ))	
			resultHgb=$(echo "$resultHgb + $res" | bc )
		elif [ $testName = "BGT" -o $testName = "bgt" ]
		then
			countBGT=$(( countBGT +1 ))	
			resultBGT=$(echo "$resultBGT + $res" | bc )
		elif [ $testName = "systole" -o $testName = "SYSTOLE" ]
		then
			countS=$(( countS +1 ))	
			resultS=$(echo "$resultS + $res  " | bc)
		elif [ $testName = "diastole" -o $testName = "DIASTOLE" ]
		then
			countD=$(( countD +1 ))	
			resultD=$(echo "$resultD + $res" | bc )	
		fi
	
		#increment the line
		i=$((i + 1))
	done
	
	# if there is no test in the file (file empty)
	if [ $countLDL -eq 0 -a $countHgb -eq 0 -a $countBGT -eq 0 -a $countS -eq 0 -a  $countD -eq 0 ]
	then
		echo "The file is empty! "
	else
		# convert each count to float number to handle error when division 
		floatCountLDL="${countLDL}.0"
		floatcountHgb="${countHgb}.0"
		floatCountBGT="${countBGT}.0"
		floatCountS="${countS}.0"
		floatCountD="${countD}.0"
		
		# find the average for all test in the file 
		if [ $countLDL -ne 0 ]
		then
			AvgLDL=$(echo "scale=2; $resultLDL / $floatCountLDL" | bc )
		fi
		
		if [ $countHgb -ne 0 ]
		then
			AvgHgb=$(echo "scale=2; $resultHgb / $floatcountHgb" | bc )
		fi
		
		if [ $countBGT -ne 0 ]
		then
			AvgBGT=$(echo "scale=2; $resultBGT / $floatCountBGT" | bc )
		fi
		
		if [ $countS -ne 0 ]
		then 
			AvgS=$(echo "scale=2; $resultS / $floatCountS" | bc )
		fi
		
		if [ $countD  -ne 0 ]
		then
			AvgD=$(echo "scale=2; $resultD / $floatCountD" |bc)
		fi
	fi 
	
	#print the averages
	printf "The Avg of LDL = %0.2f\n" "$AvgLDL"
	printf "The Avg of Hgb = %0.2f\n" "$AvgHgb"
	printf "The Avg of BGT = %0.2f\n" "$AvgBGT"
	printf "The Avg of systole = %0.2f\n" "$AvgS"
	printf "The Avg of diastole = %0.2f\n" "$AvgD"
	
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<main code >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

menu(){
	echo  "**************************************"
	echo " Welcome to our medical test system !!! "
	echo "1- Add a new medical testrecord"
	echo "2- Search for a test by patient ID"
	echo "3- Searching for up normal tests"
	echo "4- Average test value"
	echo "5-Update an existing test result"
	echo "6-Delete an existing test "
	echo "7-exit"
	
	#read the choice from user
	echo "Enter number from 1-7 based on your request :"
	read choice

	case "$choice" in

	1)	
	
 		echo  "Enter the new medical test you want "
		add
		menu ;;

	2) 
		searchID
  		menu;;

	3) 
		SearchName
   		menu ;;
	4) 
		Avg
   		menu ;;

	5) 
		Update 
   		menu ;;

	6) 
		Delete
   		menu;;

	7) 
		echo "Thanks for using our system!!"
   		exit 0;; 

	*) 
		echo "you should enter integer choice from 1 to 7 only"
   		menu;;

	esac
}
menu
