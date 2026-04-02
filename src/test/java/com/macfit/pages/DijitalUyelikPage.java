package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import io.cucumber.java.en.And;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;

public class DijitalUyelikPage extends CommonMethods {

    public final By phoneInput = By.id("phone");
    public final By cityComboBox = By.xpath("//ng-select[@id='city']//input[@role='combobox']");
    //Degisti
    public final By clubComboBox = By.xpath("//ng-select[@id='club']//input[@role='combobox']");
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

        By option = By.xpath("//div[@role='option' and contains(text(),'" + sehir + "')]");
        waitForClickability(driver.findElement(option));
        driver.findElement(option).click();
    }

    public void kulupSec(String kulup) {
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {
        }

        WebElement input = waitForVisibility(clubComboBox);

        try {
            input.click();
        } catch (Exception e) {
            getJSObject().executeScript("arguments[0].click();", input);
        }

        input.clear();
        input.sendKeys(kulup);

        By option = By.xpath(
                "//ng-dropdown-panel//div[@role='option' and contains(normalize-space(),'" + kulup + "')]"
        );

        WebElement secenek = waitForVisibility(option);
        scrollToElement(secenek);

        try {
            secenek.click();
        } catch (Exception e) {
            jsClick(secenek);
        }
    }

    public void girisButton() {
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {
        }
        waitForVisibility(girisBtn);
        jsClick(driver.findElement(girisBtn));
    }

    public void devamet() {
        try {
            List<WebElement> list = driver.findElements(kabulEtBtn);
            if (!list.isEmpty()) {
                waitForClickability(list.get(0));
                list.get(0).click();
            }
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

    public void vucutFormDoldur(String ad, String soyad, String email,
                                String telefon, String dogumTarihi) {
        waitForVisibility(nameInput);
        sendText(driver.findElement(nameInput), ad);
        sendText(driver.findElement(surnameInput), soyad);
        sendText(driver.findElement(emailInput), email);
        sendText(driver.findElement(phoneInput), telefon);
        sendText(driver.findElement(birthDateInput), dogumTarihi);
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.className("ols-loader")));
        } catch (Exception ignored) {
        }
        List<WebElement> cb1List = driver.findElements(groupCheckbox);
        if (!cb1List.isEmpty() && !cb1List.get(0).isSelected()) jsClick(cb1List.get(0));
        List<WebElement> cb2List = driver.findElements(groupCheckbox2);
        if (!cb2List.isEmpty() && !cb2List.get(0).isSelected()) jsClick(cb2List.get(0));
        List<WebElement> radioList = driver.findElements(erkekRadio);
        if (!radioList.isEmpty() && !radioList.get(0).isSelected()) jsClick(radioList.get(0));
    }

    public void butonatikla() {
        WebElement btn = driver.findElement(formGonderBtn);
        scrollToElement(btn);
        getJSObject().executeScript("arguments[0].click()", btn);
    }

    public void confirmButon() {
        try {
            waitForVisibility(confirmBtn);
            jsClick(driver.findElement(confirmBtn));
            try {
                getWaitObject().until(
                        org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                                By.cssSelector(".ols-loader")));
            } catch (Exception ignored) {
            }
        } catch (Exception ignored) {
            // OTP confirm butonu yok (OTP gosterilmedi), devam et
        }
    }

    public void portalOtpPopupKapat() {
        // Önce "Atla" butonunu dene (OTP skip), sonra btn-close (X) dene
        By atlaBtn = By.xpath("//button[normalize-space()='Atla'] | //button[normalize-space()='ATLA'] | //a[normalize-space()='Atla']");
        By closeBtn = portalOtpCloseBtn; // btn-close
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(15))
                    .until(d -> !d.findElements(atlaBtn).isEmpty() || !d.findElements(closeBtn).isEmpty());
            List<WebElement> atlaList = driver.findElements(atlaBtn);
            if (!atlaList.isEmpty()) {
                jsClick(atlaList.get(0));
                try {
                    new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                            .until(d -> d.findElements(atlaBtn).isEmpty());
                } catch (Exception ignored) {
                }
                return;
            }
            List<WebElement> closeList = driver.findElements(closeBtn);
            if (!closeList.isEmpty()) {
                jsClick(closeList.get(0));
                try {
                    getWaitObject().until(
                            org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(closeBtn));
                } catch (Exception ignored) {
                }
            }
        } catch (Exception ignored) {
        }
    }

    public void portalKulupIkinciKezDegistir() {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));

        By degistirBtn = By.xpath(
                "//button[normalize-space()='Değiştir'] | " +
                        "//button[normalize-space()='DEĞİŞTİR'] | " +
                        "//*[normalize-space()='Değiştir']"
        );

        wait.until(ExpectedConditions.elementToBeClickable(degistirBtn));
        driver.findElement(degistirBtn).click();

        try {
            new WebDriverWait(driver, Duration.ofSeconds(5))
                    .until(ExpectedConditions.invisibilityOfElementLocated(By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}

        By sehirInputBy = By.xpath("//ng-select[@id='city']//input[@role='combobox']");
        wait.until(ExpectedConditions.elementToBeClickable(sehirInputBy));

        WebElement sehirInput = driver.findElement(sehirInputBy);
        try {
            sehirInput.click();
        } catch (Exception e) {
            jsClick(sehirInput);
        }

        sehirInput.clear();
        sehirInput.sendKeys("İstanbul");

        By istanbulOption = By.xpath("//div[@role='option' and contains(normalize-space(),'İstanbul')]");
        wait.until(ExpectedConditions.elementToBeClickable(istanbulOption)).click();

        try {
            new WebDriverWait(driver, Duration.ofSeconds(5))
                    .until(ExpectedConditions.invisibilityOfElementLocated(By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}

        kulupSec("MACFit 42 Maslak");

        try {
            new WebDriverWait(driver, Duration.ofSeconds(10))
                    .until(ExpectedConditions.invisibilityOfElementLocated(By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
    }

}
