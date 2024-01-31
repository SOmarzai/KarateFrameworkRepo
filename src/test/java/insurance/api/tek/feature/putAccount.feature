Feature: TEK Insurance PUT Account API

  Background:
    Given url appUrl
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue =  tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue

    Scenario: PUT API - Update Phone number Primary Person
      * path 'api/accounts/update-account-phone'
      * def primaryPersonIdValue = read('file:./target/createdAccount.json')
      * param primaryPersonId = primaryPersonIdValue.id
      * def phoneIdExtraction = call read('postAccount.feature@PostPhone')
      * def phoneIdValue = phoneIdExtraction.phoneId

      * request
      """

          {
              "id": #(phoneIdValue),
              "phoneNumber": "2813000000",
              "phoneExtension": "281",
              "phoneTime": "Morning",
              "phoneType": "Cell Phone"
          }

      """
      * method put
      * print response