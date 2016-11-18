#!/bin/bash
echo "hello"
printf "hello \n"

printf "%-10s %-8s %-4s\n" name sex weight
printf "%-10s %-8s %-4.2f\n" name1 man 10
printf "%-10s %-8s %-4.2f\n" name2 woman 20

printf "%d %s\n" 1 "abc"
printf '%d %s\n' 1 "abc"
printf %s abcdef

printf "%s\n" abc def
printf %s abc def

printf "\n"

printf "%s %s %s\n" a b c d e f g h i j

printf "%s and %d\n"

printf "name is %s\n" "zl"