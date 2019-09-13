//Copyright 2019 Polar Development

   //Licensed under the Apache License, Version 2.0 (the "License");
   //you may not use this file except in compliance with the License.
   //You may obtain a copy of the License at

     //  http://www.apache.org/licenses/LICENSE-2.0

   //Unless required by applicable law or agreed to in writing, software
   //distributed under the License is distributed on an "AS IS" BASIS,
   //WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   //See the License for the specific language governing permissions and
   //limitations under the License.

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <errno.h>
#include <sysexits.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

#define PROC_PIDPATHINFO_MAXSIZE  (1024)
int proc_pidpath(pid_t pid, void *buffer, uint32_t buffersize);

int main(int argc, char *argv[]){
    
    struct stat correct;
    if (lstat("/Applications/Novus.app/Contents/MacOS/Novus", &correct) == -1){
        fprintf(stderr, "I would like to know more about that legend, if you will.\n");
        return EX_NOPERM;
    }
    
    pid_t parent = getppid();
    bool novus = false;
    
    char pathbuf[PROC_PIDPATHINFO_MAXSIZE] = {0};
    int ret = proc_pidpath(parent, pathbuf, sizeof(pathbuf));
    if (ret > 0){
        if (strcmp(pathbuf, "/Applications/Novus.app/Contents/MacOS/Novus") == 0){
            novus = true;
        }
    }
    
    if (novus == false){
        fprintf(stderr, "There appears to have been an insignificant struggle here.\n");
        return EX_NOPERM;
    }
    
    setuid(0);
    setgid(0);
    
    if (getuid() != 0){
        fprintf(stderr, "What is this pressure I feel...? Something...is enraged?\n");
        return EX_NOPERM;
    }
    
    if (argc < 2){
        fprintf(stderr, "Now all will end. And everything will begin. With this Red Chain I will pry open the portal to another dimension.\n");
        return 0;
    }
    
    char *args[5] = {"/bin/zsh", "-l", "-c", argv[1], NULL};
    execv(args[0], args);
    return EX_UNAVAILABLE;
}
