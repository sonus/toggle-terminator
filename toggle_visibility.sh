#!/bin/bash

#The purpose of this script is to allow the user to toggle the visibility of (almost) any window.
#Please note it will work on the first match, so if there are multiple instances of an application it would be a random window of them the one to be affected.

#Checking that all dependencies are met, since we cannot proceed without them.
declare -a DEPENDENCIES=("xdotool" "wmctrl");
declare -a MANAGERS=("yum" "apt-get");

for DEPENDENCY in ${DEPENDENCIES[@]};
do
    echo -n "Checking if $DEPENDENCY is available";
    if hash $DEPENDENCY 2>/dev/null;
    then
        echo "- OK, Found";
    else
        echo "- ERROR, Not Found in $PATH";
        for MANAGER in ${MANAGERS[@]};
        do
            if hash $MANAGER 2>/dev/null;
            then
                echo -n "$DEPENDENCY is missing, would you like to try and install it via $MANAGER now? [Y/N] (default is Y): ";
                read ANSWER;
                if [[ "$ANSWER" == "Y" || "$ANSWER" == "y" || "$ANSWER" == "" ]];
                then
                    sudo "$MANAGER" install "$DEPENDENCY";
                else
                    echo "Terminating";
                    exit -1;
                fi
            fi
        done
    fi
done

APPLICATION="$1";
BABU="$2";

#Checking if the application name provided by the user exists
if ! hash $APPLICATION 2>/dev/null;
then
    echo -e "$APPLICATION does not seem to be a valid executable\nTerminating";
    exit -2;
fi

#Checking if the application is running. We are using pgrep as various application are python scripts and we will not be able to find them using pidof. pgrep will look through the currently running processes and list the process IDs of all the processes that are called $APPLICATION.
if [ -z "$2" ]
then
    PID=$(ps x | grep "${APPLICATION}" | grep -vE 'toggle|grep' | awk '{print $1}');
else
    PID=$(pgrep $APPLICATION);
fi

#If the application is not running, we will try to launch it.
if [ -z $PID ];
then
  echo "$APPLICATION not running, launching it..";
    $APPLICATION;
else
    #Since the application has a live instance, we can proceed with the rest of the code.
    #We will get the PID of the application that is currently focused, if it is not the application we passed as parameter we will change the focus to that. In the other case, we will minimize the application.
  echo -n "$APPLICATION instance found - ";
    FOCUSED=$(xdotool getactivewindow getwindowpid);
    if [[ $PID == $FOCUSED ]];
    then
    echo "It was focused so we are minimizing it";
        #We minimize the active window which we know in this case that it is the application we passed as parameter.
        xdotool getactivewindow windowminimize;
    else
    echo "We are setting the focus on it";
        #We set the focus to the application we passed as parameter. If it is minimized it will be raised as well.
        wmctrl -x -R $APPLICATION;
    fi
fi

exit 0
