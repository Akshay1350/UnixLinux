
add_user()
{
	echo "Provide details do add user: "
	read -p "Fisrt Name : " fname
	read -p "Last Name : " lname
	read -s -p "Password: " pwd
	echo
	read -p "Retype Password:" cpwd
 	if [ $pwd != $cpwd ]; then
		echo "Password not matching:"
		return 1
	fi
	read -p "Zip Code:" zipcode
	if [ ! -e ~/users.dat ];then
		touch ~/users.dat
	fi
       
	count=$(sort ~/users.dat | wc -l)
        if [ $count -eq 0 ]; then
        	uid=100
		nuid=$uid
        else
	        uid=$(cat ~/users.dat | tail -1| cut -d ':' -f 1)
		nuid=$[uid+1]	
        fi
	echo "$nuid:$pwd:$fname:$lname:$zipcode" >> ~/users.dat
	echo "User Added Successfully"
	echo
	echo


}

search_user()
{
	read -p "enter user id :" uid
	read -p "enter Password:" pwd
	count=$(grep $uid ~/users.dat | wc -l)
	if [ $count -eq 0 ]; then
		echo "user id: $uid does not exist"
		return 3
	fi
	count=$(grep $uid ~/users.dat | grep $pwd |wc -l)
	if [ $count -eq 0 ]; then
		echo "Invalid Password"
		return 4
	fi
echo "The complete information of the user:"
record=$(grep $uid ~/users.dat)
echo "User id :$(echo $record | cut -d ':' -f 1)"
echo "User id :$(echo $record | cut -d ':' -f 2)"
echo "User id :$(echo $record | cut -d ':' -f 3)"
echo "User id :$(echo $record | cut -d ':' -f 4)"
echo "User id :$(echo $record | cut -d ':' -f 5)"
echo
echo

}


 			
echo "Welcome to User Management Application"
while [ true ]
do
        echo "1. Add user"
        echo "2. Search user"
        echo "3. Change Password"
        echo "4. Delete User"
        echo "5. Show all users"
        echo "6. Users count"
        echo "7. Exit"
        read -p "enter your choice [1/2/3/4/5/6/7]: " choice
        case $choice in
             1)
                add_user
                ;;
             2)

                search_user
                ;;
             3)
                change_password
                ;;
             4)
                delete_user
                ;;
             5)
                show_all_users
                ;;
             6)
                users_count
                ;;
             7)
                echo "Thanks for using Application"

                exit 0
                ;;
              *)
                echo "Wrong choice ...Try again" 
                ;;
    esac
done               	
