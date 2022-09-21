##########################################
# z1857628.awk
# Fabian Hueramo
# CSCI 330 section 3
# Due: 2020-04-22
##########################################

BEGIN {
    # set colon as field seperator
    FS = ":"

    #print column labels
    printf("%-17s\t%-15s\t%13s\n", "Name", "Position", "Sales Ammount")
    print "======================================================"
}

# product records
NF==4{
    prodCat[$1]=$2
    prodDesc[$1]=$3
    prodPrice[$1]=$4
}

# associate records
NF==3 {
    split($2,name," ")
    asscName[$1]=name[2]", "name[1]
    asscPos[$1]=$3
    asscSales[$1]=0.00
}

# sales records
NF==5 {
    saleDate[$1]=$4
	
    # add up total sales
    i=0
    while(i < $3) {
 	asscSales[$5]+=prodPrice[$2]
            i++
    }
}

END {
    # print out all sales in sorted order
    for (i in asscSales) {
	    printf("%-20s\t%-15s\t%10.2f\n", asscName[i], asscPos[i], asscSales[i]) | "sort -nr -k 4"
    }
}
