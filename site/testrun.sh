#!/usr/bin/env bash

./publish.sh
cd www
python -m SimpleHTTPServer 8000

