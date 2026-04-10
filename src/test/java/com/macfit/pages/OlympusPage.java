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
    public final By girisButon        = By.id("add-btn");
    public final By adayUyeMenuBtn    = By.xpath("(//button[contains(@class,'link-btn') and contains(.,'Aday Üye')])[1]");
    public final By adayUyeEkleBtnLoc = By.xpath("//button[normalize-space()='Aday Üye Ekle']");
    public final By uyeAramaInput     = By.id("gsmNo");
    public final By uyeAramaBtn       = By.id("filter-phone-search-btn");
    public final By ucNoktaBtn        = By.cssSelector("i.mdi.mdi-dots-horizontal");
    public final By uzerineAlIkon     = By.xpath("//i[contains(@class,'ri-file-transfer-line')] | //*[normalize-space()='Üzerine Al']");
    public final By evetButon         = By.xpath("//button[text()='Evet']");
    public final By kaydetButon       = By.id("add-btn");

    // true → olympus.su, false → test.st5 (Hooks tarafından her senaryo öncesi set edilir)
    public static boolean useOlympusSu = false;

    public OlympusPage() {
        PageFactory.initElements(driver, this);
    }

    // ══════════════════════════════════════════════════════════════════
    // LOGIN
    // ══════════════════════════════════════════════════════════════════

    public void olympusLogin() {
        String username = useOlympusSu
                ? ConfigsReader.getProperty("olympusu.username")
                : ConfigsReader.getProperty("username");
        String password = useOlympusSu
                ? ConfigsReader.getProperty("olympusu.password")
                : ConfigsReader.getProperty("password");

        String currentUrl = driver.getCurrentUrl();

        // Speed: zaten dashboard'daysa tekrar login yapmadan devam et
//        if (currentUrl.contains("olympusdev-dashboard") && !currentUrl.contains("/auth/login"))
        if (currentUrl.contains("olympusstg-dashboard") && !currentUrl.contains("/auth/login")){
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                        .until(ExpectedConditions.elementToBeClickable(adayUyeMenuBtn));
                return;
            } catch (Exception ignored) {}
        }

        // Speed: zaten login sayfasindaysa tekrar navigate etme
        if (!currentUrl.contains("/auth/login")) {
            driver.get(ConfigsReader.getProperty("url"));
        }
        try {
            waitForVisibility(kullaniciAdiInput);
            driver.findElement(kullaniciAdiInput).clear();
            driver.findElement(kullaniciAdiInput).sendKeys(username);
            driver.findElement(sifreInput).clear();
            driver.findElement(sifreInput).sendKeys(password);
            driver.findElement(girisButon).click();
            // Login sonrası dashboard elementinin gelmesini bekle
            getWaitObject().until(ExpectedConditions.elementToBeClickable(adayUyeMenuBtn));
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
        try {
            getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
        } catch (Exception ignored) {}
        try {
            getJSObject().executeScript("document.body.style.zoom='60%'");
        } catch (Exception ignored) {}
    }

    public void adayUyeEkleBtn() {
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
        getWaitObject().until(ExpectedConditions.elementToBeClickable(adayUyeEkleBtnLoc));
        jsClick(driver.findElement(adayUyeEkleBtnLoc));
    }

    // ══════════════════════════════════════════════════════════════════
    // ÜYE ARAMA
    // ══════════════════════════════════════════════════════════════════

    public void uyeAramaIle(String gsmNo) {
        WebElement input = waitForVisibility(uyeAramaInput);
        input.clear();
        input.sendKeys(gsmNo);
        jsClick(driver.findElement(uyeAramaBtn));

        By firstRow = By.xpath("//table[contains(@class,'lead-table')]//tbody/tr[1]");
        new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(10))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(firstRow));
    }
    // ══════════════════════════════════════════════════════════════════
    // ÜZERINE AL
    // ══════════════════════════════════════════════════════════════════

    public void uzerineAl() {
        WebElement menuBtn = waitForVisibility(ucNoktaBtn);
        menuBtn.click();
        java.util.List<WebElement> uzerineAlList = driver.findElements(uzerineAlIkon);
        if (uzerineAlList.isEmpty()) {
            // Lead zaten bu kullanıcıya atanmış, üzerine al seçeneği yok — kapat ve devam et
            driver.findElement(ucNoktaBtn).click();
            return;
        }
        WebElement uzerineAl = waitForClickability(uzerineAlList.get(0));
        uzerineAl.click();
        WebElement evet = waitForVisibility(evetButon);
        evet.click();
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
    }

    // ══════════════════════════════════════════════════════════════════
    // GÖREV MENÜSÜ
    // ══════════════════════════════════════════════════════════════════

    public void gorevMenuAc(String gorevTipi) {
        By menuItemLoc = gorevMenuItemLoc(gorevTipi);

        // 3-nokta butonuna tıkla → menü iteminin görünmesini bekle → açılmadıysa tekrar tıkla (3 deneme)
        for (int attempt = 0; attempt < 3; attempt++) {
            try {
                WebElement btn = new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(10))
                        .until(ExpectedConditions.elementToBeClickable(ucNoktaBtn));
                scrollToElement(btn);
                btn.click();
            } catch (Exception e) {
                try {
                    WebElement btn = driver.findElement(ucNoktaBtn);
                    scrollToElement(btn);
                    getJSObject().executeScript("arguments[0].click();", btn);
                } catch (Exception ignored) {}
            }

            // Dropdown'ın açılıp açılmadığını 5s içinde kontrol et
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                        .until(ExpectedConditions.visibilityOfElementLocated(menuItemLoc));
                break; // Menü açıldı — döngüden çık
            } catch (Exception ignored) {
                if (attempt == 2) waitForVisibility(menuItemLoc); // Son deneme — timeout fırlatır
            }
        }

        jsClick(waitForVisibility(menuItemLoc));

        if (gorevTipi.equals("Telefon Aramasi Planla")) {
            By telefonLoc = By.xpath("//*[contains(normalize-space(),'Telefon Araması')]");
            jsClick(waitForVisibility(telefonLoc));
        }
    }

    private By gorevMenuItemLoc(String gorevTipi) {
        if (gorevTipi.equals("Telefon Aramasi Planla")) {
            return By.xpath("//*[normalize-space()='Arama Görevi Planla']");
        } else if (gorevTipi.trim().equals("Satis Gorusmesi") || gorevTipi.trim().equals("Satış Görüşmesi")) {
            return By.xpath("//*[normalize-space()='Satış Görüşmesi']");
        } else if (gorevTipi.trim().equals("Tur Olustur") || gorevTipi.trim().equals("Tur Oluştur")) {
            return By.xpath("//*[contains(normalize-space(),'Tur Olu')]");
        } else {
            return By.xpath("//*[normalize-space()='" + gorevTipi + "']");
        }
    }

    // ══════════════════════════════════════════════════════════════════
    // TABLO SÜTUN GETİRİCİLER
    // Sıra: ID(1) Ad(2) Soyad(3) Telefon(4) E-Posta(5) Kulüp(6)
    //       SatışTemsilcisi(7) OluşturmaTarihi(8) GüncellenmeTarihi(9)
    //       İletişimİzni(10) Kaynak(11) ODetaylar(12) Statü(13)
    // ══════════════════════════════════════════════════════════════════

    public String getIlkSatirKaynak() {
        return getSutunText(12, false);
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
        By rowLoc = By.xpath("//table[contains(@class,'lead-table')]//tbody/tr[1]/td[13]");
        waitForVisibility(rowLoc);
        WebElement td = driver.findElement(rowLoc);
        java.util.List<WebElement> divs = td.findElements(By.xpath("./div"));
        if (divs.isEmpty()) return "";
        return divs.get(0).getText().trim();
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

        return driver.findElement(tdLoc).getText().trim();
    }

    // ══════════════════════════════════════════════════════════════════
    // DB
    // ══════════════════════════════════════════════════════════════════

    public String getSmsKodu(String telefonWith90) {
        return db.smsCodeGetir(telefonWith90);
    }
    public void kulupKolonunuAc() {
        By ayarButonu    = By.cssSelector("app-lead thead tr th:last-child button");
        By kulupLabel    = By.cssSelector("label[for='lead-table6']");
        By kulupCheckbox = By.id("lead-table6");

        // Loader bitene kadar bekle (dev ortamında yavaş olabilir — 60s)
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(com.macfit.utils.Constants.LOADER_WAIT_TIME))
                .until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
        } catch (Exception ignored) {}

        // Tablo zaten 6+ sütun içeriyorsa (Kulüp kolonu açıksa) — ayar panelini açmaya gerek yok
        java.util.List<WebElement> mevcutSutunlar = driver.findElements(
            By.xpath("//table[contains(@class,'lead-table')]//thead/tr/th"));
        if (mevcutSutunlar.size() >= 6) {
            String col6Text = mevcutSutunlar.get(5).getText().trim();
            System.out.println("Column 6 header: '" + col6Text + "'");
            if (col6Text.contains("Kulüp") || col6Text.contains("Kulup") || col6Text.contains("Club")) {
                System.out.println("Kulüp kolonu zaten görünür (" + mevcutSutunlar.size() + " sütun), ayar atlandı.");
                return;
            }
        }

        getWaitObject().until(ExpectedConditions.elementToBeClickable(ayarButonu));
        jsClick(driver.findElement(ayarButonu));

        waitForVisibility(kulupLabel);
        WebElement kulupElement = driver.findElement(kulupCheckbox);
        Boolean isChecked = (Boolean) getJSObject().executeScript("return arguments[0].checked", kulupElement);
        if (isChecked == null || !isChecked) {
            jsClick(driver.findElement(kulupLabel));
            System.out.println("Kulüp kolonu açıldı.");
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(com.macfit.utils.Constants.LOADER_WAIT_TIME))
                    .until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
            } catch (Exception ignored) {}
        } else {
            System.out.println("Kulüp kolonu zaten açık.");
        }

        jsClick(driver.findElement(ayarButonu));
    }


}