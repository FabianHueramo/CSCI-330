/**********************************************
 * Program:    dog.cc
 * Programmer: Fabian Hueramo
 * Course:     CSCI 330, Section 3
 * Due Date:   2020-02-21
 *
 * Purpose:    Like cat but better!!
 * ******************************************/
#include "dog.h"

bool sflagused = false;
bool nflagused = false;
bool cflagused = false;
bool rflagused = false;
bool xflagused = false;
bool bflagused = false;
char * buffer[1024];

int main(int argc, char* argv[]){
    int opt;
    int BUFF_SIZE = 1024;
    char * buffer[BUFF_SIZE];
    char optstring[] = "s:n:c:r:xb";
    ssize_t bytesRead;
    int key, rtNum;


    while((opt = getopt(argc, argv, optstring)) != -1){  //
	cerr << "Getopt returned " << opt << endl;
        switch(opt){
	    case 's':
	      //resize buffer
	      
	      cout << "u selected s\n"; 
	      sflagused = true;
	      break;
	    case 'n':
	      //changes # of bytes to read
	      cout << "u selected n\n";
	      nflagused = true;
	      break;
	    case 'c':
	      //ceaser cipher
	      //key = atoi(optarg);
	      cout << "u selected c\n";
	      cflagused = true;
	      break;
	    case 'r':
	      //rotation
	      //rtNum = atoi(optarg);
	      cout << "u selected r\n";
	      rflagused = true;
	      break;
	    case 'x':
	      //hexidecimal
	      cout << "u selected x\n";
	      xflagused = true;
	      break;
	    case 'b':
	      //binary
	      cout << "u selected b\n";
	      bflagused = true;
	      break;
	    default:
	      break;		  
        }
    }
    cerr << "before for loop to print\n";
    for(int i = optind ; i < argc; i++)
	print(argv[i], buffer, 1024);
    cerr << "after for loop\n";
    
     
    return 0;
}
