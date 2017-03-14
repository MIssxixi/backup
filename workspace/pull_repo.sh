#! /bin/bash

#
#if [ $# != "1" ]; then
#        echo "Usage: update_repo［REMOTE_BRANCH］" 1>&2
#        return 1
#fi

remoteBranch=$1

#set -- `getopt acdhimwe:fo "$@"`                              #set -- 重新组织$1 等参数
#while  [ -n "$1" ]
#    do
#    echo "\$1 is $1"
#    case $1 in
#        -a)
#            make_arch
#            ;;
#        -c)
#            make_clean
#            ;;
#
#        --)
#            shift
#            break
#            ;;
#    esac
#    shift
#done


if [ ! -n "$remoteBranch" ]; then
    params=""
else
    params="origin $remoteBranch"
fi

sources=("tianxiao-base-iphone" "tianxiao-account-iphone-sdk" "tianxiao-crm-iphone-sdk" "tianxiao-erp-iphone-sdk" "tianxiao-marketing-iphone-sdk" "tianxiao-netschool-iphone-sdk" "tianxiao-person-iphone-sdk" "tianxiao-im-iphone-sdk")

for source in ${sources[*]}
do
    echo "pull for $source."
	cd $source
    RESULT=${PIPESTATUS[0]}
    if [ $RESULT -eq 0 ]; then
        git pull $params||exit
        cd ../
    fi
done

cd "tianxiao-iphone"

git stash||exit
git pull $params||exit
git stash pop||exit

git submodule update||exit

pod repo update --verbose||exit
pod update --no-repo-update||exit


