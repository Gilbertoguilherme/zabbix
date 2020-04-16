#!/bin/bash
TOTAL=$(free -m | grep Mem | awk '{print $2}')
USED=$(free -m | grep Mem | awk '{print $3}')
PERC=$(($USED*100/$TOTAL))

echo $PERC

