*** Settings ***
Documentation       Third robot test suite for testing jupyterhub

Resource            keywords.resource
Library             DateTime
Library             BuiltIn
Library             OperatingSystem


*** Variables ***
${DIFF_LESS}    12000


*** Test Cases ***
Test Jupyter AutoApi is available
    [Documentation]    Tests whether the jupyter auto api is available
    ${status}=    Get Jupyter AutoApi Status

    Should Be Equal    ${status}    ok

Test Jupiter AutoApi Defect
    [Documentation]    Tests whether the defect recognition works

    Recognize Defect    brakes    It is not possible to stop my car immediately
    Recognize Defect    starter    The engine does not work
    Recognize Defect    other    Something is wrong in my car
    Recognize Defect    starter    This test must fail, because I say nothing about the car
