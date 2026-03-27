package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;

import java.util.List;

public class AdayUyePage extends CommonMethods {

    // ── Modal form locator'ları ───────────────────────────────────────
    public final By inputAd          = By.id("name-field");
    public final By inputSoyad       = By.id("surname-field");
    public final By inputGsm         = By.id("gsmNo-field");
    public final By inputEmail       = By.id("email-field");
    public final By inputDogumTarihi = By.id("leadFormBirthDate");
    public final By kaynakDropdown = By.id("sourceId");
    public final By genderErkek      = By.id("genderMen");
    public final By genderKadin      = By.id("genderWomen");
    public final By btnDevamEt       = By.id("add-btn");
    public final By adayUyeEkleX = By.xpath("//button[@class='btn btn-light']");

    // ── OTP ──────────────────────────────────────────────────────────
    public final By btnOtpAtla  = By.xpath("//button[normalize-space()='Atla']");
    public final By inputOtp    = By.cssSelector("input[id^='otp_0_']");
    public final By btnConfirm  = By.xpath("//button[@class='confirm-button']");

    // ── Başarı mesajı ────────────────────────────────────────────────
    public final By toastBasari = By.xpath(
            "//*[contains(text(),'başarıyla') or contains(text(),'basariyla') or contains(text(),'oluşturuldu')]");

    public AdayUyePage() {
        PageFactory.initElements(driver, this);
    }

    // ══════════════════════════════════════════════════════════════════
    // FORM
    // ══════════════════════════════════════════════════════════════════

    /**
     * Aday Üye Ekle formunu doldurur ve Devam Et'e basar.
     *
     * @param kaynak     Kaynak Bilgileri dropdown'ındaki görünen text (ör: "Kulübe gelen", "Insider")
     * @param dogumTarihi  gg.aa.yyyy formatında (ör: "01.01.1990")
     */
    public void adayUyeFormunuDoldur(String ad, String soyad, String gsmNo,
                                     String email, String kaynak, String dogumTarihi) {
        waitForVisibility(inputAd);
        sendText(driver.findElement(inputAd), ad);
        sendText(driver.findElement(inputSoyad), soyad);
        sendText(driver.findElement(inputGsm), gsmNo);
        sendText(driver.findElement(inputEmail), email);

        // Cinsiyet — Erkek seç
        WebElement erkek = driver.findElement(genderErkek);
        if (!erkek.isSelected()) erkek.click();

        // Doğum Tarihi
        sendText(driver.findElement(inputDogumTarihi), dogumTarihi);

        // Kaynak Bilgileri — native select
        kaynakSec(kaynak);

        wait(1);
        click(driver.findElement(btnDevamEt));
    }

    private void kaynakSec(String kaynak) {
        // Loader kaybolana kadar bekle
        getWaitObject().until(ExpectedConditions.invisibilityOfElementLocated(
                By.className("ols-loader")));
        waitForVisibility(kaynakDropdown);
        Select select = new Select(driver.findElement(kaynakDropdown));
        select.selectByValue("16"); // Kulübe gelen = value 16, görünen text aramak yerine direkt value
    }

    // ══════════════════════════════════════════════════════════════════
    // OTP
    // ══════════════════════════════════════════════════════════════════

    public void otpAtla() {
        try {
            wait(2);

            List<WebElement> geriList = driver.findElements(By.xpath("//button[normalize-space()='Geri']"));
            if (!geriList.isEmpty()) {
                click(geriList.get(0));
                wait(1);
                return;
            }

            List<WebElement> atlaList = driver.findElements(btnOtpAtla);
            if (!atlaList.isEmpty()) {
                click(atlaList.get(0));
                wait(1);
                return;
            }

            List<WebElement> closeList = driver.findElements(adayUyeEkleX);
            if (!closeList.isEmpty()) {
                try {
                    click(closeList.get(0));
                } catch (Exception e) {
                    getJSObject().executeScript("arguments[0].click();", closeList.get(0));
                }
                wait(1);
                return;
            }

        } catch (Exception ignored) {
        }
    }

    public void otpDogrula(String kod) {
        wait(2);
        // 4 ayrı input kutusuna tek tek yaz
        List<WebElement> otpInputlar = driver.findElements(
                By.cssSelector("input[id^='otp_0_']"));

        if (!otpInputlar.isEmpty() && kod != null) {
            // Tüm kodu ilk input'a gönder — Angular otomatik dağıtıyor
            otpInputlar.get(0).click();
            otpInputlar.get(0).sendKeys(kod);
            wait(1);
        }
    }

    public void otpConfirmBas() {
        try {
            click(driver.findElement(btnConfirm));
            wait(2);
        } catch (Exception ignored) { }
    }

    // ══════════════════════════════════════════════════════════════════
    // BAŞARI KONTROL
    // ══════════════════════════════════════════════════════════════════

    public void adayUyeBasariKontrol() {
        try {
            waitForVisibility(toastBasari);
        } catch (Exception ignored) { }
        wait(2);
    }
    public void adayUyePopupKapat() {
        try {
            waitForVisibility(adayUyeEkleX);
            click(driver.findElement(adayUyeEkleX));
        } catch (Exception e) {
            getJSObject().executeScript("arguments[0].click();", driver.findElement(adayUyeEkleX));
        }
    }
}