/********************************************************
 * Program:    dogfunc.cc
 * Programmer: Fabian Hueramo
 * Course:     CSCI 330, Section 3
 * Due Date:   2020-02-21
 *
 * Purpose:    contains function implementation
 * *****************************************************/

#include "dog.h"

/********************************************************
 * Function:   cipher(char * cFile, int key)
 * Paramaters: char array filename, key to encrypting
 *
 * Purpose:    applies ceaser cipher to data read from file
 * *****************************************************/
void cipher(char * cFile, int key){
    for(int i = 0; cFile[i] != NULL; i++){  //loop through each element in buffer
        char ch = cFile[i];

        if(ch >= 'a' && ch <= 'z'){          //if lowercase...
            ch = ch + key;
            if(ch > 'z')			 //if adding key goes over z
                ch = ch - 'z' + 'a' - 1;
            cFile[i] = ch;               //assign new encrypted char to new buffer
        }
        else if(ch >= 'A' && ch <= 'Z'){     //if uppercase...
            ch = ch + key;
            if(ch > 'Z')
                ch = ch - 'Z' + 'A' - 1;
            cFile[i] = ch;
        }  
    }  
}

/********************************************************
 * Function:   print(const char * cFile)
 * Paramaters: char array file name
 *
 * Purpose:    prints out contents of a file to std ouput
 * *****************************************************/
int print(const char * cFile, char* buffer[], ssize_t bytesRead){
    int fd = open(cFile, O_RDONLY);

    if(fd == -1)
	perror("opening file");

    while((bytesRead = read(fd, buffer, bytesRead)) != 0){
        if(bytesRead == -1){
            perror("reading file");
	    exit(1);
	}

        write(STDOUT_FILENO, buffer, bytesRead);
    }

    close(fd);

    return 0;
}
/********************************************************
 * Function:   rotate(char buffer[], int x)
 * Paramaters: char array, number of rotations to apply
 *
 * Purpose:    applies rotation of x to each byte read
 * *****************************************************/
void rotate(char * cFile, int rx){
    for(int i = 0; i < strlen(cFile); i++){
	cFile[i] = cFile[i + rx];
    }
}
/********************************************************
 * Function:   printHex(int argc, char* argv[])
 * Paramaters: argument count, arguments
 *
 * Purpose:    prints contents of buffer in hexideicmal
 *             format
 * *****************************************************/
int printHex(char * cFile, char * buff[], ssize_t count){
    return 0;
}

/********************************************************
 * Function:   printBin()
 * Paramaters:
 *
 * Purpose:    prints contents of buffer in binary
 *             format
 * *****************************************************/
int printBin(char * cFile, char * buff[], ssize_t count){
   return 0; 
}

