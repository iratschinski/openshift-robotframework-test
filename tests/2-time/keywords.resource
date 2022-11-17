*** Settings ***
Library     String
Library     Collections
Library     DateTime
Library     RequestsLibrary
Library     Process


*** Variables ***
${urlTimeApi}           https://www.timeapi.io/api/Time/current/zone
${urlTimeZoneByIp}      https://ipapi.co/timezone


*** Keywords ***
Load TimeAPI Time
    [Arguments]    ${timeZone}
    ${response}=    GET
    ...    ${urlTimeApi}
    ...    params=timeZone=${timeZone}
    ...    expected_status=200

    ${apiTime}=    Get Substring    ${response.json()}[dateTime]    0    23
    ${apiTime}=    Replace String    ${apiTime}    T    ${SPACE}
    RETURN    ${apiTime}

Get Local Timezone
#    ${localTimezone}=    Run Process    cat    /etc/timezone
#    RETURN    ${localTimezone.stdout}
    ${response}=    GET
    ...    ${urlTimeZoneByIp}
    ...    expected_status=200

    RETURN    ${response.text}
