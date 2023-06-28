#!/bin/bash

RED=`tput setaf 1`
GRN=`tput setaf 2`
WHT=`tput sgr0`
score=0
tt=0
file1="Results/Results.txt"
file2="Test_Results/Results.txt"
i_list=(1 2 3 9 17 18 27 29)  # Array of i values
j_list=(1 2 8 16 17 26 28 38)  # Array of j values

# Iterate over the indices of i_list (assuming it has the same length as j_list)
for index in "${!i_list[@]}"; do
    tt=$((tt+1))
    i=${i_list[$index]}
    j=${j_list[$index]}

    # Extract lines between i and j from file1
    lines_file1=$(head -n "$j" "$file1" | tail -n +"$i")

    # Extract lines between i and j from file2
    lines_file2=$(head -n "$j" "$file2" | tail -n +"$i")

    # Compare the lines
    if [[ "$lines_file1" == "$lines_file2" ]]; then
        echo -e "${GRN}Test${tt} passed.${WHT}"
        score=$((score+10))
    else
        echo -e "${RED}Test${tt} failed!${WHT}"
    fi
done

printf "You get %d/80 scores.\n" "$score"
