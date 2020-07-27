#!/bin/sh

# Colors
bold="$(tput bold)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
randomColors="$(tput setaf `shuf -i 1-9 -n 1`)"
reset="$(tput sgr0)"

# Output Arch-Linux
clear
cat<<EOF
${reset}${bold}${white}
 Welcome to Arch Linux
${reset}${bold}${randomColors}
                     cc 
                    cccc 
                   cccccc 
                  cccccccc 
                 cccccccccc 
                cccccccccccc 
               cccccccccccccc 
              cccccccccccccccc 
             cccccccccccccccccc 
            cccccccccccccccccccc 
           cccccccccccccccccccccc 
          cccccccccccccccccccccccc 
         cccccccccc      cccccccccc 
        cccccccccc        cccccccccc 
       ccccccccccc        ccccccccccc 
      cccccccccccc        cccccccccccc 
     cccccccc                 ccccccccc 
    cccc                           ccccc 
   cc                                  cc 
  c
${reset}
EOF

# Wait 2
sleep 2
