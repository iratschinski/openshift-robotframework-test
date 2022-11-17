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
Convert Datetime String Millis
    [Arguments]    ${dtString}
    ${dt}=    Get Substring    ${dtString}    0    23
    ${dt}=    Replace String    ${dt}    T    ${SPACE}
    ${dt}=    Convert Date    ${dt}    result_format=epoch    exclude_millis=false
    ${dt}=    Evaluate    (int)(1000*${dt})
    RETURN    ${dt}

Get Local Datetime Millis
    [Arguments]    ${timeZone}
    ${dt}=    Get Current Date    ${timeZone}
    ${dt}=    Convert Datetime String Millis    ${dt}
    RETURN    ${dt}

Get TimeApi DateTime Millis
    [Arguments]    ${timeZone}
    ${response}=    GET
    ...    ${urlTimeApi}
    ...    params=timeZone=${timeZone}
    ...    expected_status=200

    ${dt}=    Convert Datetime String Millis    ${response.json()}[dateTime]
    RETURN    ${dt}

Get TimeApi Timezone
#    ${localTimezone}=    Run Process    cat    /etc/timezone
#    RETURN    ${localTimezone.stdout}
    ${response}=    GET
    ...    ${urlTimeZoneByIp}
    ...    expected_status=200

    RETURN    ${response.text}
