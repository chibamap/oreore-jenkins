#!/bin/bash
_pwd=$(cd -P `dirname $0` && pwd)

ssh-keygen -t rsa -N "" -f $_pwd/id_key
