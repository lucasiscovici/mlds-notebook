#!/bin/bash
_docker ps --format="{{.Names}}" | grep -q "^$1$" || ( _docker ps -q | grep -q "^$1$" )