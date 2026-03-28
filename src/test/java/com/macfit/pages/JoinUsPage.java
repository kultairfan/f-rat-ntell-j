package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

public class JoinUsPage extends CommonMethods {

    public final By phoneInput          = By.id("phone");
    public final By submitButton        = By.cssSelector("button[type='submit']");
    public final By continueButton      = By.cssSelector(".button.primary-button.single-button");
    public final By cityComboBox        = By.cssSelector("ng-select[id='city'] input[role='combobox']");
    public final By countryComboBox     = By.cssSelector("ng-select[id='country'] input[role='combobox']");
    public final By clubComboBox        = By.cssSelector("div[class='ng-select-container'] input[role='combobox']");
    public final By packageBox          = By.cssSelector("div[class='mars-box'] div:nth-child(1) div:nth-child(1) div:nth-child(4)");
    public final By nameInput           = By.id("firstName");
    public final By surnameInput        = By.id("lastName");
    public final By emailInput          = By.id("email");
    public final By birthDateInput      = By.id("birthdate");
    public final By personelNumberInput = By.id("personalId");
    public final By groupCheckbox       = By.id("groupId-0");
    public final By erkekRadiobox       = By.cssSelector("#genderMen");
    public final By confirmButonLoc     = By.cssSelector(".mars-button");
    public final By otpInput            = By.cssSelector("input[id^='otp_0_']");

    public JoinUsPage() {
        PageFactory.initElements(driver, this);
    }

    public By getOtpLocator() {
        return otpInput;
    }

    public void devamEt() {
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
        // join-us: button[type='submit'], dijital/vucut: button.mars-button
        if (!driver.findElements(submitButton).isEmpty()) {
            waitForVisibility(submitButton);
            jsClick(driver.findElement(submitButton));
        } else {
            By marsBtn = By.cssSelector("button.mars-button");
            waitForVisibility(marsBtn);
            jsClick(driver.findElement(marsBtn));
        }
    }

    public void ilkDevamButonunaBas() {
        waitForClickability(driver.findElement(continueButton));
        driver.findElement(continueButton).click();
    }

    public void sehirSec(String sehir) {
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
        waitForVisibility(cityComboBox);
        driver.findElement(cityComboBox).click();
        By opt = By.xpath("//div[normalize-space()='" + sehir + "']");
        waitForVisibility(opt);
        jsClick(driver.findElement(opt));
    }

    public void kulupSec(String kulup) {
        By opt = By.xpath("//div[normalize-space()='" + kulup + "']");
        waitForClickability(driver.findElement(clubComboBox));
        driver.findElement(clubComboBox).click();
        scrollToElement(driver.findElement(opt));
        driver.findElement(opt).click();
    }

    public void paketSec() {
        waitForClickability(driver.findElement(packageBox));
        driver.findElement(packageBox).click();
    }

    public void ulkeSec(String ulke) {
        By opt = By.xpath("//ng-dropdown-panel//div[contains(@class,'ng-option') and normalize-space()='" + ulke + "']");
        getWaitObject().until(
                org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                        By.className("ols-loader")));
        WebElement input = driver.findElement(countryComboBox);
        try {
            input.click();
        } catch (Exception e) {
            jsClick(input);
        }
        input.sendKeys(ulke);
        wait(1);
        waitForVisibility(opt);
        driver.findElement(opt).click();
        driver.findElement(By.xpath("//button[@type='submit']")).click();
    }

    public void formDoldur(String ad, String soyad, String email,
                           String telefon, String dogumTarihi, String personelNo) {
        waitForVisibility(nameInput);
        // CommonMethods.sendText(WebElement, String) kullanılıyor
        sendText(driver.findElement(nameInput), ad);
        sendText(driver.findElement(surnameInput), soyad);
        sendText(driver.findElement(emailInput), email);
        sendText(driver.findElement(phoneInput), telefon);
        sendText(driver.findElement(birthDateInput), dogumTarihi);
        sendText(driver.findElement(personelNumberInput), personelNo);

        WebElement checkbox = driver.findElement(groupCheckbox);
        if (!checkbox.isSelected()) checkbox.click();

        WebElement radio = driver.findElement(erkekRadiobox);
        if (!radio.isSelected()) radio.click();
    }

    public void confirmbuton() {
        waitForClickability(driver.findElement(confirmButonLoc));
        driver.findElement(confirmButonLoc).click();
    }
}