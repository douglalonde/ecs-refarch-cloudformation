#!/bin/sh

if [ "$#" -ne 2 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 INFRASTRUCTURE_REPO_DIR CLUSTER_NAME" >&2
  exit 1
fi

INFRASTRUCTURE_REPO=$1
CLUSTER=$2

aws s3 sync $INFRASTRUCTURE_REPO s3://ecs-cloudformation-dlalonde-demo2

aws cloudformation update-stack --stack-name $CLUSTER --template-url https://s3.amazonaws.com/ecs-cloudformation-dlalonde-demo2/master.yaml --tags Key=Platform,Value=$CLUSTER --capabilities CAPABILITY_NAMED_IAM
