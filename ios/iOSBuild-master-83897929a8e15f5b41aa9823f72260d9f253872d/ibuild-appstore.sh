#! /bin/bash

AppName="天校"
BundleIdentifier="com.bjhl.tx"
Configuration="Release"
FtpIpaName="/tianxiao/tianxiao/genshuixue_tianxiao_appstore.ipa"
FtpArchiveName="/tianxiao/tianxiao/genshuixue_tianxiao_appstore.xcarchive.zip"
BuildNumber="1407"

if [ ! -d "tianxiao-iphone" ]; then
    git clone -b master-tianxiao git@git.baijiahulian.com:tianxiao-base/tianxiao-iphone.git
fi

cd "tianxiao-iphone"
git reset --hard
git checkout "master-tianxiao"
git pull

BUILD_RESULT=${PIPESTATUS[0]}
#pull 失败 退出
if [ $BUILD_RESULT -ne 0 ]; then
    echo "git pull failed."
    exit 1
fi

git submodule init
git submodule update

pod repo update --verbose
pod update --no-repo-update

BUILD_RESULT=${PIPESTATUS[0]}
#pod update 失败 退出
if [ $BUILD_RESULT -ne 0 ]; then
echo "pod update failed."
exit 1
fi

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${BuildNumber}" BJEducation_Institution/BJEducation_Institution/Info.plist

/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName ${AppName}" BJEducation_Institution/BJEducation_Institution/Info.plist

#jenkins编译
if [ -n $JOB_URL ] && [ -n $BUILD_TAG ]; then
echo "Build use jenkins."
else
BUILD_TAG="Local_`date "+%Y-%m-%d %H:%M:%S"`"
fi
/usr/libexec/PlistBuddy -c "Add :BUILD_TAG string ${BUILD_TAG}" BJEducation_Institution/BJEducation_Institution/Info.plist

#开始编译
xcodebuild -list

rm -rf "./JenkinsArchive"

xcodebuild \
-workspace BJEducation_Institution.xcworkspace \
-scheme BJEducation_Institution \
-configuration ${Configuration} archive \
PROVISIONING_PROFILE="0a44a997-0d8b-4c31-b4ea-2ae863572cd0" \
CODE_SIGN_IDENTITY="iPhone Distribution: Baijiahulian Co., Ltd. (KQPYSP4J84)" \
-archivePath ./JenkinsArchive/BJEducation_Institution-inHouse-${Configuration}.xcarchive \
-derivedDataPath DerivedData \

BUILD_RESULT=${PIPESTATUS[0]}
#build 失败 退出
if [ $BUILD_RESULT -ne 0 ]; then
echo "build failed."
exit $BUILD_RESULT
fi

rm -rf "./JenkinsIPAExport"
mkdir "JenkinsIPAExport"
xcodebuild \
-exportArchive \
-exportFormat IPA \
-exportProvisioningProfile tianxiao_dis \
-archivePath ./JenkinsArchive/BJEducation_Institution-inHouse-${Configuration}.xcarchive \
-exportPath ./JenkinsIPAExport/genshuixue_tianxiao_${Configuration}.ipa

BUILD_RESULT=${PIPESTATUS[0]}
#生成ipa 失败 退出
if [ $BUILD_RESULT -ne 0 ]; then
echo "export ipa failed."
exit $BUILD_RESULT
fi

cd ./JenkinsArchive
zip -r BJEducation_Institution-inHouse-${Configuration}.xcarchive.zip BJEducation_Institution-inHouse-${Configuration}.xcarchive
cd ../

ftp -inv download.genshuixue.com << EOF
user app app@bjhl88/.,
delete ${FtpIpaName}
put ./JenkinsIPAExport/genshuixue_tianxiao_${Configuration}.ipa ${FtpIpaName}
delete ${FtpArchiveName}
put ./JenkinsArchive/BJEducation_Institution-inHouse-${Configuration}.xcarchive.zip  ${FtpArchiveName}
bye
EOF
