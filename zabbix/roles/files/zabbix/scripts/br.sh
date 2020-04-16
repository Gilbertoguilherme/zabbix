#!/bin/bash

codigo_br_http=$(curl --write-out %{http_code} --silent --output /dev/null https://br.evoluservices.com)

echo $codigo_br_http
