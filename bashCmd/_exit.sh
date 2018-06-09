#!/bin/bash

if [[ -n "$OLD_PS1" ]]; then
 echo -e "MLDS Env '$MLDS_C_CURR' Stopped"
 touch .tmpexit
 builtin exit $@
fi