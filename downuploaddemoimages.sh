#!/bin/bash
K8S_HOME=/opt/kubernetes

sh $K8S_HOME/scripts/downloadimages.sh -D $K8S_HOME/scripts -s demo -r cdfregistry.hpeswlab.net -u CoreTech -p 1Qaz2wsx && sh $K8S_HOME/scripts/uploadimages.sh || exit 1
