#!/bin/sh

JENKINS_SEED_JOB=.pipeline-seed
JENKINS_HOST=http://localhost:8080
: ${JENKINS_USERNAME?"JENKINS_USERNAME is not defined"}
: ${JENKINS_API_TOKEN?"JENKINS_API_TOKEN is not defined"}

function abort() {
    echo $@ >&2
    exit 1
}

function usage() {
    echo "Usage: $(basename $0) JOB_NAME"
}

function create_job() {
    local job_name=$1
    local username=$2
    local password=$3
    local seed_xml=$4

    create_job_url=$JENKINS_HOST/createItem?name=$job_name

    echo "$seed_xml" | curl -v                                   \
                        -H"Content-Type: text/xml"               \
                        --user $username:$password               \
                        --data-binary @-                         \
                        $create_job_url

}

function main() {
    local job_name=$1

    if [[ -z "$job_name" ]]; then
        usage
        exit 1
    fi

    username=$JENKINS_USERNAME
    password=$JENKINS_API_TOKEN

    seed_url=$JENKINS_HOST/job/.pipeline-seed/config.xml
    seed_xml=$(curl -s --user $username:$password $seed_url)

    echo Creating job $job_name
    create_job $job_name $username $password "$seed_xml"

}

main $@
