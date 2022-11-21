*** Settings ***
Documentation       Fourth robot test suite for testing S3

Resource            keywords.resource
Library             DateTime
Library             BuiltIn
Library             OperatingSystem

Test Setup          Setup Minio Tests


*** Test Cases ***
Test Minio Available
    [Documentation]    Tests whether minio connection is successful

Test Minio Can Create Bucket
    [Documentation]    Tests whether a bucket can be created
    Test S3 Can Create Bucket    ${s3}


*** Keywords ***
Setup Minio Tests
    ${s3}=    Connect To Minio
    Set Test Variable    $s3    ${s3}
