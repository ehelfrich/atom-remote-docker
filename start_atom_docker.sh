#! /bin/bash
Container=$(docker ps | grep remote-atom)

if [[ $Container != "" ]]; then
  echo "Container atom_test is already running!"
else
  ( docker start remote-atom & )
fi
