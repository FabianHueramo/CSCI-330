/********************************************************
 * Program:    dog.h
 * Programmer: Fabian Hueramo
 * Course:     CSCI 330, Section 3
 * Due Date:   2020-02-21
 *
 * Purpose:    contains function prototypes & header files
 * *****************************************************/
#ifndef DOG_H
#define DOG_H
#include <iostream>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <getopt.h>
using namespace std;

//Function prototypes
void cipher(char * cFile, int key);
int print(const char * cFile, char* buffer[], ssize_t bytesRead);
void rotate(char * cFile, int rx);
int printHex(char * cFile, char * buff[], ssize_t count);
int printBin(char * cFile, char * buff[], ssize_t count);

#endif
