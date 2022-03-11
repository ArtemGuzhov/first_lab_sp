#!/bin/bash

echo "Directory File Viewer!"
echo "With this program, you can view the files of the catalog."
echo "Developer: Guzhov Artem"
currentDirectory=$(pwd)
echo "Current directory: $currentDirectory"
while read -p "Please, enter your username: ";
do
userName="$REPLY"
getent passwd "$userName" > /dev/null
if [[ $? -ne 0 ]]; 
then 
echo "This user does not exist"
else
break
fi
done
while read -p "Enter the directory you are interested in: "; 
do
selectedDirectory=$REPLY
foundDirectory=($(ls | grep $selectedDirectory))
if [[ ${#foundDirectory[@]} -ne 0 ]];
then
if [[ ${#foundDirectory[@]} -eq 1 ]];
then
echo "All files in this directory:"
find ${foundDirectory[0]} -user ${userName}
while read -p "Do you want to continue? (y/n): ";
do
answer=$REPLY
if [[ "$answer" = "y" ]];
then
break
fi
if [[ "$answer" = "n" ]];
then
exit
fi
done
else
echo "Found the following directories: "
for (( i=0; i<${#foundDirectory[@]}; i++ ));
do
numberDirectory=$(( i + 1 ))
echo "$numberDirectory. ${foundDirectory[i]}"
done
while read -p "Select the desired directory from the list: ";
do
selectedNumber=$REPLY
for (( i=0; i<${#foundDirectory[@]}; i++ ));
do
numberDirectory=$(( i + 1 ))
if [[ ${selectedNumber} -eq ${numberDirectory} ]];
then
echo "All files in this directory:"
find ${foundDirectory[selectedNumber - 1]} -user ${userName}
while read -p "Do you want to continue? (y/n): ";
do
answer=$REPLY
if [[ "$answer" = "y" ]];
then
break
fi
if [[ "$answer" = "n" ]];
then
exit
fi
done
fi
#echo "$numberDirectory. ${foundDirectory[i]}"
done
if [[ "$answer" = "y" ]];
then
break
fi
done
fi
else 
echo "This directory does not exist..."
fi
done
