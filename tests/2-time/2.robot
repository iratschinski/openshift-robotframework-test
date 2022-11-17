*** Settings ***
Documentation       Second robot test suite with some API tests

Resource            keywords.resource
Library             DateTime
Library             BuiltIn
Library             OperatingSystem


*** Test Cases ***
Test Time Is In Sync
    [Documentation]    Tests whether the current time of the pod is in sync
    ${apiMillis}=    Get TimeApi Datetime Millis    UTC
    ${localMillis}=    Get Local Datetime Millis    UTC

    ${diff}=    Evaluate    abs(${localMillis}-${apiMillis})
    Log    LocalMillis=${localMillis} ApiMillis=${apiMillis} Diff=${diff}
    Should Be True    ${diff} < 12000

Test Timezone Is Correct
    [Documentation]    Tests whether the current timezone is correct due to geoposition

    ${apiTimezone}=    Get TimeApi Timezone
    Log    ApiTimeZone=${apiTimezone}

    ${apiMillis}=    Get TimeApi Datetime Millis    ${apiTimezone}
    ${localMillis}=    Get Local Datetime Millis    UTC

    ${diff}=    Evaluate    abs(${localMillis}-${apiMillis})
    Log    LocalMillis=${localMillis} ApiMillis=${apiMillis} Diff=${diff}
    Should Be True    ${diff} < 12000
