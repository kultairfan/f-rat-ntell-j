package com.macfit.steps.LeadYonetimi;

import com.macfit.pages.AdayUyePage;
import com.macfit.pages.DijitalUyelikPage;
import com.macfit.pages.GorevAtamaPage;
import com.macfit.pages.JoinUsPage;
import com.macfit.pages.OlympusPage;
import com.macfit.utils.CommonMethods;
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

    private String aktifGsmNo;
    private String aktifGorevTipi;

    private static final String PORTAL_BASE = "https://portaldev-client.marsathletic.com";

    // ══════════════════════════════════════════════════════════════════
    // LOGIN
    // ══════════════════════════════════════════════════════════════════

    @Given("Olympus dashboard acilir ve giris yapilir")
    public void olympusDashboardAcilirVeGirisYapilir() {
        olympusPage       = new OlympusPage();
        joinUsPage        = new JoinUsPage();
        dijitalUyelikPage = new DijitalUyelikPage();
        adayUyePage       = new AdayUyePage();
        gorevAtamaPage    = new GorevAtamaPage();
        olympusPage.olympusLogin();
    }

    // ══════════════════════════════════════════════════════════════════
    // ADAY ÜYE
    // ══════════════════════════════════════════════════════════════════

    @When("Aday uye sayfasina gidilir")
    public void adayUyeSayfasinaGidilir() {
        olympusPage.adayUyeSayfasinaGit();
        olympusPage.adayUyeEkleBtn();
    }


    @And("Aday uye ekle formuna bilgiler girilir ad {string} soyad {string} gsmNo {string} email {string} kaynak {string}")
    public void adayUyeEkleFormunaBilgilerGirilir(String ad, String soyad, String gsmNo,
                                                   String email, String kaynak) {
        aktifGsmNo = gsmNo;
        adayUyePage.adayUyeEkleModalAc();
        adayUyePage.adayUyeFormunuDoldur(ad, soyad, gsmNo, email, kaynak);
    }

    @And("OTP dogrulamasi atlanir")
    public void otpDogrulamasiAtlanir() {
        adayUyePage.otpAtla();
    }

    @And("SMS kodu DBden cekilip OTP girilir {string}")
    public void smsKoduDbdenCekilipOtpGirilir(String gsmNo) {
        String kod = olympusPage.getSmsKodu("90" + gsmNo);
        Assert.assertNotNull("SMS kodu alinamadi! GSM: " + gsmNo, kod);
        adayUyePage.otpDogrula(kod);
    }

    @And("OTP confirm butonuna basilir")
    public void otpConfirmButonunaBasilir() {
        adayUyePage.otpConfirmBas();
    }

    @Then("Aday uye basariyla olusturulur")
    public void adayUyeBasariyleOlusturulur() {
        adayUyePage.adayUyeBasariKontrol();
    }

    // ══════════════════════════════════════════════════════════════════
    // PORTAL
    // ══════════════════════════════════════════════════════════════════

    @When("{string} portali acilir")
    public void portaliAcilir(String portalUrlKey) {
        driver.switchTo().newWindow(WindowType.TAB);
        driver.get(resolvePortalUrl(portalUrlKey));
        driver.manage().window().maximize();
        getJSObject().executeScript("document.body.style.zoom='60%'");
        wait(2);
    }

    @And("Portala telefon numarasi girilir {string}")
    public void portalaTelefonNumarasiGirilir(String gsmNo) {
        aktifGsmNo = gsmNo;
        waitForVisibility(By.id("phone"));
        driver.findElement(By.id("phone")).sendKeys(gsmNo);
    }

    @And("Portal sehir {string} secilir")
    public void portalSehirSecilir(String sehir) {
        dijitalUyelikPage.sehirSec(sehir);
    }

    @And("Portal kulup {string} secilir")
    public void portalKulupSecilir(String kulup) {
        dijitalUyelikPage.kulupSec(kulup);
    }

    @And("Portal form bilgileri girilir ad {string} soyad {string} email {string} dogumtarihi {string}")
    public void portalFormBilgileriGirilir(String ad, String soyad, String email, String dogumTarihi) {
        dijitalUyelikPage.girisButton();
        dijitalUyelikPage.devamet();
        dijitalUyelikPage.formDoldur(ad, soyad, email, aktifGsmNo, dogumTarihi);
    }

    @And("Portal formu gonderilir")
    public void portalFormuGonderilir() {
        dijitalUyelikPage.butonatikla();
        wait(2);
    }

    @Then("Portal OTP dogrulamasi atlanir")
    public void portalOtpDogrulamasiAtlanir() {
        try {
            wait(2);
            List<WebElement> list = driver.findElements(By.xpath("//button[normalize-space()='Atla']"));
            if (!list.isEmpty()) list.get(0).click();
        } catch (Exception ignored) { }
    }

    @And("Portal SMS kodu DBden cekilip girilir {string}")
    public void portalSmsKoduDbdenCekilipGirilir(String gsmNo) {
        String kod = olympusPage.getSmsKodu("90" + gsmNo);
        Assert.assertNotNull("Portal SMS kodu alinamadi! GSM: " + gsmNo, kod);
        wait(2);
        driver.findElement(joinUsPage.getOtpLocator()).sendKeys(kod);
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
        joinUsPage.formDoldur(ad, soyad, email, aktifGsmNo, dogumTarihi, personelNo);
    }

    @And("JoinUs onay butonuna basilir")
    public void joinUsOnayButonunaBasilir() { joinUsPage.confirmbuton(); }

    @Then("JoinUs OTP dogrulamasi atlanir")
    public void joinUsOtpDogrulamasiAtlanir() {
        try {
            wait(2);
            List<WebElement> list = driver.findElements(By.xpath("//button[normalize-space()='Atla']"));
            if (!list.isEmpty()) list.get(0).click();
        } catch (Exception ignored) { }
    }

    @And("JoinUs SMS kodu DBden cekilip girilir {string}")
    public void joinUsSmsKoduDbdenCekilipGirilir(String gsmNo) {
        String kod = olympusPage.getSmsKodu("90" + gsmNo);
        Assert.assertNotNull("JoinUs SMS kodu alinamadi! GSM: " + gsmNo, kod);
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
        driver.switchTo().window(new ArrayList<>(driver.getWindowHandles()).get(0));
        wait(1);
    }

    @When("Telefon ile arama yapilir {string}")
    public void telefonIleAramaYapilir(String gsmNo) {
        aktifGsmNo = gsmNo;
        olympusPage.uyeAramaIle(gsmNo);
        wait(2);
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
        if ("Satis Gorusmesi".equals(aktifGorevTipi)) {
            wait(2);
            driver.get("https://olympusdev-dashboard.marsathletic.com/member/lead");
            wait(2);
        }
    }

    // ══════════════════════════════════════════════════════════════════
    // ASSERT
    // ══════════════════════════════════════════════════════════════════

    @Then("Ilk satirda kaynak {string} gorunur")
    public void ilkSatirdaKaynakGorunur(String expected) {
        String gercek = olympusPage.getIlkSatirKaynak();
        Assert.assertTrue("Kaynak beklenen: '" + expected + "' | Gercek: '" + gercek + "'",
                gercek.contains(expected));
    }

    @Then("Ilk satirda isim {string} gorunur")
    public void ilkSatirdaIsimGorunur(String expected) {
        List<WebElement> list = driver.findElements(
                By.xpath("//span[normalize-space()='" + expected + "']"));
        Assert.assertFalse("Isim bulunamadi: " + expected, list.isEmpty());
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
