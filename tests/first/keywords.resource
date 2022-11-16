*** Settings ***
Library     String
Library     Collections
Library     DateTime
Library     RequestsLibrary


*** Variables ***
${urlTimeApi}       "https://www.timeapi.io/api/Time/current/zone?timeZone=Europe/Berlin"


*** Keywords ***
Store Text
    [Arguments]    ${text}
    log    The text "${text}" will be store in the variable \${stored_text}.
    Set Suite Variable    ${stored_text}    ${text}

Add Text To Stored Text
    [Arguments]    ${text}
    ${full_text}=    Set Variable    ${stored_text} ${text}
    Log    The resulting text is: ${full_text}
    Set Suite Variable    ${stored_text}    ${full_text}

Verify Stored Text Length
    [Arguments]    ${expected_length}
    Length Should Be    ${stored_text}    ${expected_length}

Get Stored Text
    RETURN    ${stored_text}

Check Correct Greeting
    [Arguments]    ${greeting}
    IF    $greeting == 'Hail Our Robot Overlords!'
        Log To Console    \nYou may proceed...
    ELSE
        Fail    Sorry. But that was the wrong answer... Bye Bye...
    END

Load TimeAPI Time
    [Arguments]    ${timeZone}
    ${response}=    GET
    ...    https://www.timeapi.io/api/Time/current/zone
    ...    params=timeZone=Europe/Berlin
    ...    expected_status=200

    ${apiTime}=    Get Substring    ${response.json()}[dateTime]    0    23
    ${apiTime}=    Replace String    ${apiTime}    T    ${SPACE}
    RETURN    ${apiTime}
