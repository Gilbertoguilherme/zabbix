#!/bin/bash

codigo_cadas_http=$(curl --write-out %{http_code} --silent --output /dev/null https://cadastro.saudeservice.com.br/register)

echo $codigo_cadas_http
