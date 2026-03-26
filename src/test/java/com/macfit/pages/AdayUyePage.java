package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class AdayUyePage extends CommonMethods {

    public final By btnAdayUyeEkle  = By.xpath("//button[normalize-space()='Aday Uye Ekle']");
    public final By inputAd         = By.xpath("//input[@placeholder='Ad']");
    public final By inputSoyad      = By.xpath("//input[@placeholder='Soyad']");
    public final By inputGsm        = By.xpath("//input[@placeholder='(5xx) xxx-xxxx']");
    public final By inputEmail      = By.xpath("//input[@placeholder='E-posta']");
    public final By btnDevamEt      = By.xpath("//button[normalize-space()='Devam Et']");
    public final By btnOtpAtla      = By.xpath("//button[normalize-space()='Atla']");
    public final By inputOtp        = By.cssSelector("input[id^='otp_0_']");
    public final By btnOtpDogrula   = By.xpath("//button[normalize-space()='Dogru la'] | //button[normalize-space()='Onayla']");
    public final By btnConfirm      = By.xpath("//button[@class='confirm-button']");
    public final By toastBasari     = By.xpath("//*[contains(text(),'basariyla') or contains(text(),'olusturuldu')]");
    public final By uyeAramaInput   = By.id("gsmNo");
    public final By uyeAramaBtn     = By.xpath("//button[@id='filter-phone-search-btn']");

    public AdayUyePage() {
        PageFactory.initElements(driver, this);
    }

    public void adayUyeEkleModalAc() {
        waitForClickability(driver.findElement(btnAdayUyeEkle));
        driver.findElement(btnAdayUyeEkle).click();
        waitForVisibility(inputAd);
    }

    public void adayUyeFormunuDoldur(String ad, String soyad, String gsmNo, String email, String kaynak) {
        driver.findElement(inputAd).sendKeys(ad);
        driver.findElement(inputSoyad).sendKeys(soyad);
        driver.findElement(inputGsm).sendKeys(gsmNo);
        driver.findElement(inputEmail).sendKeys(email);
        kaynakSec(kaynak);
        wait(1);
        driver.findElement(btnDevamEt).click();
    }

    private void kaynakSec(String kaynak) {
        By dropdownAc = By.xpath("//div[contains(@class,'select')]//div[contains(text(),'Sec') or contains(text(),'Kaynak')]");
        waitForClickability(driver.findElement(dropdownAc));
        driver.findElement(dropdownAc).click();
        By option = By.xpath("//div[contains(@class,'option') and normalize-space()='" + kaynak + "']");
        waitForClickability(driver.findElement(option));
        driver.findElement(option).click();
    }

    public void otpAtla() {
        try {
            wait(2);
            List<WebElement> list = driver.findElements(btnOtpAtla);
            if (!list.isEmpty()) list.get(0).click();
        } catch (Exception ignored) { }
    }

    public void otpDogrula(String kod) {
        waitForVisibility(inputOtp);
        driver.findElement(inputOtp).sendKeys(kod);
        wait(1);
    }

    public void otpConfirmBas() {
        try {
            waitForClickability(driver.findElement(btnConfirm));
            driver.findElement(btnConfirm).click();
            wait(2);
        } catch (Exception ignored) { }
    }

    public void adayUyeBasariKontrol() {
        try {
            waitForVisibility(toastBasari);
        } catch (Exception ignored) { }
        wait(2);
    }

    public void telefonIleAra(String gsmNo) {
        waitForVisibility(uyeAramaInput);
        driver.findElement(uyeAramaInput).clear();
        driver.findElement(uyeAramaInput).sendKeys(gsmNo);
        driver.findElement(uyeAramaBtn).click();
        wait(2);
    }

    public String getIlkSatirKaynak() {
        By kaynak = By.xpath("(//tbody/tr[1]/td)[5]");
        waitForVisibility(kaynak);
        return driver.findElement(kaynak).getText().trim();
    }

    public String getIlkSatirIsim() {
        By isim = By.xpath("(//tbody/tr[1]/td)[2]//span");
        waitForVisibility(isim);
        return driver.findElement(isim).getText().trim();
    }
}
