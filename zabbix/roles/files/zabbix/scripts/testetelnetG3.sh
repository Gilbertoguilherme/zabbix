#!/bin/bash

TELNETPROXYREVERSO=$(nc -w 0 172.30.96.231 22084; echo $?)

echo $TELNETPROXYREVERSO

