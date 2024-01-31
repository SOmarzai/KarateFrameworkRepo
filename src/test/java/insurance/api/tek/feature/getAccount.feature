
Feature: TEK Insurance GET Account API

  Background:
    Given url appUrl
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue =  tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue


    @GenerateToken
    Scenario: Get Primary Person Account
      * path '/api/accounts/get-primary-account'
      * param primaryPersonId = 2850
      * method get
      * status 200
      * print response
      * match response.firstName == 'Sadiqullah'
      * match response.lastName == 'Omarzai'
      * match response.gender == 'MALE'
      * match response.email == 'Omarzai111@tekschool.us'
      * match response.title == 'Strudent'
      * match response.employmentStatus == 'Student'
      * match response.maritalStatus == 'MARRIED'
      * match response.email contains '@tekschool'

      Scenario: Get All Accounts
        * path '/api/accounts/get-all-accounts'
        * method get
        * status 200
        * print response[0]
        #* match response[0].firstName == 'Shokriyan'

        Scenario: Get Account Details
          * path '/api/accounts/get-account'
          * param primaryPersonId = 2850
          * method get
          * status 200
          * print response
          * def idValue = response.primaryPerson.id
          * match idValue == 2850
          * match response.primaryPersonPhones[0].id == 559



