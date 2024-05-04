#!/bin/bash

# define data base query variable
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
# check if argument
if [[ -z $1 ]]
then
  # if no argument message
  echo Please provide an element as an argument.
else
  # check if argument a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # query if argument anumber
    ELEMENT=$($PSQL "select * from elements inner join properties using (atomic_number) inner join types using (type_id) where atomic_number = $1;")
  else
    # query if argument not number
    ELEMENT=$($PSQL "select * from elements inner join properties using (atomic_number) inner join types using (type_id) where symbol = '$1' or name = '$1';")
  fi
  # check if query result
  if [[ -z $ELEMENT ]]
  then 
    # if element not found message
    echo 'I could not find that element in the database.'
  else
    # formatted message for found element
    IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE <<< $ELEMENT
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi

fi
