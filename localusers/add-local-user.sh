#!/bin/bash

# Display the UID
echo "Your UID is ${UID}"
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}"

# Compare the UID if this isn't the root then fail
if [[ "${UID}" -ne 0 ]]
then
  echo 'You are not root'
  exit 1 # Script doesn't end with success
else
  echo 'You are root'
fi

# Ask for the username/real name/password
read -p 'Enter the username to create: ' USER_NAME
read -p 'Enter the name of the person who this account is for: ' PERSON_NAME
read -p 'Enter the password to user for the account: ' PASSWORD

# Add User
useradd -c "${PERSON_NAME}" -m ${USER_NAME}     # CREATE THE USER
echo ${PASSWORD} | passwd --stdin ${USER_NAME}  # SET THE PASSWORD
passwd -e ${USER_NAME}                          # FORCE PASSWORD CHANGE

# Control Exit Code
if [ ${?} -ne 0 ]
then
  echo "USER CREATE IS FAILED. THE EXIT CODE IS ${?}"
# Prompt Created User
else
  echo "USERNAME IS: ${USER_NAME}"
  echo "PERSON IS: ${PERSON_NAME}"
  echo "INITIAL PASSWORD IS ${PASSWORD}"
fi
