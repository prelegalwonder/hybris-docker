#!/bin/bash

if [ -f /opt/hybris/.configured ]
  then
    true
else 
  echo "First time container is being run, setting up environment..."
  for i in `env | grep HYB-`
    do
      KEY=`echo $i | cut -f1 -d'='`
      VAL=`echo $i | cut -f2- -d'='`
      echo "Replacing any instances of @$KEY@ with $VAL"
      sed -i "s/@$KEY@/$(echo $VAL | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')/g" /opt/hybris/current/hybris/config/local.properties 
  done

  echo "Populating values from local.properties into server configs.."
  cd /opt/hybris/current/hybris/bin/platform
  . ./setantenv.sh
  ant server
fi

/opt/hybris/current/hybris/bin/platform/hybrisserver.sh


