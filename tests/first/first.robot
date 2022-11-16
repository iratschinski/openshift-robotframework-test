*** Settings ***
Documentation       First robot test suite with different tests
...
...                 Keywords are imported from the resource file

Resource            keywords.resource
Library             DateTime
Library             BuiltIn
Library             OperatingSystem


*** Variables ***
${text}     Ein kleiner text


*** Test Cases ***
Test simple assertions
    [Documentation]    Shows simple assertions
    Should Be Title Case    Robot Framework
    Should Be Equal    Text123    Text123
    Should Be True    5 + 5 == 10
    Length Should Be    ${text}    16

Test with Keywords
    Store Text    Hail Our Robot
    Add Text To Stored Text    Overlords!
    Verify Stored Text Length    25
    ${current_text}=    Get Stored Text
    Should Be Equal    ${current_text}    Hail Our Robot Overlords!

Test for the year 2022
    [Documentation]    Tests if it is still 2022...
    ${date}=    Get Current Date    result_format=datetime
    Log    ${date}
    Log    ${date.year}
    Should Be Equal As Strings    ${date.year}    2022

Test time is in sync
    [Documentation]    Tests whether the current time of the pod is in sync
    ${localTime}=    Get Current Date    result_format=epoch    exclude_millis=true
    ${localTime}=    Convert To Integer    ${localTime}

    ${localTimezone}=    Get Local Timezone

    ${apiTime}=    Load TimeAPI Time    ${localTimezone}
    ${apiTime}=    Convert Date    ${apiTime}    result_format=epoch    exclude_millis=true
    Log    LocalTime=${localTime} ApiTime=${apiTime}
    ${diffTime}=    Evaluate    abs(int(${localTime})-int(${apiTime}))
    Should Be True    ${diffTime} < 10
