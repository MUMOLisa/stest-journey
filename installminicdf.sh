#!/bin/bash
VERSION=""
HA_VIRTUAL_IP=""

if [ $# -eq 0 ] ;then
	echo "usage" ; exit 1
fi
while [ $# -gt 0 ];do
	case "$1" in
		-v|--version)
		case "$2" in
             		 -*) echo "-v|--version parameter requires a value. " ; exit 1 ;;
           		 *)  if [[ -z $2 ]] ; then echo "-v|--version parameter requires a value. " ; exit 1 ; fi ; VERSION=$2 ; shift 2 ;;
        	esac ;;
		-vip|--ha_virtual_ip) 
		case "$2" in
                         -*) echo "-vip|--ha_virtual_ip parameter requires a value. " ; exit 1 ;;
                          *)  if [[ -z $2 ]] ; then echo "-vip|--ha_virtual_ip parameter requires a value. " ; exit 1 ; fi ; HA_VIRTUAL_IP=$2 ; shift 2 ;;
                esac ;;
		*) echo "usage" ; exit 1 ;;
	esac 
done
if [ -z "$VERSION"] ; then
	echo "usage" ; exit 1
fi

cd /tmp
wget http://16.186.77.44:8080/jenkins/view/Demo/job/demo-metadata/lastSuccessfulBuild/artifact/demo-suite/data/metadata.tar.gz
cd /root
wget http://16.186.77.44:8080/jenkins/view/1.cdf-dailybuild/job/daily_201801/lastSuccessfulBuild/artifact/installer/target/ITOM_Suite_Foundation_2018.01.${VERSION}.zip && unzip ITOM_Suite_Foundation_2018.01.${VERSION}.zip && cd ITOM_Suite_Foundation_2018.01.${VERSION} || exit 1
if [ ! -z ${HA_VIRTUAL_IP} ] ; then
sed -i "s/#HA_VIRTUAL_IP=\"\"/HA_VIRTUAL_IP=\"${HA_VIRTUAL_IP}\"/g" install.properties
fi
./install -m /tmp/metadata.tar.gz  --silent --password Admin111
