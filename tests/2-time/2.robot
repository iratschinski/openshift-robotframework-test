*** Settings ***
Documentation       Second robot test suite with some API tests

Resource            keywords.resource
Library             DateTime
Library             BuiltIn
Library             OperatingSystem


*** Test Cases ***
Test time is in sync
    [Documentation]    Tests whether the current time of the pod is in sync
    ${localTime}=    Get Current Date    result_format=epoch    exclude_millis=true
    ${localTime}=    Convert To Integer    ${localTime}

    ${localTimezone}=    Get Local Timezone

    Log    LocalTimeZone=${localTimeZone}

    ${apiTime}=    Load TimeAPI Time    ${localTimezone}
    ${apiTime}=    Convert Date    ${apiTime}    result_format=epoch    exclude_millis=true
    Log    LocalTime=${localTime} ApiTime=${apiTime}
    ${diffTime}=    Evaluate    abs(int(${localTime})-int(${apiTime}))
    Should Be True    ${diffTime} < 10
