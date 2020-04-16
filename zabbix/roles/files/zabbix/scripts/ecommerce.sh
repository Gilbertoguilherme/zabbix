#!/bin/bash

codigo_http=$(curl --write-out %{http_code} --silent --output /dev/null https://ecommerce.evoluservices.com/swagger-ui.html)

echo $codigo_http
