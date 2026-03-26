package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import com.macfit.utils.ConfigsReader;
import com.macfit.utils.DatabaseHelper;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;

public class OlympusPage extends CommonMethods {

    private final DatabaseHelper db = new DatabaseHelper();

    public final By kullaniciAdiInput = By.id("userName");
    public final By sifreInput        = By.id("password");
    public final By girisButon        = By.xpath("//button[@id='add-btn']");
    public final By adayUyeMenuBtn = By.xpath("(//div[@class='section'][.//*[contains(text(),'Aday Üye İşlemleri')]]//button[contains(.,'Aday Üye')])[1]");
    public final By adayUyeEkleBtn = By.xpath("//button[@class='btn btn-success add-btn']");
    public final By uyeAramaInput     = By.id("gsmNo");
    public final By uyeAramaBtn       = By.xpath("//button[@id='filter-phone-search-btn']");
    public final By ucNoktaBtn        = By.xpath("//i[@class='mdi mdi-dots-horizontal']");
    public final By uzerineAlIkon     = By.xpath("//i[@class='ri-file-transfer-line text-primary label-icon align-middle fs-20 me-2']");
    public final By evetButon         = By.xpath("//button[normalize-space()='Evet']");
    public final By kaydetButon       = By.xpath("//button[@id='add-btn']");

    public OlympusPage() {
        PageFactory.initElements(driver, this);
    }

    public void olympusLogin() {
        waitForVisibility(kullaniciAdiInput);
        driver.findElement(kullaniciAdiInput).clear();
        driver.findElement(kullaniciAdiInput).sendKeys(ConfigsReader.getProperty("username"));
        driver.findElement(sifreInput).clear();
        driver.findElement(sifreInput).sendKeys(ConfigsReader.getProperty("password"));
        driver.findElement(girisButon).click();
        wait(2);
    }

    public void adayUyeSayfasinaGit() {
        waitForClickability(driver.findElement(adayUyeMenuBtn));
        driver.findElement(adayUyeMenuBtn).click();
        getJSObject().executeScript("document.body.style.zoom='60%'");
        wait(2);
    }


    public void uyeAramaIle(String gsmNo) {
        waitForVisibility(uyeAramaInput);
        driver.findElement(uyeAramaInput).clear();
        driver.findElement(uyeAramaInput).sendKeys(gsmNo);
        driver.findElement(uyeAramaBtn).click();
        wait(2);
    }

    public void uzerineAl() {
        waitForClickability(driver.findElement(ucNoktaBtn));
        driver.findElement(ucNoktaBtn).click();
        wait(1);
        waitForClickability(driver.findElement(uzerineAlIkon));
        driver.findElement(uzerineAlIkon).click();
        wait(1);
        waitForClickability(driver.findElement(evetButon));
        driver.findElement(evetButon).click();
        wait(2);
    }

    public void gorevMenuAc(String gorevTipi) {
        waitForClickability(driver.findElement(ucNoktaBtn));
        driver.findElement(ucNoktaBtn).click();
        wait(1);
        By gorevLoc = By.xpath("//*[normalize-space()='" + gorevTipi + "']");
        waitForClickability(driver.findElement(gorevLoc));
        driver.findElement(gorevLoc).click();
        wait(1);
    }

    public void gorevKaydet() {
        waitForClickability(driver.findElement(kaydetButon));
        driver.findElement(kaydetButon).click();
        wait(2);
    }

    public String getIlkSatirKaynak() {
        By kaynak = By.xpath("//tbody/tr[1]/td[contains(@class,'source') or contains(@class,'kaynak')]");
        waitForVisibility(kaynak);
        return driver.findElement(kaynak).getText().trim();
    }

    public String getSmsKodu(String telefonWith90) {
        return db.smsCodeGetir(telefonWith90);
    }

    public void adayUyeEkleBtn() {
        waitForClickability(driver.findElement(adayUyeEkleBtn));
        click(driver.findElement(adayUyeEkleBtn));
    }
}
