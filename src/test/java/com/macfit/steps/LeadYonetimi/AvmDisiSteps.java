package com.macfit.steps.LeadYonetimi;

import com.macfit.pages.AvmDisiPage;
import com.macfit.pages.OlympusPage;
import com.macfit.utils.CommonMethods;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class AvmDisiSteps extends CommonMethods {

    AvmDisiPage page = new AvmDisiPage();
    OlympusPage olympusPage = new OlympusPage();

    @When("Avm disi etkinlik sayfasina gidilir")
    public void sayfaya_git() {
        driver.get("https://olympusdev-subscription-ui.marsathletic.com/#/activity?key=30154104-268c-4815-8b96-e4ab69e10cb5");
    }

    @When("sayfa zoom out yapilir")
    public void sayfa_zoom_out_yapilir() {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("document.body.style.zoom='60%'");
    }

    @And("avm disi formuna ad {string} girilir")
    public void ad_gir(String ad) {
        sendText(page.adInput, ad);
    }

    @And("avm disi formuna soyad {string} girilir")
    public void soyad_gir(String soyad) {
        sendText(page.soyadInput, soyad);
    }

    @And("avm disi formuna ortak random gsm no girilir")
    public void avmDisiFormunaOrtakRandomGsmNoGirilir() {
        String ortakGsmNo = LeadPortalFlowSteps.getOrtakRandomGsmNo();
        System.out.println("Ortak random GSM: " + ortakGsmNo);
        sendText(page.gsmNoInput, ortakGsmNo);
    }

    @And("avm disi formunda ulke kodu {string} secilir")
    public void ulke_kodu_sec(String kod) {
        page.dropdownSec(page.ulkeKoduDropdown, kod);
    }

    @And("avm disi formuna eposta {string} girilir")
    public void email_gir(String email) {
        sendText(page.emailInput, email);
    }

    @And("avm disi formunda cinsiyet secilir")
    public void cinsiyet_sec() {
        page.cinsiyetSec();
    }

    @And("avm disi formuna dogum tarihi {string} girilir")
    public void dogum_tarihi_gir(String tarih) {
        sendText(page.dogumTarihiInput, tarih);
    }

    @And("avm disi formunda sehir {string} secilir")
    public void sehir_sec(String sehir) {
        page.dropdownSec(page.sehirDropdown, sehir);
    }

    @And("avm disi formunda kulup {string} secilir")
    public void kulup_sec(String kulup) {
        page.kulupSec(kulup);
    }

    @And("avm disi formunda izinler kabul edilir")
    public void izinler() {
        page.izinleriKabulEt();
    }

    @And("avm disi formunda Devam Et butonuna basilir")
    public void devam_et() {
        waitForClickability(page.devamEt);
        jsClick(page.devamEt);
    }

    @And("SMS kodu DBden cekilip OTP alanina girilir")
    public void smsKoduDbdenCekilipOtpAlaninaGirilir() {
        String ortakGsmNo = LeadPortalFlowSteps.getOrtakRandomGsmNo();
        String kod = null;

        for (int i = 0; i < 15 && kod == null; i++) {
            kod = olympusPage.getSmsKodu("90" + ortakGsmNo);
            if (kod == null) try { Thread.sleep(Math.min(500L * (i + 1), 3000L)); } catch (InterruptedException ignored) {}
        }

        Assert.assertNotNull("SMS kodu alinamadi! GSM: " + ortakGsmNo, kod);
        System.out.println("DB'den gelen OTP: " + kod);
        page.otpKodunuGir(kod);
    }

    @And("OTP Dogrula butonuna basilir")
    public void dogrulaBtn() {
        page.otpDogrulaButonunaBas();
    }

    @And("OTP dogrulamasi kapatilir")
    public void otpDogrulamasiKapatilir() {
        page.otpDogrulamaKapat();
    }

    @When("ortak random gsm no ile telefon aramasi yapilir")
    public void ortakRandomGsmNoIleTelefonAramasiYapilir() {
        String ortakGsmNo = LeadPortalFlowSteps.getOrtakRandomGsmNo();
        olympusPage.kulupKolonunuAc();
        olympusPage.uyeAramaIle(ortakGsmNo);
    }

    @Then("avm disi formunun gonderildigi dogrulanir")
    public void dogrula() {
        By success = By.xpath("//*[contains(normalize-space(),'Kayıt başarılı bir şekilde oluşturuldu')]");
        getWaitObject().until(ExpectedConditions.visibilityOfElementLocated(success));
        Assert.assertTrue(true);
    }

}