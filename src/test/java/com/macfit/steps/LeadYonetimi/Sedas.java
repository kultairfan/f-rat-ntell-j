package com.macfit.steps.LeadYonetimi;

import com.macfit.utils.CommonMethods;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

public class Sedas extends CommonMethods {
    public static void main(String[] args) {

        setUp();

        click(driver.findElement(By.xpath("//a[@class='btn btn-brand m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill']")));
        wait(1);

        WebElement anyFrame = driver.findElement(By.xpath("//iframe"));
        switchToFrame(anyFrame);

        System.out.println("Frame içine geçildi.");
    click(driver.findElement(By.xpath("//div[contains(@class,'recaptcha-checkbox-border')]")));
        System.out.println("Recapthe click");
        driver.switchTo().defaultContent();
        System.out.println("Ana sayfaya geri dönüldü.");
    }
}