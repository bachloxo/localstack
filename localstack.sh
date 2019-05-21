#!/bin/sh
########################################################
#********    LOCALSTACK INIT AWS SERVICES   ***********#
########################################################
# ./dev open localstack
# awslocal es create-elasticsearch-domain --domain-name core_main
# awslocal sqs create-queue --queue-name LC_Error_Log_Queue_local
awslocal s3 mb s3://demo-bucket