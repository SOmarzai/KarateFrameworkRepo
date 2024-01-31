package insurance.api.tek.utility;

import net.datafaker.Faker;

import java.text.SimpleDateFormat;
import java.util.*;

public class DataGenerator {

   //public static Faker faker;
    public static String getEmail(){
        Faker faker = new Faker();
        return faker.name().firstName()+ "." + faker.name().lastName() + "@gmail.com";
       // return faker.name().firstName()+ "." + faker.name().lastName() + "@gmail.com";
    }
    public static String getFirstName(){
        Faker faker = new Faker();
       return faker.name().firstName();
   }
    public static String getLastName(){
        Faker faker = new Faker();
        return faker.name().lastName();
    }
    public static String getTitle(){
        Faker faker = new Faker();
        return faker.name().prefix().toUpperCase();
    }
    public static String getGender(){
        Faker faker = new Faker();
        return faker.dog().gender().toUpperCase();
    }
    public static String getEmploymentStatus(){
        Faker faker = new Faker();
        return faker.job().position();
    }
    public static String getMaritalStatus(){
        Faker faker = new Faker();
        ArrayList<String> maritalStatus = new ArrayList<>();
        maritalStatus.add("SINGLE");
        maritalStatus.add("MARRIED");
        maritalStatus.add("WIDOW");
        maritalStatus.add("DIVORCED");
        Collections.shuffle(maritalStatus);
        return maritalStatus.get(0);
    }
    public static String getDOB(){
        Faker faker = new Faker();
        Date date = faker.date().birthday();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(date);
    }
    public static String getPhoneNumber(){
        Faker faker = new Faker();
        return faker.phoneNumber().subscriberNumber(10);

    }
    public static String getPhoneExtension(){
        Faker faker = new Faker();
        return faker.phoneNumber().extension();
    }
    public static String getPhoneType(){
        ArrayList<String> phoneType = new ArrayList<>();
        phoneType.add("Home");
        phoneType.add("Cell Phone");
        phoneType.add("Business");
        Collections.shuffle(phoneType);
        return phoneType.get(0);

    }
    public static String getPhoneTime(){
        ArrayList<String> phoneTime = new ArrayList<>();
        phoneTime.add("Morning");
        phoneTime.add("Evening");
        phoneTime.add("Day Time");
        Collections.shuffle(phoneTime);
        return phoneTime.get(0);

    }
    public static String getMake(){
        Faker faker = new Faker();
        return faker.vehicle().make();
    }
    public static String getModel(){
        Faker faker = new Faker();
        return faker.vehicle().model();
    }
    public static String getYear(){
        ArrayList<String> year = new ArrayList<>();
        year.add("2020");
        year.add("1995");
        year.add("2023");
        year.add("2024");
        Collections.shuffle(year);
        return year.get(0);
    }
    public static String getLicensePlate(){
        Faker faker = new Faker();
        return faker.vehicle().licensePlate();
    }

    public static String getAddressType(){
        Faker faker = new Faker();
        return faker.address().streetAddress();
    }
    public static String getAddressLine(){
        Faker faker = new Faker();
        return faker.address().buildingNumber();
    }
    public static String getCity(){
        Faker faker = new Faker();
        return faker.address().city();
    }
    public static String getState(){
        Faker faker = new Faker();
        return faker.address().state();
    }
    public static String getPostalCode(){
        Faker faker = new Faker();
        return faker.address().postcode();
    }
    public static String getCountryCode(){
        Faker faker = new Faker();
        return faker.address().countryCode();
    }



}
