#! /bin/bash

remoteBranch=$1

if [ ! -n "$remoteBranch" ]; then
    params=""
else
    params=$remoteBranch
fi

sources=("tianxiao-iphone" "tianxiao-base-iphone" "tianxiao-account-iphone-sdk" "tianxiao-crm-iphone-sdk" "tianxiao-erp-iphone-sdk" "tianxiao-marketing-iphone-sdk" "tianxiao-netschool-iphone-sdk" "tianxiao-person-iphone-sdk" "tianxiao-im-iphone-sdk")

for source in ${sources[*]}
do
    echo "checkout $source."
    cd $source
    RESULT=${PIPESTATUS[0]}
    if [ $RESULT -eq 0 ]; then
        git checkout $params||exit
        cd ../
    fi
done
