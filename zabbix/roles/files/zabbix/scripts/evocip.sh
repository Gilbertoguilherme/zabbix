#!/bin/bash

codigo_evo_http=$(curl --write-out %{http_code} --silent --output /dev/null https://cip.evoluservices.com/files)

echo $codigo_evo_http
