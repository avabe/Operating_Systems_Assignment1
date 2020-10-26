//
// Created by ava on 25/03/19.
//

#include "types.h"
#include "user.h"
#include "fcntl.h"


int
main(int argc, char *argv[]){

    if(argc < 2 || argc>3 ) {
        printf(2, "Illegal argument number!\n");
        exit(-1);
    }

    char *ar = argv[1];

    if(strcmp(ar, "1") == 0){
        policy(1);
    } else if(strcmp(ar, "2") == 0){
        policy(2);
    } else if(strcmp(ar, "3") == 0){
        policy(3);
    } else{
        printf(2, "Illegal policy number\n");
        exit(-1);
    }


    exit(0);
}
