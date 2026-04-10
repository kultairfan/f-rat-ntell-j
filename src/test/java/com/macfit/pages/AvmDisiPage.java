package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class AvmDisiPage extends CommonMethods {

    @FindBy(id = "event-form-name")
    public WebElement adInput;

    @FindBy(id = "event-form-surname")
    public WebElement soyadInput;

    @FindBy(xpath = "//label[contains(.,'Ülke Kodu')]/following::ng-select[1]")
    public WebElement ulkeKoduDropdown;

    @FindBy(xpath = "//input[contains(@placeholder,'5')]")
    public WebElement gsmNoInput;

    @FindBy(id = "event-form-gender-men")
    public WebElement erkekRadio;

    @FindBy(id = "email-field")
    public WebElement emailInput;

    @FindBy(xpath = "//label[contains(.,'Doğum Tarihi')]/following::input[1]")
    public WebElement dogumTarihiInput;

    @FindBy(xpath = "//label[contains(.,'Şehir')]/following::ng-select[1]")
    public WebElement sehirDropdown;

    @FindBy(xpath = "//label[contains(.,'Kulüp')]/following::ng-select[1]")
    public WebElement kulupDropdown;

    @FindBy(xpath = "(//input[@type='checkbox'])[1]")
    public WebElement elektronikIleti;

    @FindBy(xpath = "(//input[@type='checkbox'])[2]")
    public WebElement acikRiza;

    @FindBy(xpath = "//button[normalize-space()='Devam Et']")
    public WebElement devamEt;

    @FindBy(xpath = "(//div[@aria-haspopup='listbox'])[3]")
    public WebElement kulupAlan;

    @FindBy(id = "event-close-modal-btn")
    public WebElement otpKapatButon;

    private final By otpKutulari = By.cssSelector("input[autocomplete='one-time-code']");
    private final By dogrulaButon = By.id("event-btn-confirm-sms");

    public AvmDisiPage() {
        PageFactory.initElements(driver, this);
    }

    public void zoomOut() {
        getJSObject().executeScript("document.body.style.zoom='80%'");
    }

    public void cinsiyetSec() {
        jsClick(erkekRadio);
    }

    public void dropdownSec(WebElement dropdown, String text) {
        jsClick(dropdown);

        By option = By.xpath("//ng-dropdown-panel//*[contains(normalize-space(),'" + text + "')]");
        WebElement element = waitForVisibility(option);
        scrollToElement(element);
        jsClick(element);
    }

    public void kulupSec(String kulupAdi) {
        jsClick(kulupAlan);

        WebElement searchInput = driver.findElement(
                By.xpath("(//div[@aria-haspopup='listbox'])[3]//input")
        );
        searchInput.clear();
        searchInput.sendKeys(kulupAdi);

        By option = By.xpath(
                "//ng-dropdown-panel//div[contains(@class,'ng-option') and contains(normalize-space(),'" + kulupAdi + "')]"
        );
        WebElement element = waitForVisibility(option);
        scrollToElement(element);

        try {
            element.click();
        } catch (Exception e) {
            jsClick(element);
        }
    }
    @FindBy(id = "event-form-city")
    public WebElement sehirAlan;

    public void sehirSec(String sehirAdi) {
        jsClick(sehirAlan);

        WebElement searchInput = driver.findElement(
                By.xpath("//ng-select[@id='event-form-city']//input")
        );
        searchInput.clear();
        searchInput.sendKeys(sehirAdi);

        By option = By.xpath(
                "//ng-dropdown-panel//div[contains(@class,'ng-option') and contains(normalize-space(),'" + sehirAdi + "')]"
        );
        WebElement element = waitForVisibility(option);
        scrollToElement(element);

        try {
            element.click();
        } catch (Exception e) {
            jsClick(element);
        }
    }

    public void izinleriKabulEt() {
        if (!elektronikIleti.isSelected()) {
            jsClick(elektronikIleti);
        }
        if (!acikRiza.isSelected()) {
            jsClick(acikRiza);
        }
    }

    public void otpKodunuGir(String kod) {
        List<WebElement> kutular = driver.findElements(otpKutulari);

        for (int i = 0; i < Math.min(kod.length(), kutular.size()); i++) {
            kutular.get(i).click();
            kutular.get(i).clear();
            kutular.get(i).sendKeys(String.valueOf(kod.charAt(i)));
        }
    }

    public void otpDogrulaButonunaBas() {
        click(driver.findElement(dogrulaButon));
    }
    public void otpDogrulamaKapat() {
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(30))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.elementToBeClickable(otpKapatButon));
            jsClick(otpKapatButon);
        } catch (Exception ignored) {
            // OTP modal gelmedi veya kapandi
        }
    }

}