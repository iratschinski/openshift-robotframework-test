*** Settings ***
Library     String
Library     Collections
Library     DateTime
Library     RequestsLibrary
Library     Process
Library     json


*** Variables ***
${urlJupyterAuto}       https://jupyter-auto-crt-redhat-262-dev.apps.sandbox.x8i5.p1.openshiftapps.com/


*** Keywords ***
Get Jupyter AutoApi Status
    ${response}=    GET
    ...    ${urlJupyterAuto}
    ...    expected_status=200

    RETURN    ${response.json()}[status]

Get Jupyter AutoApi Prediction
    [Arguments]    ${description}

    ${data}=    Create Dictionary    data=${description}
    ${json}=    json.Dumps    ${data}

    ${response}=    POST
    ...    ${urlJupyterAuto}prediction
    ...    json=${json}
    ...    expected_status=200

    RETURN    ${response.json()}[prediction]

Recognize Defect
    [Arguments]    ${type}    ${description}

    ${typeRecognized}=    Get Jupyter AutoApi Prediction    ${description}

    Should Be Equal    ${type}    ${typeRecognized}
