@Regression
Feature: TEK Insurance Regression Suit
  Background:
    Given url appUrl
    * def tokenGenerator = callonce read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue
    * def generator = Java.type('insurance.api.tek.utility.DataGenerator')

    @US_1
    #Post an Account
  Scenario: Post an account - Primary Person

    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def title = generator.getTitle()
    * def employmentStatus = generator.getEmploymentStatus()
    * def dateOfBirth = generator.getDOB()
    * def maritalStatus = generator.getMaritalStatus()
    * def gender = generator.getGender()
    * path '/api/accounts/add-primary-account'
    * request
    """
    {
      "id": 0,
      "email": "#(email)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "title": "#(title)",
      "gender": "#(gender)",
      "maritalStatus": "#(maritalStatus)",
      "employmentStatus": "#(employmentStatus)",
      "dateOfBirth": "#(dateOfBirth)",
      "new": true
    }
    """
    * method post
    * status 201
    * match response.email == email
    * print response
    * karate.write(response, 'RegressionCreatedAccount.json')

    @PostCar
    Scenario: Post a car - Primary Person Account
      * path '/api/accounts/add-account-car'
      * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
      * param primaryPersonId = primaryPersonIdValue.id
      * def make = generator.getMake()
      * def model = generator.getModel()
      * def year = generator.getYear();
      * def licensePlate = generator.getLicensePlate();
      * request
      """
      {
          "make": "#(make)",
          "model": "#(model)",
          "year": "#(year)",
          "licensePlate": "#(licensePlate)"
      }
      """
      * method post
      * status 201
      * print response
      * def carId = response.id
      * karate.write(response, 'RegressionPostCar.json')

      Scenario: PUT (Update) a car - Primary Person Account
        * path '/api/accounts/update-account-car'
        * def extractCarId = read('file:./target/RegressionPostCar.json')
        * def carIdValue = extractCarId.id
        * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
        * param primaryPersonId = primaryPersonIdValue.id
        * def make = generator.getMake()
        * def model = generator.getModel()
        * def year = generator.getYear();
        * def licensePlate = generator.getLicensePlate();
        * request
      """
      {
            "id": #(carIdValue),
            "make": "#(make)",
            "model": "#(model)",
            "year": "#(year)",
            "licensePlate": "#(licensePlate)"
          }
      """
        * method put
        * status 202
        * print response
        
        Scenario: Delete a car - Primary Person Account
          * path '/api/accounts/delete-car'
          * def extractCarId = read('file:./target/RegressionPostCar.json')
          * def carIdValue = extractCarId.id
          * param carId = carIdValue
          * method delete
          * status 202
          * print response
          * match response.message contains 'had been deleted'


  Scenario: Post - Add an address to Primary Person Account
    * path 'api/accounts/add-account-address'
    * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
    * param primaryPersonId = primaryPersonIdValue.id
    * def addressType = generator.getAddressType()
    * def addressLine = generator.getAddressLine()
    * def city = generator.getCity()
    * def state = generator.getState()
    * def postalCode = generator.getPostalCode()
    * def countryCode = generator.getCountryCode()
    * request
          """
          {
              "addressType": "#(addressType)",
              "addressLine1": "#(addressLine)",
              "city": "#(city)",
              "state": "#(state)",
              "postalCode": "#(postalCode)",
              "countryCode": "#(countryCode)",
              "current": true
            }
          """
    * method post
    * print response
    * def addressId = response.id
    * karate.write(response, 'RegressionPostAddress.json')

    Scenario: PUT (Update) address - Primary Person Account
      * path '/api/accounts/update-account-address'
      * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
      * param primaryPersonId = primaryPersonIdValue.id
      * def extractedAddressId = read('file:./target/RegressionPostAddress.json')
      * def addressIdValue = extractedAddressId.id
      * def addressType = generator.getAddressType()
      * def addressLine = generator.getAddressLine()
      * def city = generator.getCity()
      * def state = generator.getState()
      * def postalCode = generator.getPostalCode()
      * def countryCode = generator.getCountryCode()
      * request
      """
       {
              "id": #(addressIdValue),
              "addressType": "#(addressType)",
              "addressLine1": "#(addressLine)",
              "city": "#(city)",
              "state": "#(state)",
              "postalCode": "#(postalCode)",
              "countryCode": "#(countryCode)",
              "current": true
            }
      """
      * method put
      * status 202
      * print response
      * match addressIdValue == response.id

      Scenario: DELETE address - Primary Person Account
        * path 'api/accounts/delete-address'
        * def extractedAddressId = read('file:./target/RegressionPostAddress.json')
        * param addressId = extractedAddressId.id
        * method delete
        * status 202
        * print response
        * match response.message contains 'had been deleted'

        Scenario: DELETE Primary Person Account
          * path '/api/accounts/delete-account'
          * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
          * param primaryPersonId = primaryPersonIdValue.id
          * method delete
          #Expected status code is 202 but actual code is 200 so there is a bug in this scenario
          * status 202
          * print response
          * match response.message contains 'Account Successfully deleted'




