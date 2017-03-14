#! /bin/bash

AppName="天校"
BundleIdentifier="com.baijiahulian.tx"
Configuration="Release"
FtpIpaName="/tianxiao/tianxiao/genshuixue_tianxiao_master2.ipa"
FtpArchiveName="/tianxiao/tianxiao/genshuixue_tianxiao_master2.xcarchive.zip"

if [ ! -d "tianxiao-iphone" ]; then
git clone -b master-tianxiao-demo git@git.baijiahulian.com:tianxiao-base/tianxiao-iphone.git
fi

cd "tianxiao-iphone"

git reset --hard
git checkout "master-tianxiao-demo"

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

sed -i '' "s/com.bjhl.tx/${BundleIdentifier}/" BJEducation_Institution/BJEducation_Institution.xcodeproj/project.pbxproj
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

xcodebuild -workspace BJEducation_Institution.xcworkspace -scheme BJEducation_Institution -configuration ${Configuration} archive PROVISIONING_PROFILE="5550ab1a-7684-4d5c-9b95-5a580c99725d" CODE_SIGN_IDENTITY="tianxiao_inhouse" -archivePath ./JenkinsArchive/BJEducation_Institution-inHouse-${Configuration}.xcarchive -derivedDataPath DerivedData

BUILD_RESULT=${PIPESTATUS[0]}
#build 失败 退出
if [ $BUILD_RESULT -ne 0 ]; then
echo "build failed."
exit $BUILD_RESULT
fi

rm -rf "./JenkinsIPAExport"
mkdir "JenkinsIPAExport"
xcodebuild -exportArchive -exportFormat IPA -exportProvisioningProfile tianxiao_inhouse -archivePath ./JenkinsArchive/BJEducation_Institution-inHouse-${Configuration}.xcarchive -exportPath ./JenkinsIPAExport/genshuixue_tianxiao_${Configuration}.ipa

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

