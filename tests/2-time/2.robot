*** Settings ***
Documentation       Second robot test suite with some API tests

Resource            keywords.resource
Library             DateTime
Library             BuiltIn
Library             OperatingSystem


*** Variables ***
${DIFF_LESS}    12000


*** Test Cases ***
Test Time Is In Sync
    [Documentation]    Tests whether the current time of the pod is in sync
    ${apiMillis}=    Get TimeApi Datetime Millis    UTC
    ${localMillis}=    Get Local Datetime Millis    UTC

    ${diff}=    Evaluate    abs(${localMillis}-${apiMillis})

    Log    LocalMillis=${localMillis} ApiMillis=${apiMillis} Diff=${diff}

    Should Be True    ${diff} < ${DIFF_LESS}

Test Timezone Is Correct
    [Documentation]    Tests whether the current timezone is correct due to geoposition

    Skip

    ${apiTimezone}=    Get TimeApi Timezone

    ${apiMillis}=    Get TimeApi Datetime Millis    ${apiTimezone}
    ${localMillis}=    Get Local Datetime Millis    UTC

    ${diff}=    Evaluate    abs(${localMillis}-${apiMillis})

    Log    ApiTimeZone=${apiTimezone} LocalMillis=${localMillis} ApiMillis=${apiMillis} Diff=${diff}

    Should Be True    ${diff} < ${DIFF_LESS}
