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
    public final By uzerineAlIkon     = By.xpath("//i[contains(@class,'ri-file-transfer-line')] | //*[normalize-space()='Üzerine Al']");
    public final By evetButon         = By.xpath("//button[normalize-space()='Evet']");
    public final By kaydetButon       = By.xpath("//button[@id='add-btn']");

    public OlympusPage() {
        PageFactory.initElements(driver, this);
    }

    // ══════════════════════════════════════════════════════════════════
    // LOGIN
    // ══════════════════════════════════════════════════════════════════

    public void olympusLogin() {
        driver.get(ConfigsReader.getProperty("url"));
        try {
            waitForVisibility(kullaniciAdiInput);
            driver.findElement(kullaniciAdiInput).clear();
            driver.findElement(kullaniciAdiInput).sendKeys(ConfigsReader.getProperty("username"));
            driver.findElement(sifreInput).clear();
            driver.findElement(sifreInput).sendKeys(ConfigsReader.getProperty("password"));
            driver.findElement(girisButon).click();
            wait(2);
        } catch (Exception ignored) {
            // Zaten login durumunda — uygulama dashboard'a yonlendirdi
        }
    }

    // ══════════════════════════════════════════════════════════════════
    // ADAY ÜYE SAYFASI
    // ══════════════════════════════════════════════════════════════════

    public void adayUyeSayfasinaGit() {
        getWaitObject().until(ExpectedConditions.elementToBeClickable(adayUyeMenuBtn));
        jsClick(driver.findElement(adayUyeMenuBtn));
        getJSObject().executeScript("document.body.style.zoom='60%'");
    }

    public void adayUyeEkleBtn() {
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(
                By.className("ols-loader")));
        getWaitObject().until(ExpectedConditions.elementToBeClickable(adayUyeEkleBtnLoc));
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
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
    }

    // ══════════════════════════════════════════════════════════════════
    // ÜZERINE AL
    // ══════════════════════════════════════════════════════════════════

    public void uzerineAl() {
        waitForClickability(driver.findElement(ucNoktaBtn));
        driver.findElement(ucNoktaBtn).click();
        java.util.List<WebElement> uzerineAlList = driver.findElements(uzerineAlIkon);
        if (uzerineAlList.isEmpty()) {
            // Lead zaten bu kullanıcıya atanmış, üzerine al seçeneği yok — kapat ve devam et
            driver.findElement(ucNoktaBtn).click();
            return;
        }
        waitForClickability(uzerineAlList.get(0));
        uzerineAlList.get(0).click();
        waitForClickability(driver.findElement(evetButon));
        driver.findElement(evetButon).click();
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
    }

    // ══════════════════════════════════════════════════════════════════
    // GÖREV MENÜSÜ
    // ══════════════════════════════════════════════════════════════════

    public void gorevMenuAc(String gorevTipi) {
        waitForClickability(driver.findElement(ucNoktaBtn));
        driver.findElement(ucNoktaBtn).click();
        if (gorevTipi.equals("Telefon Aramasi Planla")) {
            By aramaGoreviLoc = By.xpath("//*[normalize-space()='Arama Görevi Planla']");
            waitForVisibility(aramaGoreviLoc);
            driver.findElement(aramaGoreviLoc).click();
            By telefonLoc = By.xpath("//*[contains(normalize-space(),'Telefon Araması')]");
            getWaitObject().until(ExpectedConditions.presenceOfElementLocated(telefonLoc));
            jsClick(driver.findElement(telefonLoc));
        } else if (gorevTipi.trim().equals("Satis Gorusmesi") || gorevTipi.trim().equals("Satış Görüşmesi")) {
            By gorevLoc = By.xpath("//*[normalize-space()='Satış Görüşmesi']");
            waitForClickability(driver.findElement(gorevLoc));
            driver.findElement(gorevLoc).click();
        } else {
            By gorevLoc = By.xpath("//*[normalize-space()='" + gorevTipi + "']");
            waitForClickability(driver.findElement(gorevLoc));
            driver.findElement(gorevLoc).click();
        }
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
        By loc = By.xpath("//table[contains(@class,'lead-table')]//tbody/tr[1]/td[13]/div");
        waitForVisibility(loc);
        return driver.findElement(loc).getText().trim();
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
        By ayarButonu    = By.xpath("//app-lead//thead/tr/th[last()]//button");
        By kulupLabel    = By.xpath("//label[@for='lead-table6']");
        By kulupCheckbox = By.id("lead-table6");

        // Tablo tamamen yüklenene kadar bekle
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
        getWaitObject().until(ExpectedConditions.presenceOfElementLocated(ayarButonu));
        jsClick(driver.findElement(ayarButonu));

        waitForVisibility(kulupLabel);
        WebElement kulupElement = driver.findElement(kulupCheckbox);

        // isSelected() Angular'da güvenilmez — JS ile kontrol et
        Boolean isChecked = (Boolean) getJSObject().executeScript("return arguments[0].checked", kulupElement);
        if (isChecked == null || !isChecked) {
            jsClick(driver.findElement(kulupLabel));
            System.out.println("Kulüp kolonu açıldı.");
        } else {
            System.out.println("Kulüp kolonu zaten açık.");
        }

        getWaitObject().until(ExpectedConditions.presenceOfElementLocated(ayarButonu));
        jsClick(driver.findElement(ayarButonu));
    }

}