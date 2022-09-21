/**********************************************
 * Program:    assign1.cc
 * Programmer: Fabian Hueramo
 * Course:     CSCI 330, Section 3
 * Due Date:   2020-02-10
 *
 * Purpose:    Displays all content of n number of 
 *             files passed to it 
 * ******************************************/
#include <iostream>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
using namespace std;

//function protoype
int printFile(const char* cFile);

int main(int argc, char* argv[]){

    //loop through each file and pass to printFile function
    for(int i = 1; i < argc; i++){
	printFile(argv[i]);
    }

    return 0;
}


int printFile(const char* cFile){
    int fd = open(cFile, O_RDONLY);   //open file for read only
    int BUFF_SIZE = 1024;             //buffer size
    char buffer[BUFF_SIZE];           //buffer to hold read data
    ssize_t bytesRead;                //count of bytes read from file

    if(fd == -1)                      //open file check for error opening
	perror("opening file");

    while((bytesRead = read(fd, buffer, BUFF_SIZE)) != 0)   //while haven't reached end of file...
	write(STDOUT_FILENO, buffer, bytesRead);            //write buffet to standard output

    close(fd);    //close file fd

    return 0;
}
