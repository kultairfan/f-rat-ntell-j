package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

public class DijitalUyelikPage extends CommonMethods {

    public final By phoneInput     = By.id("phone");
    public final By cityComboBox   = By.xpath("//ng-select[@id='city']//input[@role='combobox']");
    public final By clubComboBox   = By.xpath("//div[@class='ng-select-container']");
    public final By girisBtn       = By.xpath("//button[@class='mars-button']");
    public final By nameInput      = By.id("firstName");
    public final By surnameInput   = By.id("lastName");
    public final By emailInput     = By.id("email");
    public final By birthDateInput = By.id("birthdate");
    public final By groupCheckbox  = By.id("groupId-0");
    public final By groupCheckbox2 = By.id("groupId-1");
    public final By erkekRadio     = By.cssSelector("#genderMen");
    public final By formGonderBtn  = By.xpath("//button[@class='mars-button']");
    public final By kabulEtBtn     = By.xpath("//button[normalize-space()='KABUL ET']");
    public final By confirmBtn     = By.xpath("//button[@class='confirm-button']");

    public DijitalUyelikPage() {
        PageFactory.initElements(driver, this);
    }

    public void sehirSec(String sehir) {
        By option = By.xpath("//div[normalize-space()='" + sehir + "']");
        waitForClickability(driver.findElement(cityComboBox));
        driver.findElement(cityComboBox).click();
        scrollToElement(driver.findElement(option));
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
        waitForClickability(driver.findElement(girisBtn));
        driver.findElement(girisBtn).click();
    }

    public void devamet() {
        waitForClickability(driver.findElement(kabulEtBtn));
        driver.findElement(kabulEtBtn).click();
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

        WebElement cb1 = driver.findElement(groupCheckbox);
        if (!cb1.isSelected()) cb1.click();

        WebElement cb2 = driver.findElement(groupCheckbox2);
        if (!cb2.isSelected()) cb2.click();

        WebElement radio = driver.findElement(erkekRadio);
        if (!radio.isSelected()) radio.click();
    }

    public void butonatikla() {
        waitForClickability(driver.findElement(formGonderBtn));
        driver.findElement(formGonderBtn).click();
    }

    public void confirmButon() {
        waitForClickability(driver.findElement(confirmBtn));
        driver.findElement(confirmBtn).click();
        wait(2);
    }
}