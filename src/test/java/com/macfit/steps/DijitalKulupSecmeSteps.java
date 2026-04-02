package com.macfit.steps;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

public class DijitalKulupSecmeSteps extends CommonMethods {
    public static void main(String[] args) {
        setUp();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));

        driver.navigate().to("https://portaldev-client.marsathletic.com/tr/dijital-uyelik-formu");

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("phone"))).sendKeys("5992554772");

        wait.until(ExpectedConditions.elementToBeClickable(By.id("city"))).click();
        wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//div[@role='option' and normalize-space()='Bursa']"))).click();

        wait.until(ExpectedConditions.elementToBeClickable(By.id("club"))).click();
        wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//div[@role='option'][contains(.,'42 Maslak')]"))).click();
    }
}