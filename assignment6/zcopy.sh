#!/bin/bash

# FUNCTIONS

#########################################################
# Function:   new()
# Parameters: Filename, Label
# Purpose:    Creates a new database named filename
#             and prints the label at the top of it
#########################################################
new(){
    FILENAME=$1
    LABEL=$2

    #if filename was not specified
    if [[ "$1" = "" ]]
    then
	read -p "Enter filename for database: " FILENAME
	read -p "Enter label for database: " LABEL
    fi

    #if label was not specified
    if [[ "$2" = "" && "$LABEL" = "" ]]
    then
	LABEL="Untitled Database"
    fi

    #print message stating new database has been made
    echo "$LABEL" > $FILENAME
    echo "created new database called $FILENAME with label of $LABEL"
    echo ""

}

#########################################################
# Function:   add()
# Parameters: Filename, Make, Model, Year, Color
# Purpose:    Adds a record to an existing database file
#########################################################
add(){
    FILENAME=$1
    MAKE=$2
    MODEL=$3
    YEAR=$4
    COLOR=$5

        #if missing any parameters
        if [[ "$1" = "" || "$2" = "" || "$3" = "" || "$4" = "" || "$5" = "" ]]
        then
            read -p "Please enter the database filename: " "FILENAME"

	    #check if file exists
	    if [ ! -f "$FILENAME" ]
	    then
		echo "ERROR: $FILENAME does not exist"
		exit 1
	    fi

	    #check if file is writable
	    if [ ! -w "$FILENAME" ]
	    then
		echo "ERROR: $FILENAME is not writable"
		exit 1
	    fi

	    read -p "Enter the car's make: " "MAKE"
	    read -p "Enter the car's model: " "MODEL"
	    read -p "Enter the car's year: " "YEAR"
            read -p "Enter the car's color: " "COLOR"
        fi

        #append information to database
        printf "%-10s" $MAKE $MODEL $YEAR $COLOR >> $FILENAME
        echo "" >> $FILENAME
        echo "New record added successfuly"
	echo ""
}

#########################################################
# Function:   show()
# Parameters: Filename, how many to show, line/start, end
# Purpose:    shows record(s) found in an existing database
#########################################################
show(){
    #if no filename was passed, prompt for filename
    if [[ "$1" = "" ]]
    then
	read -p "Please enter database filename: " FILENAME

	#check if file exists
	if [ ! -f "$FILENAME" ]
	then
	    echo "ERROR: $FILENAME does not exist"
	    exit 1
	fi

	#check if file is readable
	if [ ! -r "$FILENAME" ]
	then
	    echo "ERROR: $FILENAME is not readable"
	    exit 1
	fi

	#check if file is empty
	LINE=($(wc -l $FILENAME))
	RECORDS=`expr $LINE - 1`
	if [[ $RECORDS = "0" ]]
	then
	    echo "File is empty."
	    exit
	fi

	read -p "How many records would you like to see(all, single, range): " ANSWER

	#if want to see all records
	if [[ "$ANSWER" = "all" ]]
	then
	    cat $FILENAME
	fi

	#if want to see single record
	if [[ "$ANSWER" = "single" ]]
	then
	    read -p "Enter position of record to view: " CHOICE
	    POSITION=`expr $CHOICE + 1`
	    sed -n "${POSITION}p" "${FILENAME}"
	fi

	#if want to see range or records
	if [[ "$ANSWER" = "range" ]]
	then
	    read -p "Enter the beginning of range: " BEGIN
	    read -p "Enter the end of range: " END
	    START=`expr $BEGIN + 1`
	    STOP=`expr $END + 1`
	    sed -n "${START},${STOP}p" "${FILENAME}" 
	fi
	    
    fi
    echo ""
}

#########################################################
# Function:   delete()
# Parameters: Filename, how many to delete, line/start, end
# Purpose:    Deletes records in existing database
#########################################################
delete(){
    
    #if no filename was passed, prompt for filename
    if [[ "$1" = "" ]]
    then
	read -p "Please enter database filename: " FILENAME
	if [ ! -f "$FILENAME" ]
	then
	    echo "ERROR: $FILENAME does not exist"
	    exit 1
	fi
	if [ ! -w "$FILENAME" ]
	then
	    echo "ERROR: $FILENAME is not writable"
	    exit 1
	fi
	
	# check if file is empty
	LINE=($(wc -l $FILENAME))
	RECORDS=`expr $LINE - 1`
	if [[ $RECORDS = "0" ]]
	then
	    echo "File is empty."
	    exit
	fi

	read -p "How many records would you like to delete(all, single, range): " ANSWER

	#if want to delete all records
	if [[ "$ANSWER" = "all" ]]
	then
	    sed -i '1!d' "${FILENAME}"
	fi

	#if want to delete single record
	if [[ "$ANSWER" = "single" ]]
	then
	    read -p "Enter position of record to delete: " CHOICE
	    POSITION=`expr $CHOICE + 1`
	    sed -i "${POSITION}d" "${FILENAME}"
	fi

	#if want to delete range or records
	if [[ "$ANSWER" = "range" ]]
	then
	    read -p "Enter the beginning of range: " BEGIN
	    read -p "Enter the end of range: " END
	    START=`expr $BEGIN + 1`
	    STOP=`expr $END + 1`
	    sed -i "${START},${STOP}d" "${FILENAME}" 
	fi
	    
    fi
    echo ""
}

########################################################
# Function:   count()
# Parameters: Filename
# Purpose:    count the number of records in a database
#######################################################
count(){
    FILENAME=$1

    # if filename not specified pompt for filename
    if [[ "$1" = "" ]]
    then
	read -p "Enter database to count records: " FILENAME
	if [ ! -f "$FILENAME" ]
	then
	    echo "ERROR: $FILENAME is not readable"
	    exit 1
	fi
    fi

    # check if file is empty
    LINE=($(wc -l $FILENAME))
    RECORDS=`expr $LINE - 1`
    if [[ "$RECORDS" = "0" ]]
    then
	echo "$FILENAME is empty"
    fi

    echo "There are $RECORDS records"
    echo ""
}

############################################################################
#
#         IF COMMAND LINE ARGUEMTNS PASSED WHEN CALLING PROGRAM...
#
############################################################################

# if new() argument was passed
if [[ "$1" = "new" ]]
then
    FILENAME=$2
    LABEL=$3
    if [ -f $FILENAME ]
    then
	echo "ERROR: Database already exists"
	exit 1
    fi
    new $FILENAME $LABEL
    exit
fi

# if add() argument was passed
if [[ "$1" = "add" ]]
then
    FILENAME=$2
    MAKE=$3
    MODEL=$4
    YEAR=$5
    COLOR=$6
    if [[ "$2" = "" ]]
    then
	echo "ERORR: Must specify a database"
    fi
    if [[ "$3" = "" ]]
    then
	echo "ERROR: Must specify a make"
    fi
    if [[ "$4" = "" ]]
    then
	echo "ERROR: Must specify a model"
    fi
    if [[ "$5" = "" ]]
    then
	echo "ERROR: Must specify a year"
    fi
    if [[ "$6" = "" ]]
    then
	echo "ERROR: Must specify a color"
    else
        add $FILENAME $MAKE $MODEL $YEAR $COLOR
    fi
fi

# if show() argument was passed
if [[ "$1" = "show" ]]
then
    FILENAME=$2
    HOWMANY=$3
    if [[ "$HOWMANY" = "all" ]]
    then
	cat $FILENAME
    fi
    if [[ "$HOWMANY" = "single" ]]
    then
	CHOICE=$4
	POSITION=`expr $CHOICE + 1`
	sed -n "${POSITION}p" "${FILENAME}"
    fi
    if [[ "$HOWMANY" = "range" ]]
    then
	BEGIN=$4
	END=$5
	START=`expr $BEGIN + 1`
	STOP=`expr $END + 1`
	sed -n "${START},${STOP}p" "${FILENAME}"
    fi	
fi

# if delete argument was passed
if [[ "$1" = "delete" ]]
then
    FILENAME=$2
    HOWMANY=$3
    if [[ "$HOWMANY" = "all" ]]
    then
	sed '1!d' $FILENAME
    fi
    if [[ "$HOWMANY" = "single" ]]
    then
	CHOICE=$4
	POSITION=`expr $CHOICE + 1`
	sed "${POSITION}d" "${FILENAME}"
    fi
    if [[ "$HOWMANY" = "range" ]]
    then
	BEGIN=$4
	END=$5
	START=`expr $BEGIN + 1`
	STOP=`expr $END + 1`
	sed "${START},${STOP}d" "${FILENAME}"
    fi	
fi

# if count argument was passed
if [[ "$1" = "count" ]]
then
    FILENAME=$2
    LINE=($(wc -l $FILENAME))
    RECORDS=`expr $LINE - 1`
    echo "There are $RECORDS in the $FILENAME database"
fi

# check for invalid arguments
if [[ "$1" != "new" && "$1" != "add" && "$1" != "show" && "$1" != "delete" && "$1" != "count" && "$#" > 0 ]]
then
    echo "ERROR: $1 is not a valid argument"
    exit 1
fi

############################################################################
#
#      IF PROGRAM CALLED WITH NO ARGUMENTS, OPEN IN INTERACTIVE MODE...
#
############################################################################

while true
do
    if [[ "$1" = "" ]] 
    then
        echo "Welcome to the Automobile Database!"
        echo "You are currently in Interactive Mode."
        echo "1) Create a new database"
        echo "2) Add a record to a database"
        echo "3) View a database"
        echo "4) Delete a record from a database"
        echo "5) Count and print # of rows in a database"
        echo "6) Quit"
        read -p "What would you like to do? " OPTION
        if [[ "$OPTION" = "1" ]]
        then
	    new
        fi
        if [[ "$OPTION" = "2" ]]
        then
	    add
        fi
        if [[ "$OPTION" = "3" ]]
        then
	    show
        fi
        if [[ "$OPTION" = "4" ]]
        then
	    delete
        fi
        if [[ "$OPTION" = "5" ]]
        then
	    count
        fi
        if [[ "$OPTION" = "6" ]]
        then
	    echo "Goodbye."
	    exit
        fi

    fi
done
