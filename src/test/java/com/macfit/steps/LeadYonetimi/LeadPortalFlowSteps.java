package com.macfit.steps.LeadYonetimi;

import com.macfit.pages.*;
import com.macfit.utils.CommonMethods;
import com.macfit.utils.SoftAssertionCollector;
import com.macfit.utils.TestData;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.WindowType;

import java.util.ArrayList;
import java.util.List;

public class LeadPortalFlowSteps extends CommonMethods {

    private OlympusPage olympusPage;
    private JoinUsPage joinUsPage;
    private DijitalUyelikPage dijitalUyelikPage;
    private AdayUyePage adayUyePage;
    private GorevAtamaPage gorevAtamaPage;

    static String randomGsmNo;
    private String aktifGorevTipi;

    public static void resetGsmNo() {
        randomGsmNo = null;
    }

    private static final String PORTAL_BASE = "https://portaldev-client.marsathletic.com";

    // ══════════════════════════════════════════════════════════════════
    // LOGIN
    // ══════════════════════════════════════════════════════════════════

    @Given("Olympus dashboard acilir ve giris yapilir")
    public void olympusDashboardAcilirVeGirisYapilir() {
        if (randomGsmNo == null) {
            randomGsmNo = TestData.generatePhone();
        }
        olympusPage       = new OlympusPage();
        joinUsPage        = new JoinUsPage();
        dijitalUyelikPage = new DijitalUyelikPage();
        adayUyePage       = new AdayUyePage();
        gorevAtamaPage    = new GorevAtamaPage();
        olympusPage.olympusLogin();
    }
    @Given("Olympus dashboard kontrole hazirlanir")
    public void olympusDashboardKontroleHazirlanir() {
        olympusPage      = new OlympusPage();
        adayUyePage      = new AdayUyePage();
        gorevAtamaPage   = new GorevAtamaPage();
        olympusPage.olympusLogin();
    }

    @When("Aday uye listesine gidilir")
    public void adayUyeListesineGidilir() {
        olympusPage.adayUyeSayfasinaGit();
    }

    @Then("Olympus dashboard navigate edilir")
    public void olympusDashboardNavigateedilir()
    {
        driver.navigate().to("https://olympusdev-dashboard.marsathletic.com/member/lead");

    }

    // ══════════════════════════════════════════════════════════════════
    // ADAY ÜYE
    // ══════════════════════════════════════════════════════════════════

    @When("Aday uye sayfasina gidilir")
    public void adayUyeSayfasinaGidilir() {
        olympusPage.adayUyeSayfasinaGit();
        olympusPage.adayUyeEkleBtn();
    }
    @When("Aday uye dashboarda gidilir")
    public void adayUyeDashboardaGidilir()
    {
        olympusPage.adayUyeSayfasinaGit();
    }

    @And("Aday uye ekle formuna bilgiler girilir ad {string} soyad {string} gsmNo {string} email {string} kaynak {string} dogumtarihi {string}")
    public void adayUyeEkleFormunaBilgilerGirilir(String ad, String soyad, String gsmNo,
                                                  String email, String kaynak, String dogumTarihi) {
        adayUyePage.adayUyeFormunuDoldur(ad, soyad, randomGsmNo, email, kaynak, dogumTarihi);
    }

    @And("OTP dogrulamasi atlanir")
    public void otpDogrulamasiAtlanir() {
        adayUyePage.otpAtla();
        adayUyePage.adayUyePopupKapat();

    }

    @And("SMS kodu DBden cekilip OTP girilir {string}")
    public void smsKoduDbdenCekilipOtpGirilir(String gsmNo) {
        String kod = null;
        for (int i = 0; i < 10 && kod == null; i++) {
            kod = olympusPage.getSmsKodu("90" + randomGsmNo);
            if (kod == null) wait(1);
        }
        Assert.assertNotNull("SMS kodu alinamadi!", kod);
        adayUyePage.otpDogrula(kod);
    }

    @And("OTP confirm butonuna basilir")
    public void otpConfirmButonunaBasilir() {
        adayUyePage.otpConfirmBas();
    }

    @Then("Aday uye basariyla olusturulur")
    public void adayUyeBasariyleOlusturulur() {
        adayUyePage.adayUyeBasariKontrol();
        System.out.println("Aday uye basariyla olusturulur - GSM: " + randomGsmNo);
    }

    // ══════════════════════════════════════════════════════════════════
    // PORTAL
    // ══════════════════════════════════════════════════════════════════

    @When("{string} portali acilir")
    public void portaliAcilir(String portalUrlKey) {
        dijitalUyelikPage = new DijitalUyelikPage();
        joinUsPage = new JoinUsPage();
        driver.switchTo().newWindow(WindowType.TAB);
        driver.get(resolvePortalUrl(portalUrlKey));
        try { driver.manage().window().maximize(); } catch (Exception ignored) {}
        waitForVisibility(By.id("phone"));
        getJSObject().executeScript("document.body.style.zoom='60%'");
    }

    @When("{string} portali acilir ve devam edilir")
    public void portaliAcilirvedevamedilir(String portalUrlKey) {
        randomGsmNo       = TestData.generatePhone();
        olympusPage       = new OlympusPage();
        joinUsPage        = new JoinUsPage();
        dijitalUyelikPage = new DijitalUyelikPage();
        adayUyePage       = new AdayUyePage();
        gorevAtamaPage    = new GorevAtamaPage();
        driver.get(resolvePortalUrl(portalUrlKey));
        try { driver.manage().window().maximize(); } catch (Exception ignored) {}
        waitForVisibility(By.id("phone"));
        getJSObject().executeScript("document.body.style.zoom='60%'");
    }
    @And("Portala telefon numarasi girilir {string}")
    public void portalaTelefonNumarasiGirilir(String gsmNo) {
        waitForVisibility(By.id("phone"));
        driver.findElement(By.id("phone")).sendKeys(randomGsmNo);
    }

    @And("Portal sehir {string} secilir")
    public void portalSehirSecilir(String sehir) {
        if (driver.getCurrentUrl().contains("join-us")) {
            joinUsPage.sehirSec(sehir);
        } else {
            dijitalUyelikPage.sehirSec(sehir);
        }
    }

    @And("Portal kulup {string} secilir")
    public void portalKulupSecilir(String kulup) {
        if (driver.getCurrentUrl().contains("join-us")) {
            joinUsPage.kulupSec(kulup);
        } else {
            dijitalUyelikPage.kulupSec(kulup);
        }
    }

    @And("Portal form bilgileri girilir ad {string} soyad {string} email {string} dogumtarihi {string}")
    public void portalFormBilgileriGirilir(String ad, String soyad, String email, String dogumTarihi) {
        // Önce KABUL ET varsa kapat (devam butonu sonrası veya OTP confirm sonrası gelebilir)
        dijitalUyelikPage.devamet();

        // firstName 3 saniye içinde görünürse (OTP confirm / devam butonu sonrası form açılmış)
        // girisButton'a gerek yok — doğrudan form doldurma aşamasına geç
        boolean firstNameAlreadyVisible = false;
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(3))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(
                    By.id("firstName")));
            firstNameAlreadyVisible = true;
        } catch (Exception ignored) {}

        if (!firstNameAlreadyVisible) {
            dijitalUyelikPage.girisButton();
            // girisButton sonrası modal veya firstName görünene kadar bekle (max 5s)
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.or(
                        org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.id("firstName")),
                        org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.cssSelector("ngb-modal-window"))
                    ));
            } catch (Exception ignored) {}
            dijitalUyelikPage.devamet();           // KABUL ET varsa kapat
            // OTP popup veya firstName görünene kadar kısa bekle
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(3))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.or(
                        org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.id("firstName")),
                        org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.cssSelector("input[type='tel']"))
                    ));
            } catch (Exception ignored) {}
            dijitalUyelikPage.portalOtpPopupKapat(); // SMS onaylı lead varsa OTP popup → kapat
            // firstName hâlâ görünmüyorsa bir kez daha dene
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(
                        By.id("firstName")));
            } catch (Exception e) {
                dijitalUyelikPage.devamet();
                try {
                    new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(3))
                        .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(
                            By.cssSelector("ngb-modal-window")));
                } catch (Exception ignored) {}
                dijitalUyelikPage.portalOtpPopupKapat();
                List<org.openqa.selenium.WebElement> firstNameElems = driver.findElements(By.id("firstName"));
                if (firstNameElems.isEmpty() || !firstNameElems.get(0).isDisplayed()) {
                    List<org.openqa.selenium.WebElement> girisElems = driver.findElements(
                        By.xpath("//button[@class='mars-button']"));
                    if (!girisElems.isEmpty()) {
                        try { dijitalUyelikPage.girisButton(); } catch (Exception ignored) {}
                        try {
                            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(3))
                                .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(
                                    By.cssSelector("ngb-modal-window")));
                        } catch (Exception ignored) {}
                        dijitalUyelikPage.devamet();
                        dijitalUyelikPage.portalOtpPopupKapat();
                    }
                    // Atla yoksa zorunlu OTP → DB'den kodu al ve gir
                    By otpInputSel2 = By.cssSelector("input[id^='otp_0_'], input[maxlength='1'][type='tel'], input[maxlength='6'][type='tel']");
                    try {
                        boolean otpVis = !driver.findElements(otpInputSel2).isEmpty()
                            && driver.findElements(otpInputSel2).get(0).isDisplayed();
                        if (otpVis) {
                            String kod = null;
                            for (int i = 0; i < 15 && kod == null; i++) {
                                kod = olympusPage.getSmsKodu("90" + randomGsmNo);
                                if (kod == null) wait(1);
                            }
                            if (kod != null) {
                                List<org.openqa.selenium.WebElement> oi = driver.findElements(By.cssSelector("input[id^='otp_0_']"));
                                if (oi.isEmpty()) oi = driver.findElements(otpInputSel2);
                                if (oi.size() == 1) { oi.get(0).click(); oi.get(0).sendKeys(kod); }
                                else { for (int i = 0; i < kod.length() && i < oi.size(); i++) { oi.get(i).click(); oi.get(i).sendKeys(String.valueOf(kod.charAt(i))); } }
                                try { waitForVisibility(dijitalUyelikPage.confirmBtn); jsClick(driver.findElement(dijitalUyelikPage.confirmBtn)); } catch (Exception ignored) {}
                            }
                        }
                    } catch (Exception ignored) {}
                    waitForVisibility(By.id("firstName"));
                }
            }
        }
        getJSObject().executeScript("document.body.style.zoom='60%'");
        dijitalUyelikPage.formDoldur(ad, soyad, email, randomGsmNo, dogumTarihi);
    }

    @And("Vucut form bilgileri girilir ad {string} soyad {string} email {string} dogumtarihi {string}")
    public void vucutFormBilgileriGirilir(String ad, String soyad, String email, String dogumTarihi) {
        By vucutBtn = By.xpath("//button[contains(@class,'mars-button') or contains(normalize-space(.),'ÖLÇÜM') or contains(normalize-space(.),'Ölçüm')]");
        waitForVisibility(vucutBtn);
        jsClick(driver.findElement(vucutBtn));

        // KABUL ET modal varsa kapat
        By kabulEt = By.xpath("//button[normalize-space()='KABUL ET'] | //ngb-modal-window//button[last()]");
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(8))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.elementToBeClickable(kabulEt));
            jsClick(driver.findElement(kabulEt));
        } catch (Exception ignored) {}

        By firstNameBy = By.id("firstName");
        By atlaBtn = By.xpath("//button[normalize-space()='Atla'] | //button[normalize-space()='ATLA'] | //a[normalize-space()='Atla']");
        By otpInputSel = By.cssSelector("input[id^='otp_0_'], input[maxlength='1'][type='tel'], input[maxlength='6'][type='tel'], input[autocomplete='one-time-code']");

        // 3 saniyede firstName geldiyse direkt forma geçtik
        boolean formDirectlyLoaded = false;
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(3))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(firstNameBy));
            formDirectlyLoaded = true;
        } catch (Exception ignored) {}

        if (!formDirectlyLoaded) {
            // 20s içinde ya firstName ya Atla bekliyoruz
            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(20))
                    .until(d -> {
                        boolean fn = !d.findElements(firstNameBy).isEmpty() && d.findElements(firstNameBy).get(0).isDisplayed();
                        boolean atla = !d.findElements(atlaBtn).isEmpty();
                        return fn || atla;
                    });
            } catch (Exception ignored) {}

            List<org.openqa.selenium.WebElement> atlaList = driver.findElements(atlaBtn);
            if (!atlaList.isEmpty()) {
                // Atla butonu var → opsiyonel OTP, atla
                try { jsClick(atlaList.get(0)); } catch (Exception ignored) {}
                try { new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                    .until(d -> d.findElements(atlaBtn).isEmpty()); } catch (Exception ignored) {}
            } else {
                // Atla yok → zorunlu OTP → DB'den kodu al
                boolean otpVisible = false;
                try {
                    List<org.openqa.selenium.WebElement> otpEls = driver.findElements(otpInputSel);
                    otpVisible = !otpEls.isEmpty() && otpEls.get(0).isDisplayed();
                } catch (Exception ignored) {}
                if (otpVisible) {
                    String kod = null;
                    for (int i = 0; i < 15 && kod == null; i++) {
                        kod = olympusPage.getSmsKodu("90" + randomGsmNo);
                        if (kod == null) wait(1);
                    }
                    if (kod != null) {
                        List<org.openqa.selenium.WebElement> otpInputs = driver.findElements(By.cssSelector("input[id^='otp_0_']"));
                        if (otpInputs.isEmpty()) otpInputs = driver.findElements(otpInputSel);
                        if (otpInputs.size() == 1) {
                            otpInputs.get(0).click(); otpInputs.get(0).sendKeys(kod);
                        } else {
                            for (int i = 0; i < kod.length() && i < otpInputs.size(); i++) {
                                otpInputs.get(i).click(); otpInputs.get(i).sendKeys(String.valueOf(kod.charAt(i)));
                            }
                        }
                        try { waitForVisibility(dijitalUyelikPage.confirmBtn);
                            jsClick(driver.findElement(dijitalUyelikPage.confirmBtn)); } catch (Exception ignored) {}
                    }
                }
            }
        }

        // Loader ve firstName
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(15))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
        new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(30))
            .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.id("firstName")));
        getJSObject().executeScript("document.body.style.zoom='60%'");
        dijitalUyelikPage.vucutFormDoldur(ad, soyad, email, randomGsmNo, dogumTarihi);
    }

    @And("Vucut formu gonderilir")
    public void vucutFormuGonderilir() {
        dijitalUyelikPage.butonatikla();
        try {
            getWaitObject().until(
                org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                    By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
    }

    @And("Portal devam butonuna basilir")
    public void portalDevamButonunaBasilir() {
        By devamBtn = By.cssSelector("app-digital-member form button, app-digital-member button.mars-button");
        waitForVisibility(devamBtn);
        jsClick(driver.findElement(devamBtn));
        By kabulEtBtn = By.xpath("//ngb-modal-window//app-modal//div[last()]/button");
        try {
            getWaitObject().until(
                org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(kabulEtBtn));
            jsClick(driver.findElement(kabulEtBtn));
        } catch (Exception ignored) {}
    }

    @And("Portal formu gonderilir")
    public void portalFormuGonderilir() {
        dijitalUyelikPage.butonatikla();
        try {
            getWaitObject().until(
                org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                    By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {}
    }

    @Then("Portal OTP dogrulamasi atlanir")
    public void portalOtpDogrulamasiAtlanir() {
        dijitalUyelikPage.portalOtpPopupKapat();
    }

    @And("Portal SMS kodu DBden cekilip girilir {string}")
    public void portalSmsKoduDbdenCekilipGirilir(String gsmNo) {
        // OTP input görünene kadar bekle — birden fazla possible selector dene
        By otpSelector = By.cssSelector(
            "input[id^='otp_0_'], input[id^='otp'], input[class*='otp'], input[maxlength='1'][type='tel'], input[maxlength='6'][type='tel'], input[autocomplete='one-time-code']");
        boolean otpFound = false;
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(30))
                .until(org.openqa.selenium.support.ui.ExpectedConditions
                    .visibilityOfElementLocated(otpSelector));
            otpFound = true;
        } catch (Exception ignored) {}
        if (!otpFound) {
            // OTP modal gelmedi (telefon zaten dogrulandi veya farkli akis) — devam et
            System.out.println("Portal OTP input bulunamadi, OTP adimi atlaniyor.");
            return;
        }
        String kod = null;
        for (int i = 0; i < 10 && kod == null; i++) {
            kod = olympusPage.getSmsKodu("90" + randomGsmNo);
            if (kod == null) wait(1);
        }
        Assert.assertNotNull("Portal SMS kodu alinamadi!", kod);
        List<WebElement> inputs = driver.findElements(
                By.cssSelector("input[id^='otp_0_']"));
        if (inputs.isEmpty()) inputs = driver.findElements(otpSelector);
        if (inputs.size() == 1) {
            inputs.get(0).click();
            inputs.get(0).sendKeys(kod);
        } else {
            for (int i = 0; i < kod.length() && i < inputs.size(); i++) {
                inputs.get(i).click();
                inputs.get(i).sendKeys(String.valueOf(kod.charAt(i)));
            }
        }
        // OTP girildi — confirm butonu aktif olana kadar kısa bekle (max 2s)
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(2))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.elementToBeClickable(
                    By.cssSelector("button.confirm-button")));
        } catch (Exception ignored) {}
    }

    @And("Portal OTP confirm butonuna basilir")
    public void portalOtpConfirmButonunaBasilir() {
        dijitalUyelikPage.confirmButon();
    }

    // ══════════════════════════════════════════════════════════════════
    // JOIN US
    // ══════════════════════════════════════════════════════════════════

    @And("JoinUs devam butonuna basilir")
    public void joinUsDevamButonunaBasilir() { joinUsPage.devamEt(); }

    @And("JoinUs ilk devam butonuna basilir")
    public void joinUsIlkDevamButonunaBasilir() { joinUsPage.ilkDevamButonunaBas(); }

    @And("JoinUs kulup {string} secilir")
    public void joinUsKulupSecilir(String kulup) { joinUsPage.kulupSec(kulup); }

    @And("JoinUs paket secilir")
    public void joinUsPaketSecilir() { joinUsPage.paketSec(); }

    @And("JoinUs ulke {string} secilir")
    public void joinUsUlkeSecilir(String ulke) { joinUsPage.ulkeSec(ulke); }

    @And("JoinUs formu doldurulur ad {string} soyad {string} email {string} dogumtarihi {string} personelno {string}")
    public void joinUsFormuDoldurulur(String ad, String soyad, String email,
                                      String dogumTarihi, String personelNo) {
        joinUsPage.formDoldur(ad, soyad, email, randomGsmNo, dogumTarihi, personelNo);
    }

    @And("JoinUs onay butonuna basilir")
    public void joinUsOnayButonunaBasilir() { joinUsPage.confirmbuton(); }

    @Then("JoinUs OTP dogrulamasi atlanir")
    public void joinUsOtpDogrulamasiAtlanir() {
        try {
            By atlaBtn = By.xpath("//button[normalize-space()='Atla']");
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                .until(org.openqa.selenium.support.ui.ExpectedConditions.elementToBeClickable(atlaBtn));
            List<WebElement> list = driver.findElements(atlaBtn);
            if (!list.isEmpty()) list.get(0).click();
        } catch (Exception ignored) { }
    }

    @And("JoinUs SMS kodu DBden cekilip girilir {string}")
    public void joinUsSmsKoduDbdenCekilipGirilir(String gsmNo) {
        waitForVisibility(joinUsPage.getOtpLocator());
        String kod = olympusPage.getSmsKodu("90" + randomGsmNo);
        Assert.assertNotNull("JoinUs SMS kodu alinamadi!", kod);
        driver.findElement(joinUsPage.getOtpLocator()).sendKeys(kod);
    }

    @And("JoinUs OTP confirm butonuna basilir")
    public void joinUsOtpConfirmButonunaBasilir() { dijitalUyelikPage.confirmButon(); }

    // ══════════════════════════════════════════════════════════════════
    // OLYMPUS SEKME + ARAMA + ÜZERINE AL
    // ══════════════════════════════════════════════════════════════════

    @Given("Olympus sekmesine gecilir")
    public void olympusSekmesineGecilir() {
        // Olympus URL'ini içeren sekmeye geç
        String olympusHandle = driver.getWindowHandles().stream()
            .filter(h -> {
                driver.switchTo().window(h);
                return driver.getCurrentUrl().contains("olympus") ||
                       driver.getCurrentUrl().contains("marsathletic");
            })
            .findFirst()
            .orElse(new ArrayList<>(driver.getWindowHandles()).get(0));
        driver.switchTo().window(olympusHandle);
        waitForVisibility(By.id("gsmNo"));
    }

    @When("Telefon ile arama yapilir {string}")
    public void telefonIleAramaYapilir(String gsmNo) {
      //  olympusPage.kulupKolonunuAc();
        olympusPage.uyeAramaIle(randomGsmNo);


    }

    @When("Ilk satirda uzerine alinir")
    public void ilkSatirdaUzerineAlinir() {
        olympusPage.uzerineAl();
    }

    // ══════════════════════════════════════════════════════════════════
    // GÖREV
    // ══════════════════════════════════════════════════════════════════

    @And("{string} gorevi atanir")
    public void gorevAtanir(String gorevTipi) {
        aktifGorevTipi = gorevTipi;
        olympusPage.gorevMenuAc(gorevTipi);
    }

    @And("Gorev {string} neden koduyla kaydedilir")
    public void gorevNedenKoduylaKaydedilir(String nedenKodu) {
        gorevAtamaPage.gorevModalinuDoldurVeKaydet(aktifGorevTipi, nedenKodu);
        if (aktifGorevTipi != null && aktifGorevTipi.trim().equals("Satış Görüşmesi")) {
            driver.get("https://olympusdev-dashboard.marsathletic.com/member/lead");
            waitForVisibility(By.id("gsmNo"));
        }
    }

    // ══════════════════════════════════════════════════════════════════
    // ASSERT
    // ══════════════════════════════════════════════════════════════════

    @Then("Ilk satirda kaynak {string} gorunur")
    public void ilkSatirdaKaynakGorunur(String expected) {
        String gercek = olympusPage.getIlkSatirKaynak();
        Assert.assertTrue(
                "Kaynak beklenen: '" + expected + "' | Gercek: '" + gercek + "'",
                gercek.contains(expected));
    }

    @And("Ilk satirda ad {string} gorunur")
    public void ilkSatirdaAdGorunur(String expected) {
        String gercek = olympusPage.getIlkSatirAd();
        if (!gercek.toLowerCase().contains(expected.toLowerCase())) {
            SoftAssertionCollector.add("Ad beklenen: '" + expected + "' | Gercek: '" + gercek + "'");
        }
    }

    @And("Ilk satirda soyad {string} gorunur")
    public void ilkSatirdaSoyadGorunur(String expected) {
        String gercek = olympusPage.getIlkSatirSoyad();
        if (!gercek.toLowerCase().contains(expected.toLowerCase())) {
            SoftAssertionCollector.add("Soyad beklenen: '" + expected + "' | Gercek: '" + gercek + "'");
        }
    }

    @And("Ilk satirda kulup {string} gorunur")
    public void ilkSatirdaKulupGorunur(String beklenenKulup) {
        String actualKulup = olympusPage.getIlkSatirKulup();
        System.out.println("DEBUG Kulup actual = " + actualKulup);
        if (!beklenenKulup.trim().equals(actualKulup.trim())) {
            SoftAssertionCollector.add("Kulup beklenen: '" + beklenenKulup + "' | Gercek: '" + actualKulup + "'");
        }
    }

    @And("Ilk satirda satis temsilcisi {string} gorunur")
    public void ilkSatirdaSatisTemsilcisiGorunur(String beklenenTemsilci) {
        String actualTemsilci = olympusPage.getIlkSatirSatisTemsilcisi();
        System.out.println("DEBUG Satis Temsilcisi actual = " + actualTemsilci);
        if (!beklenenTemsilci.trim().equals(actualTemsilci.trim())) {
            SoftAssertionCollector.add("Satis Temsilcisi beklenen: '" + beklenenTemsilci + "' | Gercek: '" + actualTemsilci + "'");
        }
    }

    @And("Ilk satirda tags {string} gorunur")
    public void ilkSatirdaTagsGorunur(String beklenenTags) {
        String actual = olympusPage.getIlkSatirTags();
        actual = actual.replace("\n", " ").replace("\r", " ").replaceAll("\\s+", " ").trim();
        System.out.println("TAGS_ACTUAL|" + randomGsmNo + "|" + actual);
        if (!beklenenTags.trim().equalsIgnoreCase(actual)) {
            SoftAssertionCollector.add("Tags beklenen: '" + beklenenTags + "' | Gercek: '" + actual + "'");
        }
    }
    @And("iki saniye bekler")
    public void ikisaniyebekler()
    {
        wait(1);
    }

    // ══════════════════════════════════════════════════════════════════
    // YARDIMCI
    // ══════════════════════════════════════════════════════════════════

    private String resolvePortalUrl(String key) {
        switch (key.trim().toLowerCase()) {
            case "dijital-uyelik-formu": return PORTAL_BASE + "/tr/dijital-uyelik-formu";
            case "join-us":              return PORTAL_BASE + "/en/join-us";
            case "vucut-analizi-formu":  return PORTAL_BASE + "/tr/vucut-analizi-formu";
            default:                     return PORTAL_BASE + "/" + key;
        }
    }
    public static String getOrtakRandomGsmNo() {
        if (randomGsmNo == null) {
            randomGsmNo = TestData.generatePhone();
        }
        return randomGsmNo;
    }

    @And("günlük uyelik kazan click edilir")
    public void gunlukUyelikKazanClickEdilir() {
        click(driver.findElement(By.xpath("//button[@class='mars-button']")));
    }


    @Then("kulup ikon ac")
    public void kulupikonac() {
        click(driver.findElement(By.xpath("//button[@class='dropdown-toggle btn btn-primary btn-sm']")));
        wait(2);
        click(driver.findElement(By.id("lead-table6")));
    }

    @And("Portal Kulup ikinci kez değiştirilir")
    public void portalKulupIkinciKezDegistirilir() {
        dijitalUyelikPage.portalKulupIkinciKezDegistir();
    }

    @When("portali navigate ile acilir")
    public void portaliNavigateIleAcilir() {
        driver.get("https://portaldev-client.marsathletic.com/tr/dijital-uyelik-formu");
    }

    @And("Portala yeni telefon numarasi girilir {string}")
    public void portalaYeniTelefonNumarasiGirilir(String gsmNo) {
        WebElement phoneInput = driver.findElement(By.xpath("//input[@type='tel']"));
        phoneInput.clear();
        phoneInput.sendKeys(gsmNo);
    }
}