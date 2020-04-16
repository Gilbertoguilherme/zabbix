#!/bin/bash

codigo_gray_http=$(curl --write-out %{http_code} --silent --output /dev/null https://graylog.evoluservices.com)

echo $codigo_gray_http
