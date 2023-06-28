#! /bin/bash

rm -rf Results/*
chmod a+x run-xv6-command-user.exp
./run-xv6-command-user.exp &> Results/Results.txt

file_contents=$(cat Results/Results.txt)
echo "$file_contents" | awk '/\$/{flag=!flag}flag' &> tmp.txt

tail -n +2 tmp.txt > tmp2.txt
rm -f Results/Results.txt
rm -f tmp.txt
mv tmp2.txt Results/Results.txt
