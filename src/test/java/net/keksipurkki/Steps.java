package net.keksipurkki;

import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.concurrent.ThreadLocalRandom;

final public class Steps {
    private int integer = 0;
    private float result;

    @Before
    public static void beforeAll() throws IOException {
        System.out.println("Creating the artifacts folder");

        var path = Path.of(System.getProperty("user.dir"), "target", "artifacts");

        if (!Files.exists(path)) {
            Files.createDirectory(path);
        }
    }

    @Given("an integer")
    public void an_integer() {
        integer = ThreadLocalRandom.current().nextInt();
    }

    @When("multiplied by one")
    public void multipliedByOne() {
        result = integer * 1;
    }

    @When("divided by zero")
    public void dividedByZero() {
        System.err.println("Helpful diagnostics information");
        result = integer / 0;
    }

    @Then("expected result")
    public void expectedResult() {
        Assertions.assertEquals(integer, result);
    }

    @Then("result is not a number")
    public void resultIsNotANumber() {
        Assertions.assertEquals(Float.NaN, result);
    }
}
