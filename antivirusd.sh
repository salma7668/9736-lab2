
#!/bin/bash
monitor_dir=$1
quarantine_dir=$2
timeint=$3
if [ $# -ne 3 ]; then 
echo "please make sure to use three arguments: monitor director, quarantine directory and  time interval in seconds"
exit 1
fi
if [[ ! "$timeint" =~ ^[0-9]+$ ]]; then
echo "Please enter a positive whole number for the time interval"
exit 1
fi
if [ "$timeint" -le 0 ]; then
echo "Please enter a time interval greater than zero"
exit 1
fi
if [ ! -d  "$monitor_dir" ]; then
echo "this directory doesnt exist"
exit 1
fi
if [ ! -d  "$quarantine_dir" ]; then
echo "this directory doesnt exist"
exit 1
fi
ls -l "$monitor_dir" > directory-info.last 
scan_file() {
for file in "$monitor_dir"/*
do
filename=$(basename "$file")
if [[ $file == *.exe || $file == *.bat || $file == *.vbs || $file == *.scr || $file == *.ps1 ]]; then 
echo "$(basename "$file") is malicious and it is DELETED"
cp "$file" "$quarantine_dir"
rm "$file"
elif grep -qi "virus" "$file" || grep -qi "trojan" "$file" || grep -qi "malware" "$file" || grep -qi "worm" "$file" || grep -qi "ransomware" "$file"; then
echo "$(basename "$file") is malicious and it is DELETED"
cp "$file" "$quarantine_dir"
rm "$file"
fi
done }
scan_file
ls -l "$monitor_dir" > directory-info.last
while true 
do 
sleep "$timeint"
ls -l "$monitor_dir" > directory-info.new
diff directory-info.last directory-info.new
if [ $? -eq 1 ]; then
scan_file 
ls -l "$monitor_dir" > directory-info.new
cp "directory-info.new" "directory-info.last"
fi
done
