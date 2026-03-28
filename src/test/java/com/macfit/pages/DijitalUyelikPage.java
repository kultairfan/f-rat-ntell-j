package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class DijitalUyelikPage extends CommonMethods {

    public final By phoneInput = By.id("phone");
    public final By cityComboBox = By.xpath("//ng-select[@id='city']//input[@role='combobox']");
    public final By clubComboBox = By.xpath("//div[@class='ng-select-container']");
    public final By girisBtn = By.xpath("//button[@class='mars-button']");
    public final By nameInput = By.id("firstName");
    public final By surnameInput = By.id("lastName");
    public final By emailInput = By.id("email");
    public final By birthDateInput = By.id("birthdate");
    public final By groupCheckbox = By.id("groupId-0");
    public final By groupCheckbox2 = By.id("groupId-1");
    public final By erkekRadio = By.cssSelector("#genderMen");
    public final By formGonderBtn = By.xpath("//button[@class='mars-button']");
    public final By kabulEtBtn = By.xpath("//button[normalize-space()='KABUL ET']");
    public final By confirmBtn = By.xpath("//app-digital-member-otp/div/form/div[3]/button | //app-join-us-otp/div/form/div[3]/button");
    public final By portalOtpCloseBtn = By.xpath("//button[contains(@class,'btn-close')]");

    public DijitalUyelikPage() {
        PageFactory.initElements(driver, this);
    }


    public void sehirSec(String sehir) {
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")
                    )
            );
        } catch (Exception e) {
            // loader yoksa devam et
        }

        WebElement input = driver.findElement(By.xpath("//ng-select[@id='city']//input[@role='combobox']"));

        try {
            input.click();
        } catch (Exception e) {
            getJSObject().executeScript("arguments[0].click();", input);
        }

        input.sendKeys(sehir);
        wait(1);

        By option = By.xpath("//div[@role='option' and contains(text(),'" + sehir + "')]");
        waitForClickability(driver.findElement(option));
        driver.findElement(option).click();
    }

    public void kulupSec(String kulup) {
        By option = By.xpath("//div[normalize-space()='" + kulup + "']");
        waitForClickability(driver.findElement(clubComboBox));
        driver.findElement(clubComboBox).click();
        scrollToElement(driver.findElement(option));
        driver.findElement(option).click();
    }

    public void girisButton() {
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
        waitForVisibility(girisBtn);
        jsClick(driver.findElement(girisBtn));
    }

    public void devamet() {
        try {
            waitForClickability(driver.findElement(kabulEtBtn));
            driver.findElement(kabulEtBtn).click();
        } catch (Exception ignored) {
            // KABUL ET butonu her zaman çıkmayabilir
        }
    }

    public void formDoldur(String ad, String soyad, String email,
                           String telefon, String dogumTarihi) {
        waitForVisibility(nameInput);
        // CommonMethods.sendText(WebElement, String) kullanılıyor
        sendText(driver.findElement(nameInput), ad);
        sendText(driver.findElement(surnameInput), soyad);
        sendText(driver.findElement(emailInput), email);
        sendText(driver.findElement(phoneInput), telefon);
        sendText(driver.findElement(birthDateInput), dogumTarihi);

        getWaitObject().until(
                org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                        By.className("ols-loader")));

        WebElement cb1 = driver.findElement(groupCheckbox);
        if (!cb1.isSelected()) jsClick(cb1);

        WebElement cb2 = driver.findElement(groupCheckbox2);
        if (!cb2.isSelected()) jsClick(cb2);

        WebElement radio = driver.findElement(erkekRadio);
        if (!radio.isSelected()) jsClick(radio);
    }

    public void butonatikla() {
        WebElement btn = driver.findElement(formGonderBtn);
        scrollToElement(btn);
        getJSObject().executeScript("arguments[0].click()", btn);
    }

    public void confirmButon() {
        waitForVisibility(confirmBtn);
        jsClick(driver.findElement(confirmBtn));
        wait(2);
    }
    public void portalOtpPopupKapat() {
        try {
            wait(2);
            List<WebElement> closeList = driver.findElements(portalOtpCloseBtn);
            if (!closeList.isEmpty()) {

                click(closeList.get(0));
                wait(1);
            }
        } catch (Exception ignored) {
        }
    }
}