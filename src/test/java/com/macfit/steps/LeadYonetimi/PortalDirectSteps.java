package com.macfit.steps.LeadYonetimi;

import com.macfit.pages.DijitalUyelikPage;
import com.macfit.utils.CommonMethods;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.By;

public class PortalDirectSteps extends CommonMethods {

    private DijitalUyelikPage dijitalUyelikPage;

    private static final String PORTAL_BASE = "https://portaldev-client.marsathletic.com";

    @Given("{string} direct portal acilir")
    public void directPortalAcilir(String portalUrlKey) {
        dijitalUyelikPage = new DijitalUyelikPage();

        driver.get(resolvePortalUrl(portalUrlKey));
        try {
            driver.manage().window().maximize();
        } catch (Exception ignored) {
        }

        waitForVisibility(By.id("phone"));
        getJSObject().executeScript("document.body.style.zoom='60%'");
    }

    @When("Portala example gsm numarasi girilir {string}")
    public void portalaExampleGsmNumarasiGirilir(String gsmNo) {
        waitForVisibility(By.id("phone"));
        driver.findElement(By.id("phone")).clear();
        driver.findElement(By.id("phone")).sendKeys(gsmNo);
    }


    @And("Portal direct form bilgileri girilir ad {string} soyad {string} email {string} gsmNo {string} dogumtarihi {string}")
    public void portalDirectFormBilgileriGirilir(String ad, String soyad, String email, String gsmNo, String dogumTarihi) {
        // KABUL ET varsa kapat
        dijitalUyelikPage.devamet();

        // firstName gelmediyse giriş butonuna bas
        boolean firstNameAlreadyVisible = false;
        try {
            new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(3))
                    .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.id("firstName")));
            firstNameAlreadyVisible = true;
        } catch (Exception ignored) {
        }

        if (!firstNameAlreadyVisible) {
            dijitalUyelikPage.girisButton();

            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(5))
                        .until(org.openqa.selenium.support.ui.ExpectedConditions.or(
                                org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.id("firstName")),
                                org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.cssSelector("ngb-modal-window"))
                        ));
            } catch (Exception ignored) {
            }

            dijitalUyelikPage.devamet();
            dijitalUyelikPage.portalOtpPopupKapat();

            try {
                new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(8))
                        .until(org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(By.id("firstName")));
            } catch (Exception ignored) {
            }
        }

        getJSObject().executeScript("document.body.style.zoom='60%'");
        dijitalUyelikPage.formDoldur(ad, soyad, email, gsmNo, dogumTarihi);
    }


    private String resolvePortalUrl(String key) {
        switch (key.trim().toLowerCase()) {
            case "dijital-uyelik-formu":
                return PORTAL_BASE + "/tr/dijital-uyelik-formu";
            case "vucut-analizi-formu":
                return PORTAL_BASE + "/tr/vucut-analizi-formu";
            case "join-us":
                return PORTAL_BASE + "/en/join-us";
            default:
                return PORTAL_BASE + "/" + key;
        }
    }
    @And("Direct portal sehir {string} secilir")
    public void directPortalSehirSecilir(String sehir) {
        dijitalUyelikPage.sehirSec(sehir);
    }

    @And("Direct portal kulup {string} secilir")
    public void directPortalKulupSecilir(String kulup) {
        dijitalUyelikPage.kulupSec(kulup);
    }

    @And("Direct portal devam butonuna basilir")
    public void directPortalDevamButonunaBasilir() {
        By devamBtn = By.cssSelector("app-digital-member form button, app-digital-member button.mars-button");
        waitForVisibility(devamBtn);
        jsClick(driver.findElement(devamBtn));

        By kabulEtBtn = By.xpath("//ngb-modal-window//app-modal//div[last()]/button");
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated(kabulEtBtn));
            jsClick(driver.findElement(kabulEtBtn));
        } catch (Exception ignored) {
        }
    }

    @And("Direct portal formu gonderilir")
    public void directPortalFormuGonderilir() {
        dijitalUyelikPage.butonatikla();
        try {
            getWaitObject().until(
                    org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                            By.cssSelector(".ols-loader")));
        } catch (Exception ignored) {
        }
    }

    @Then("Direct portal OTP dogrulamasi atlanir")
    public void directPortalOtpDogrulamasiAtlanir() {
        dijitalUyelikPage.portalOtpPopupKapat();
    }
    @And("Direct portal kulup ikinci kez degistirilir")
    public void directPortalKulupIkinciKezDegistirilir() {
        dijitalUyelikPage.portalKulupIkinciKezDegistir();
    }
}