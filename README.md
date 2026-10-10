# overview of the code in the folder with the folder hierarchy 
we have to main scripts the (antivirusd.sh and restore.sh). anivirusd.sh checks the selected directory for suspicious files and then moves them to the quarantine directory while restore.sh allows the user to do one of the following 1.restore the quarantined files, 2. delete the quarantine files permenantly. then we have the MakeFile which is used to set up the quarantine directory and run both scripts. we also have the malicious_dir folder where suspicious files are stored.

#Any prerequisites needed and how to install them on Ubuntu
This project runs on Ubuntu. Uses Bash scripts. Therefore Bash and the basic Linux commands must be available. Ubuntu already includes these tools by default so extra software is not required in cases.

To ensure that the required tools are available open the terminal. Run:

```bash

sudo apt update

sudo apt install bash coreutils diffutils make

make --version

chmod +x antivirusd.sh restore.sh

after all of these my files are all ready to use 

#Step-by-step instructions for running the antivirus and restore tools
To run the antivirus tool open the terminal. Go to the project folder. Start by running `make setup`. This makes sure the `malicious_dir` folder is ready. Next run `make daemon DIR=test_dir INTERVAL=5`. Replace `test_dir` with the folder you want to watch and `5` with how you want the script to check in seconds. The script will look for files in the folder and move them to `malicious_dir`. It will keep checking until you stop it by pressing `Ctrl + C`.

To restore or delete files that were moved to quarantine first make sure the folder you want to restore files to already exists. Then run `make restore DIR=test_restore`. Change `test_restore` to the folder you want to use. The script will show a list of all the quarantined files with numbers. Pick the number of the file you want to look at. Then choose `1` to restore it `2` to delete it for good or `3` to go back to the list. After each choice the script shows the files, in quarantine.

#Where in your code the required flagged-extensions and flagged-keywords lists are defined
The flagged extensions are defined in the scan_file() function, inside antivirusd.sh. The script looks for files ending wit ( .exe, .bat, .vbs, .scr, .ps1) The flagged keywords are also checked in the function. These flagged keywords are virus, trojan, malware, worm and ransomware. The script uses grep -qi to search filenames for these flagged keywords without case sensitivity.
