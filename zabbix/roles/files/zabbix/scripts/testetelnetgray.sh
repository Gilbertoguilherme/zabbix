#!/bin/bash

TELNETPROXYREVERSO=$(nc -w 0 input-graylog.evoluservices.com 12201; echo $?)

echo $TELNETPROXYREVERSO
