i
#!/bin/bash 
#Purpose is to add user and password while setting parameter for them both .

clear 
trap ""SIGHUP SIGINT

while true 
do
	echo -n "Create your username: "
	read username
	if [ ${#username} -gt 0 ]
	then 
		if [ $(cat /etc/passwd | grep $username) ]
                then
                        echo "Username is already in uses. Please choose another one."
                elif [ ${#username} -gt 7 ] && [ ${#username} -lt 20 ]
                then
                        break
                else
                        echo "Username must be between 7  to 20 characters."
                fi
        else
                echo "Username is invllid."
        fi
 
done
 
# Get the password and check if they match.
while true
do
        echo -n "Create a password no less than 6 characters"
        echo -n "Password: "
        read password
        echo -n "Confirm password: "
        read password_confirm
        if [ ${#password} -gt 6 ] || [ ${#password_confirm} -gt 6 ]
        then
                if [ $password == $password_confirm ]
                then
                        break
                else
                        echo "Passwords do not match."
                fi
        else
                echo "Password can not be less than 6 characters ."
        fi
done
 
# Add user
useradd $username -m -s /bin/bash -G users
 
# Give user password
echo $username:$password | chpasswd
 
echo "Account created! Please login to your new account."
 
kill -HUP $PPID
