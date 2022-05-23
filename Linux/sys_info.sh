#!/bin/bash

output=/home/sysadmin/audit_result/sysinfo.txt


if [ ! -d ~/audit_result ]
then
mkdir ~/audit_result
fi

if [ -f ~/audit_result/sys_info ]
then
rm ~/audit_result/sys_info.txt 
fi

# mkdir ~/audit_result 

echo "This is my first script" >> $output

date >> $output

echo -e "this is the uname for the machine: \n$(uname -a)" >> $output

echo -e "The ip address of this machine is located in this line: \n$(ip addr | head -9 | tail -1)" >> $output

echo -e "The hostname is: \n$(hostname)" >> $output

echo -e "Disk usage:\n$(df -H | head -4 | tail -1)" >> $output

# echo -e "\n777 files:" >> ~/audit_result/sys_info.txt
# find -perm 777

echo -e "files with 777 permissions: \n$(find $HOME -perm 777 2> /dev/null)" >> $output

echo -e "top 10 processes running at the moment: \n$(ps -eo pid,user,ppid,cmd,%mem,%cpu --sort=-%cpu | head -11)" >> $output

# ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head -11 >> ~/audit_result/sys_info.txt

#this will print out the permissions of shadow and passwd files 

files=('/etc/shadow' 'etc/passwd')

for files in ${files[@]};

        do

                ls -l $file >> $output
done

