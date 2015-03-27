#!/bin/bash
set -e

cd /home/app/application && passenger start -p 4000 --pid-file=/home/app/passenger.pid --log-file=/home/app/passenger.log
