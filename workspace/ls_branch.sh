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
    echo -e "\033[37m SDK: $source.\033[0m"
    cd $source
    RESULT=${PIPESTATUS[0]}
    if [ $RESULT -eq 0 ]; then
        echo -e "\033[33m branch: $(git rev-parse --abbrev-ref HEAD) \003"||exit
        echo ""
        cd ../
    fi
done
