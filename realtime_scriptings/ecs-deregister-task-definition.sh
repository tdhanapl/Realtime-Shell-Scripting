#!/bin/bash

ACCESS_KEY_ID='xxxxxxxxxxxxxxxxxxxxxx'
SECRET_ACCESS_KEY='xxxxxxxxxxxxxxxxxx/ApHu'
REGION='xx-xxxx-x'


aws configure set aws_access_key_id $ACCESS_KEY_ID --profile test              
aws configure set aws_secret_access_key $SECRET_ACCESS_KEY --profile test       
aws configure set region $REGION --profile test                            


echo 'Wait while the tasks are displayed' 
sleep 2



get_task_definition_arns() {
    echo 'Wait while the task definitions are displayed' 
    sleep 2
    aws ecs list-task-definitions --region $REGION | jq -M -r '.taskDefinitionArns | .[]'
}

delete_task_definition() {
    local arn=$1
    aws ecs deregister-task-definition --region $REGION  --task-definition "${arn}" > /dev/null
}

for arn in $(get_task_definition_arns)
do
    echo "Deregistering ${arn}..."
    delete_task_definition "${arn}"
done