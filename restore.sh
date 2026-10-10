#!/bin/bash
restore_dir=$1
quarantine_dir=$2
if [ $# -ne 2 ]; then
echo "Please provide two arguments: restore directory and quarantine directory"
exit 1
fi
if [ ! -d "$restore_dir" ]; then
echo "restore directory does not exist"
exit 1
fi
if [ ! -d "$quarantine_dir" ]; then
echo "quarantine directory does not exist"
exit 1
fi
if [ -z "$(ls -A "$quarantine_dir")" ]; then
echo " no malicious files to review"
exit 0
fi
while true
do 
files=("$quarantine_dir"/*)
i=1
echo " the quarantined files:"
for file in "${files[@]}"
do
if [ -f "$file" ]; then
echo "$i. $(basename "$file")"
((i++))
fi
done
echo " please enter the file number you would like to review"
read file_choice
echo "1. restore file"
echo "2. permenantly delete file"
echo "3. return to file list"
echo "Enter your action:"
read action
if [[ "$file_choice" =~ ^[0-9]+$ ]] && [ "$file_choice" -ge 1 ] && [ "$file_choice" -le "$((i-1))" ]; then
case "$action" in
1)
selected_file="${files[$((file_choice-1))]}"
cp "$selected_file" "$restore_dir"
rm "$selected_file"
echo "$(basename "$selected_file") has been restored to $restore_dir"
;;
2)
selected_file="${files[$((file_choice-1))]}"
rm "$selected_file"
echo "$(basename "$selected_file") is permanently deleted"
;;
3)
continue
;;
*)
echo "invalid choice"
;;
esac
fi
done
