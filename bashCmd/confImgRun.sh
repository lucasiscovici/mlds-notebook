#!/bin/bash
dkg=""
dkd=\"$([[ -z "$(./myEnv.sh getIm)" ]] && echo -n $dkg || echo image=$(./myEnv.sh getEnvIm) latest=)\"
# echo "DEBUG $dkd"
dkd=\"$([[ -z "$(./_getEnv.sh BASED)" ]] && echo -n $dkd  || echo image=$(./_getEnv.sh BASED) latest=)\"
echo $dkd