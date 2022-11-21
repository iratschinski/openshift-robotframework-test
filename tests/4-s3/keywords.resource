*** Settings ***
Library     String
Library     Collections
Library     DateTime
Library     RequestsLibrary
Library     Process
Library     json
Library     ../../lib/s3.py


*** Variables ***
${s3_host}      172.25.163.200
${s3_port}      9000
${s3_secure}    false
${s3_access}    Z3kKzv67I8IeOVMf
${s3_secret}    vySJiiUGtEike28jytP4UZpYJaGX9Hsq


*** Keywords ***
Connect To Minio
    ${s3}=    Connect To S3    ${s3_host}    ${s3_port}    ${s3_access}    ${s3_secret}    ${s3_secure}
    RETURN    ${s3}

Test S3 Can Create Bucket
    [Documentation]    Tests whether a bucket can be created
    [Arguments]    ${s3}
    ${randomString}=    Generate Random String    30    [LOWER]-
    Create Bucket    ${s3}    ${randomString}
    ${exists}=    Does Bucket Exist    ${s3}    ${randomString}
    Should Be True    ${exists}    Bucket ${randomString} could not be created
    [Teardown]    Remove Empty Bucket    ${s3}    ${randomString}
