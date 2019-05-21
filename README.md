# Localstack

## Introduction

Setup a fully functional local AWS cloud stack interation multiple projects, different php version in your docker enviroment.

- Localstack
- Apache2
- Mysql
- Php-fpm

## Getting Started
### Requirements
- [Git](https://git-scm.com/downloads)
- [Docker](https://store.docker.com/editions/community/docker-ce-desktop-mac) >= 17.12

### Installation

#### Build development environment

After clone the project, make `.env` then build containers.
```
cp env-example .env
```
```
./dev build
```

Waiting for a while to finish building containers. Then start run containers.
```
./dev run
```

### Initial Localstack

#### S3

- Create bucket
```
awslocal s3 mb [bucket-name]
```
>ex: awslocal s3 mb s3://demo-bucket

- Attach an ACL to the bucket so it is readable
```
awslocal s3api put-bucket-acl --bucket [bucket-name] --acl public-read
```
>ex: awslocal s3api put-bucket-acl --bucket demo-bucket --acl public-read

#### SQS

- Create SQS queue
```
awslocal sqs create-queue --queue-name [queue-name]
```
>ex: awslocal sqs create-queue --queue-name LC_Error_Log_Queue_local

- Get event source ARN
```
awslocal sqs get-queue-attributes --queue-url [queue-url] --attribute-name QueueArn
```
>ex: awslocal sqs get-queue-attributes --queue-url http://localhost:4576/queue/LC_Error_Log_Queue_local --attribute-name QueueArn

*Note:*  Use this ARN to update event source mapping of lambda function to trigger event.

#### Lambda

- Create lambda function and mount local code 
```
awslocal lambda create-function --function-name [function_name] --code S3Bucket="__local__",S3Key="[path_to_your_lambda_folder]" --handler [handler_function] --runtime [runtime_version] --role [whatever] --environment Variables={[your_constant_environment]}
```
>ex: awslocal lambda create-function --function-name LC_Error_Log_local --code S3Bucket="__local__",S3Key="/Users/macintosh/Projects/log_collector/lambda" --handler error_log.process --runtime nodejs8.10 --role arn:aws:iam::123456:role/role-name --environment Variables={ENVIRONMENT=testing}

- Update trigger event source mapping
```
awslocal lambda create-event-source-mapping --event-source-arn [arn_of_another_event] --function-name [lambda_function_name]
```
>ex: awslocal lambda create-event-source-mapping --event-source-arn arn:aws:sqs:elasticmq:000000000000:LC_Error_Log_Queue_local --function-name LC_Error_Log_local

- Invoke lambda function
```
awslocal lambda invoke --function-name [lambda_function_name] outfile.txt
```
>ex: awslocal lambda invoke --function-name LC_Error_Log_local outfile.txt

- View log in cloud watch log
```
docker logs [localstack_docker_container]
```
>ex: docker logs laradock_localstack_1_c3ea9fc6113b

#### Kinesis

- Create kinesis stream
```
awslocal kinesis create-stream --stream-name [kinesis_name] --shard-count [shard_count_number]
```
>ex: awslocal kinesis create-stream --stream-name core-kinesis-local --shard-count 1