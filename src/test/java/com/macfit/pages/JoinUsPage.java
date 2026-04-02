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
    public final By packageBox          = By.xpath("(//button[contains(normalize-space(),'CHOOSE PLAN') or contains(normalize-space(),'Choose Plan') or contains(normalize-space(),'choose plan') or contains(@class,'plan')])[1]");
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
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.elementToBeClickable(continueButton));
            jsClick(driver.findElement(continueButton));
        } catch (Exception ignored) {}
    }

    public void sehirSec(String sehir) {
        // SEE MEMBERSHIP PLANS butonuna bas (varsa, kısa süre bekle)
        By seeMembershipBtn = By.cssSelector("app-join-us-phone form button");
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(seeMembershipBtn));
            jsClick(driver.findElement(seeMembershipBtn));
        } catch (Exception ignored) {}

        // KABUL ET / AGREE modal varsa bekle ve bas (birden fazla olası locator dene)
        By agreeBtn = By.xpath(
            "//button[normalize-space()='KABUL ET'] | " +
            "//ngb-modal-window//app-modal//div[last()]/button | " +
            "//ngb-modal-window//button[last()]");
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(8))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.elementToBeClickable(agreeBtn));
            jsClick(driver.findElement(agreeBtn));
        } catch (Exception ignored) {}

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
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(120))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}

        new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(60))
                .until(d -> {
                    Object result = getJSObject().executeScript(
                            "var els = document.querySelectorAll('button, div, a');" +
                                    "var debug = 'cnt=' + els.length;" +
                                    "for (var i = 0; i < els.length; i++) {" +
                                    "  var tc = (els[i].textContent || '').replace(/\\s+/g,' ').trim();" +
                                    "  var it = (els[i].innerText   || '').replace(/\\s+/g,' ').trim();" +
                                    "  if (tc.toUpperCase() === 'CHOOSE PLAN' || it.toUpperCase() === 'CHOOSE PLAN') {" +
                                    "    els[i].scrollIntoView();" +
                                    "    els[i].click();" +
                                    "    return 'CLICKED:' + i + ':' + tc;" +
                                    "  }" +
                                    "}" +
                                    "return debug;");
                    return String.valueOf(result).startsWith("CLICKED");
                });
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