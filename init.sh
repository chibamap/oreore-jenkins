#!/bin/bash

set -e

_pwd=$(cd -P `dirname $0` && pwd)

keygen(){
  if [ -f $_pwd/slave/id_key ]; then
    echo 'slave key already exists. skip it.'
    return
  fi
  ssh-keygen -t rsa -N "" -f $_pwd/slave/id_key
}


keygen
