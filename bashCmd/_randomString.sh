#!/bin/bash
nb=${1:-10}
LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w $nb | head -n 1

