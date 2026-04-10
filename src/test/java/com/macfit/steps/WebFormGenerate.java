package com.macfit.steps;

import org.openqa.selenium.By;

import com.macfit.utils.CommonMethods;
import com.macfit.utils.ConfigsReader;

public class WebFormGenerate extends CommonMethods {
	public static void main(String[] args)  {
		
		setUp();
		
		sendText(driver.findElement(By.id("userName")), ConfigsReader.getProperty("username"));
		sendText(driver.findElement(By.id("password")), ConfigsReader.getProperty("password"));

		click(driver.findElement(By.id("add-btn")));
		
		System.out.println("I Logged In");
		
		wait(2);
		
//		driver.navigate().to("https://olympusdev-dashboard.marsathletic.com/campaign-management/forms/create");
		driver.navigate().to("https://olympusstg-dashboard.marsathletic.com/campaign-management/forms/create");
		wait(2);
		
		
		
		//WebForm İsmi
		
		sendText(driver.findElement(By.xpath("//div[@class='field']//input[@class='input ng-pristine ng-invalid input-error ng-touched']")), "WebFormIsmi");
		
		// Web Sitesi URL
		
		
		sendText(driver.findElement(By.xpath("//input[@class='input ng-pristine ng-invalid input-error ng-touched']")), "WebFormIsmi");
		sendText(driver.findElement(By.xpath("//input[@class='control tr ng-pristine ng-invalid is-invalid ng-touched']")), "WebSitesiTR");
		sendText(driver.findElement(By.xpath("//input[@class='control en ng-pristine ng-invalid is-invalid ng-touched']")), "WebSitesiENG");
		
		sendText(driver.findElement(By.xpath("//input[@class='baf-field-input ng-valid ng-valid-maxlength ng-empty ng-dirty ng-valid-parse ng-touched']")), "905442266473");
		
		
		//Marka Logosu Logo yukle 
		
		
		//ARKA PLAN GÖRSELİ
		
		
		
		// ANA BAŞLIK METNİ
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//		tearDown();
	}

}
