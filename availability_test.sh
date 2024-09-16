#!/bin/bash
if [ $# -eq 0 ]; then
    echo "A valid URL is required"
    exit 1
elif [ $# -gt 1 ]; then
    echo "The script is expecting a single argument only, but got $#."
    exit 1
fi
status_code=$(curl -o /dev/null -s -w "%{http_code}" "$1")
if [ "$status_code" -eq 000 ]; then
    echo "$1 is not available. 000"
    exit 1
fi
if [ "$status_code" -lt 500 ]; then
    echo "$1 is up!"
else
    echo "$1 is not available."
    exit 1
fi



To run this 
execute: chmod +x availability_test.sh
AND check that:
myuser@hostname:~$ ./availability_test.sh www.google.com
www.google.com is up!
myuser@hostname:~$ ./availability_test.sh http://cnn.com
http://cnn.com is up!
myuser@hostname:~$ ./availability_test.sh abcdefg
abcdefg is not available.
myuser@hostname:~$ echo $?
1
myuser@hostname:~$ ./availability_test.sh
A valid URL is required
myuser@hostname:~$ ./availability_test.sh google.com cnn.com
The script is expected a single argument only, but got 2.
myuser@hostname:~$ ./availability_test.sh httpbin.org/status/500   # this url should return a status code of 500
httpbin.org/status/500 is not available.
