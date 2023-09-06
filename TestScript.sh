#!/bin/bash

# Function to check if given directory exist !!
is_Dir_Exist(){
    local arg="$1"
    ls -d "$arg" &> /dev/null
    return $?	
}
#Clone or Pull WebDriver scripts
if is_Dir_Exist "webdriver-tests"; then
    echo "Latest scripts are pulled from git"
    cd webdriver-tests
    git pull
    cd ..
else
    echo "Fresh scripts are cloned from git"
    git clone https://github.com/TestLeafInc/webdriver-tests
fi

cd webdriver-tests
mvn clean test
aws s3 sync reports/ s3://devops-s3