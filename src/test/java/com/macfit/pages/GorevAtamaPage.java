package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;

public class GorevAtamaPage extends CommonMethods {

    public final By kaydetButon = By.id("add-btn");
    public final By nedenSelect = By.id("rejectReasons");

    public GorevAtamaPage() {
        PageFactory.initElements(driver, this);
    }

    public void gorevModalinuDoldurVeKaydet(String gorevTipi, String nedenKodu) {
        try {
            getWaitObject().until(
                org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
                    By.className("ols-loader")));
        } catch (Exception ignored) {}
        try {
            By nedenOption = By.cssSelector("select#rejectReasons option[value]");
            waitForVisibility(nedenSelect);
            new Select(driver.findElement(nedenSelect))
                .selectByVisibleText(nedenKodu);
        } catch (Exception ignored) { }

        waitForClickability(driver.findElement(kaydetButon));
        driver.findElement(kaydetButon).click();

        try {
            By hayirBtn = By.xpath("//ngb-modal-window[2]//app-modal-warning//div/button");
            waitForVisibility(hayirBtn);
            driver.findElement(hayirBtn).click();
        } catch (Exception ignored) { }
    }
}
