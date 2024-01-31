package insurance.api.tek.runner;

import com.intuit.karate.junit5.Karate;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

public class TestRunner {

    @Karate.Test
    Karate testTags() {

        return Karate.
                run("classpath:insurance/api/tek/feature").
                            tags("Regression").relativeTo(getClass());

    }
}
