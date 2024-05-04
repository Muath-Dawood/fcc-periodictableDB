#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  ELEMENT=$($PSQL "select * from elements inner join properties using (atomic_number) inner join types using (type_id) where atomic_number = $1 or symbol = '$1' or name = '$1';")
  echo $ELEMENT
fi
