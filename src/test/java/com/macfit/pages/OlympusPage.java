package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import com.macfit.utils.ConfigsReader;
import com.macfit.utils.DatabaseHelper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class OlympusPage extends CommonMethods {

    private final DatabaseHelper db = new DatabaseHelper();

    public final By kullaniciAdiInput = By.id("userName");
    public final By sifreInput        = By.id("password");
    public final By girisButon        = By.xpath("//button[@id='add-btn']");
    public final By adayUyeMenuBtn    = By.xpath("(//button[contains(@class,'link-btn') and contains(.,'Aday Üye')])[1]");
    public final By adayUyeEkleBtnLoc = By.xpath("//button[normalize-space()='Aday Üye Ekle']");
    public final By uyeAramaInput     = By.id("gsmNo");
    public final By uyeAramaBtn       = By.xpath("//button[@id='filter-phone-search-btn']");
    public final By ucNoktaBtn        = By.xpath("//i[@class='mdi mdi-dots-horizontal']");
    public final By uzerineAlIkon     = By.xpath("//i[@class='ri-file-transfer-line text-primary label-icon align-middle fs-20 me-2']");
    public final By evetButon         = By.xpath("//button[normalize-space()='Evet']");
    public final By kaydetButon       = By.xpath("//button[@id='add-btn']");

    public OlympusPage() {
        PageFactory.initElements(driver, this);
    }

    // ══════════════════════════════════════════════════════════════════
    // LOGIN
    // ══════════════════════════════════════════════════════════════════

    public void olympusLogin() {
        waitForVisibility(kullaniciAdiInput);
        driver.findElement(kullaniciAdiInput).clear();
        driver.findElement(kullaniciAdiInput).sendKeys(ConfigsReader.getProperty("username"));
        driver.findElement(sifreInput).clear();
        driver.findElement(sifreInput).sendKeys(ConfigsReader.getProperty("password"));
        driver.findElement(girisButon).click();
        wait(2);
    }

    // ══════════════════════════════════════════════════════════════════
    // ADAY ÜYE SAYFASI
    // ══════════════════════════════════════════════════════════════════

    public void adayUyeSayfasinaGit() {
        wait(2);
        WebElement btn = driver.findElement(adayUyeMenuBtn);
        getJSObject().executeScript("arguments[0].click()", btn);
        getJSObject().executeScript("document.body.style.zoom='60%'");
        wait(2);
    }

    public void adayUyeEkleBtn() {
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(
                By.className("ols-loader")));
        waitForClickability(driver.findElement(adayUyeEkleBtnLoc));
        jsClick(driver.findElement(adayUyeEkleBtnLoc));
        wait(1);
    }

    // ══════════════════════════════════════════════════════════════════
    // ÜYE ARAMA
    // ══════════════════════════════════════════════════════════════════

    public void uyeAramaIle(String gsmNo) {
        try {
            getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(
                    By.cssSelector("ngb-modal-window")));
        } catch (Exception ignored) { }

        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(
                By.className("ols-loader")));

        waitForVisibility(uyeAramaInput);
        driver.findElement(uyeAramaInput).clear();
        driver.findElement(uyeAramaInput).sendKeys(gsmNo);
        jsClick(driver.findElement(uyeAramaBtn));
        wait(2);
    }

    // ══════════════════════════════════════════════════════════════════
    // ÜZERINE AL
    // ══════════════════════════════════════════════════════════════════

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

    // ══════════════════════════════════════════════════════════════════
    // GÖREV MENÜSÜ
    // ══════════════════════════════════════════════════════════════════

    public void gorevMenuAc(String gorevTipi) {
        waitForClickability(driver.findElement(ucNoktaBtn));
        driver.findElement(ucNoktaBtn).click();
        wait(1);
        By gorevLoc = By.xpath("//*[normalize-space()='" + gorevTipi + "']");
        waitForClickability(driver.findElement(gorevLoc));
        driver.findElement(gorevLoc).click();
        wait(1);
    }

    // ══════════════════════════════════════════════════════════════════
    // TABLO SÜTUN GETİRİCİLER
    // Sıra: ID(1) Ad(2) Soyad(3) Telefon(4) E-Posta(5) Kulüp(6)
    //       SatışTemsilcisi(7) OluşturmaTarihi(8) GüncellenmeTarihi(9)
    //       İletişimİzni(10) Kaynak(11) ODetaylar(12) Statü(13)
    // ══════════════════════════════════════════════════════════════════

    public String getIlkSatirKaynak() {
        return getSutunText(11, false);
    }

    public String getIlkSatirAd() {
        // Ad span içinde geliyor
        return getSutunText(2, true);
    }

    public String getIlkSatirSoyad() {
        return getSutunText(3, true);
    }

    public String getIlkSatirKulup() {
        // Kulüp span içinde geliyor (td[6])
        return getSutunText(6, true);
    }

    public String getIlkSatirSatisTemsilcisi() {
        return getSutunText(7, false);
    }

    public String getIlkSatirTags() {
        // Tags span içinde geliyor (td[12])
        return getSutunText(12, true);
    }

    /**
     * @param sutunNo  1-based sütun numarası
     * @param spanIci  true ise önce span içini dene, false ise direkt td text
     */
    private String getSutunText(int sutunNo, boolean spanIci) {
        By tdLoc = By.xpath("//table[contains(@class,'lead-table')]//tbody/tr[1]/td[" + sutunNo + "]");
        waitForVisibility(tdLoc);

        WebElement td = driver.findElement(tdLoc);

        if (spanIci) {
            try {
                WebElement span = td.findElement(By.xpath(".//span"));
                String spanText = span.getText().trim();
                if (!spanText.isEmpty()) {
                    return spanText;
                }
            } catch (Exception ignored) {
            }
        }

        return td.getText().trim();
    }

    // ══════════════════════════════════════════════════════════════════
    // DB
    // ══════════════════════════════════════════════════════════════════

    public String getSmsKodu(String telefonWith90) {
        return db.smsCodeGetir(telefonWith90);
    }
    public void kulupKolonunuAc() {
        By ayarButonu = By.xpath("(//div[@class='btn-group dropdown'])[2]");
        By kulupCheckbox = By.id("lead-table6");

        waitForClickability(driver.findElement(ayarButonu));
        click(driver.findElement(ayarButonu));
        wait(1);

        WebElement kulupElement = driver.findElement(kulupCheckbox);

        // Eğer seçili değilse tıkla
        if (!kulupElement.isSelected()) {
            jsClick(kulupElement);
            System.out.println("Kulüp kolonu açıldı.");
        } else {
            System.out.println("Kulüp kolonu zaten açık.");
        }

        wait(1);
        click(driver.findElement(ayarButonu));
    }

}