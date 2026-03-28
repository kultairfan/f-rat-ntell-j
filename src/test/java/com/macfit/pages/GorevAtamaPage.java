package com.macfit.pages;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;

public class GorevAtamaPage extends CommonMethods {

    public final By kaydetButon = By.xpath("//button[@id='add-btn']");
    public final By nedenSelect = By.xpath("//select[@id='rejectReasons']");

    public GorevAtamaPage() {
        PageFactory.initElements(driver, this);
    }

    public void gorevModalinuDoldurVeKaydet(String gorevTipi, String nedenKodu) {
        wait(1);
        try {
            By nedenOption = By.xpath("//option[normalize-space()='" + nedenKodu + "']");
            waitForVisibility(nedenSelect);
            driver.findElement(nedenOption).click();
        } catch (Exception ignored) { }

        waitForClickability(driver.findElement(kaydetButon));
        driver.findElement(kaydetButon).click();
        wait(1);

        try {
            By hayirBtn = By.xpath("//ngb-modal-window[2]//app-modal-warning//div/button");
            waitForVisibility(hayirBtn);
            driver.findElement(hayirBtn).click();
            wait(1);
        } catch (Exception ignored) { }
    }
}
