#!/bin/bash
serveur_ip=localhost
serveur_port=8180
serveur_url=''
acceptable_code_min=200
acceptable_code_max=299

response=$(curl --write-out %{http_code} --silent --output /dev/null http://$serveur_ip:$serveur_port$serveur_url)

version2install=1.10.0

#echo $response

echo 'Installation of version : '$version2install

if (( $response >= $acceptable_code_min && $response <= $acceptable_code_max )); then
  echo 'Installation ok'
  rollback=false
else
  echo 'Installation failed'
  rollback=true
fi

if $rollback; then
  regex="([0-9]*)\.([0-9]*)\.([0-9]*)"
  if [[ $version2install =~ $regex ]]; then
    version4rollback="${BASH_REMATCH[1]}.$((${BASH_REMATCH[2]} -1 )).${BASH_REMATCH[3]}"
  fi
  echo 'rollback in verion ' $version4rollback

  serveur_port=8080
  response=$(curl --write-out %{http_code} --silent --output /dev/null http://$serveur_ip:$serveur_port$serveur_url)
  if (( $response >= $acceptable_code_min && $response <= $acceptable_code_max )); then
    echo 'OK after rollback'
    exit 0
  else
    echo 'FAILURE after rollback'
    exit 1
  fi
fi
