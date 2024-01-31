
Feature: Create Primary Account in TEK Insurance Application
  Background:
    Given url appUrl
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def getTokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + getTokenValue
    * def generator = Java.type('insurance.api.tek.utility.DataGenerator')

  Scenario: Post Account Primary Person
    * path '/api/accounts/add-primary-account'
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def title = generator.getTitle()
    * def gender = generator.getGender()
    * def maritalStatus = generator.getMaritalStatus()
    * def employmentStatus = generator.getEmploymentStatus()
    * def dateOfBirth = generator.getDOB()
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
    * print response
    * karate.write(response, 'createdAccount.json')
    * match response.email == email
    * match response.firstName == firstName
    * match response.lastName == lastName

   @PostPhone
    Scenario: Add phone number to primary person
      * path 'api/accounts/add-account-phone'
      * def primaryPersonIdValue = read('file:./target/createdAccount.json')
      * param primaryPersonId = primaryPersonIdValue.id
      * def phoneNumber = generator.getPhoneNumber()
      * def phoneExtension = generator.getPhoneExtension()
      * def phoneType = generator.getPhoneType()
      * def phoneTime = generator.getPhoneTime()

      * request
      """
      {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "#(phoneExtension)",
        "phoneTime": "#(phoneTime)",
        "phoneType": "#(phoneType)"
      }
      """
      * method post
      * print response
      * match response.phoneNumber == phoneNumber
      * def phoneId = response.id
      * print phoneId

      Scenario: Add a car to primary person
        * path 'api/accounts/add-account-car'
        * def primaryPersonIdValue = read('file:./target/createdAccount.json')
        * param primaryPersonId = primaryPersonIdValue.id
        * def make = generator.getMake()
        * def model = generator.getModel()
        * def year = generator.getYear()
        * def plateNumber = generator.getPlateNumber()
        * request
        """
        {
          "make": "#(make)",
          "model": "#(model)",
          "year": "#(year)",
          "licensePlate": "#(plateNumber)"
        }
        """
        * method post
        * print response

        Scenario: Add an address to primary person
          * path 'api/accounts/add-account-address'
          * def primaryPersonIdValue = read('file:./target/createdAccount.json')
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
