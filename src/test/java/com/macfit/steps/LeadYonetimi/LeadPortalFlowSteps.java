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

    private static String randomGsmNo;
    private String aktifGorevTipi;

    private static final String PORTAL_BASE = "https://portaldev-client.marsathletic.com";

    // ══════════════════════════════════════════════════════════════════
    // LOGIN
    // ══════════════════════════════════════════════════════════════════

    @Given("Olympus dashboard acilir ve giris yapilir")
    public void olympusDashboardAcilirVeGirisYapilir() {
        randomGsmNo       = TestData.generatePhone();
        olympusPage       = new OlympusPage();
        joinUsPage        = new JoinUsPage();
        dijitalUyelikPage = new DijitalUyelikPage();
        adayUyePage       = new AdayUyePage();
        gorevAtamaPage    = new GorevAtamaPage();
        olympusPage.olympusLogin();
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
        String kod = olympusPage.getSmsKodu("90" + randomGsmNo);
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
        driver.switchTo().newWindow(WindowType.TAB);
        driver.get(resolvePortalUrl(portalUrlKey));
        driver.manage().window().maximize();
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
        dijitalUyelikPage.kulupSec(kulup);
    }

    @And("Portal form bilgileri girilir ad {string} soyad {string} email {string} dogumtarihi {string}")
    public void portalFormBilgileriGirilir(String ad, String soyad, String email, String dogumTarihi) {
        dijitalUyelikPage.girisButton();
        dijitalUyelikPage.devamet();
        // "bilgiler" yerine firstName input'u bekle — URL farklı olabilir
        waitForVisibility(By.id("firstName"));
        getJSObject().executeScript("document.body.style.zoom='60%'");
        dijitalUyelikPage.formDoldur(ad, soyad, email, randomGsmNo, dogumTarihi);
    }

    @And("Portal devam butonuna basilir")
    public void portalDevamButonunaBasilir() {
        By devamBtn = By.xpath("/html/body/app-root/app-digital-member-layout/main/app-digital-member/div/div[2]/form/button");
        waitForVisibility(devamBtn);
        jsClick(driver.findElement(devamBtn));
        By kabulEtBtn = By.xpath("/html/body/ngb-modal-window/div/div/app-modal/div[3]/button");
        waitForVisibility(kabulEtBtn);
        jsClick(driver.findElement(kabulEtBtn));
    }

    @And("Portal formu gonderilir")
    public void portalFormuGonderilir() {
        dijitalUyelikPage.butonatikla();
        wait(2);
    }

    @Then("Portal OTP dogrulamasi atlanir")
    public void portalOtpDogrulamasiAtlanir() {
        dijitalUyelikPage.portalOtpPopupKapat();
    }

    @And("Portal SMS kodu DBden cekilip girilir {string}")
    public void portalSmsKoduDbdenCekilipGirilir(String gsmNo) {
        wait(5);
        String kod = olympusPage.getSmsKodu("90" + randomGsmNo);
        Assert.assertNotNull("Portal SMS kodu alinamadi!", kod);
        wait(2);
        List<WebElement> inputs = driver.findElements(
                By.cssSelector("input[id^='otp_0_']"));
        if (inputs.size() == 1) {
            inputs.get(0).click();
            inputs.get(0).sendKeys(kod);
        } else {
            for (int i = 0; i < kod.length() && i < inputs.size(); i++) {
                inputs.get(i).click();
                inputs.get(i).sendKeys(String.valueOf(kod.charAt(i)));
            }
        }
        wait(1);
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
            wait(2);
            List<WebElement> list = driver.findElements(
                    By.xpath("//button[normalize-space()='Atla']"));
            if (!list.isEmpty()) list.get(0).click();
        } catch (Exception ignored) { }
    }

    @And("JoinUs SMS kodu DBden cekilip girilir {string}")
    public void joinUsSmsKoduDbdenCekilipGirilir(String gsmNo) {
        String kod = olympusPage.getSmsKodu("90" + randomGsmNo);
        Assert.assertNotNull("JoinUs SMS kodu alinamadi!", kod);
        wait(2);
        driver.findElement(joinUsPage.getOtpLocator()).sendKeys(kod);
    }

    @And("JoinUs OTP confirm butonuna basilir")
    public void joinUsOtpConfirmButonunaBasilir() { dijitalUyelikPage.confirmButon(); }

    // ══════════════════════════════════════════════════════════════════
    // OLYMPUS SEKME + ARAMA + ÜZERINE AL
    // ══════════════════════════════════════════════════════════════════

    @Given("Olympus sekmesine gecilir")
    public void olympusSekmesineGecilir() {
        driver.switchTo().window(
                new ArrayList<>(driver.getWindowHandles()).get(0));
        waitForVisibility(By.id("gsmNo"));
    }

    @When("Telefon ile arama yapilir {string}")
    public void telefonIleAramaYapilir(String gsmNo) {
        olympusPage.kulupKolonunuAc();
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
        System.out.println("DEBUG Tags actual = " + actual);
        if (!beklenenTags.trim().equals(actual)) {
            SoftAssertionCollector.add("Tags beklenen: '" + beklenenTags + "' | Gercek: '" + actual + "'");
        }
    }
    @And("iki saniye bekler")
    public void ikisaniyebekler()
    {
        wait(2);
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
}