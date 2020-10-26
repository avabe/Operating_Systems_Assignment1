//
// Created by ava on 20/03/19.
//
#include "types.h"
#include "user.h"
#include "fcntl.h"



int
main(int argc, char *argv[]){

    int pid;
    int first_status;
    int second_status;
    int third_status;
    pid = fork(); // the child pid is 4
    if(pid > 0) {
        first_status = detach(pid); // status = 0
        second_status = detach(pid); // status = -1, because this process has already
        // detached this child, and it doesn’t have
        // this child anymore.
        third_status = detach(77); // status = -1, because this process doesn’t
        // have a child with this pid.

        printf(2, "first_status: %d\nsecond_status: %d\nthird_status: %d\n", first_status, second_status, third_status);
    }
    exit(0);
}
