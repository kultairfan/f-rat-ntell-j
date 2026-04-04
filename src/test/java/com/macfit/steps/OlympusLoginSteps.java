package com.macfit.steps;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import com.macfit.utils.CommonMethods;
import com.macfit.utils.ConfigsReader;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class OlympusLoginSteps extends CommonMethods{
	@When("ı loggin with valid credentials to olmypus")
	public void ı_loggin_with_valid_credentials_to_olmypus() {
	  
	}
	@Then("click and send text of username")
	public void click_and_send_text_of_username() {
		sendText(driver.findElement(By.id("userName")), ConfigsReader.getProperty("username"));
		 sendText(driver.findElement(By.id("password")), ConfigsReader.getProperty("password"));
		 click(driver.findElement(By.id("add-btn")));
		  
	}
	@Then("click Uyelik islemleri")
	public void click_uyelik_islemleri() {
		click(waitForVisibility(By.id("topnav-hamburger-icon")));
		click(driver.findElement(By.xpath("//span[text()=' Üyelik İşlemleri']")));
	}
	@Then("click uyelik islemleri sub")
	public void click_uyelik_islemleri_sub() {
		click(driver.findElement(By.xpath("//div[@class='collapse menu-dropdown show']/ul/li/a[1]")));
	}
	@Then("sendTExt yo username then click search")
	public void send_t_ext_yo_username_then_click_search() {
	     sendText(driver.findElement(By.xpath("//input[@formcontrolname='memberId']")), ConfigsReader.getProperty("uyeNo"));
	     click(driver.findElement(By.xpath("//div[@class='d-flex justify-content-center']")));
	}
	@Then("move forward wait {int} scnds")
	public void move_forward_wait_scnds(Integer int1) {
		WebElement btn = driver.findElement(By.cssSelector("button.green-button"));
		scrollToElement(btn);
		jsClick(btn);
	}
	@Then("click paketimi baslat  click yıllık  click pesın click gold move forward")
	public void click_paketimi_baslat_click_yıllık_click_pesın_click_gold_move_forward() {
		click(driver.findElement(By.id("ruleRejoin")));
		WebElement element = (driver.findElement(By.xpath("(//input[@name='payment-type-radio'])[2]")));
		waitForClickability(element);
		click(driver.findElement(By.xpath("(//input[@name='payment-type-radio'])[2]")));
		click(driver.findElement(By.id("plan_discounted_fee_GOLD")));
		click(driver.findElement(By.cssSelector("button.green-button")));
	    
	}
	@Then("send passport number")
	public void send_passport_number() {
		sendText(driver.findElement(By.id("personalId")), "testifi");
	     
	}
	@Then("approved and ödeme ekranına geç")
	public void approved_and_ödeme_ekranına_geç() {
		click(driver.findElement(By.cssSelector("button.payment-button")));
		
	     
	}
	@Then("click {int} taksit click contrat all then üyeligi baslat")
	public void click_taksit_click_contrat_all_then_üyeligi_baslat(Integer int1) {
		click(driver.findElement(By.xpath("//input[@value=\"9\"]")));
		click(driver.findElement(By.id("groupId-0")));
		click(driver.findElement(By.id("groupId-1")));
		click(driver.findElement(By.id("groupId-2")));
		
		String Text = driver.findElement(By.xpath("//div[@class='d-flex mb-3']")).getText();
		System.out.println(Text);
	    
	}
	@Then("validate payments success")
	public void validate_payments_success() {
		WebElement el = driver.findElement(By.xpath("//div[@class='center']"));
	if(el.getText().equals("FIRAT1TEST TRANSFER TEST (5572438) İşleminiz başarıyla tamamlandı."))
	{
		System.out.println("Passed");
	}
	else
	{
		System.out.println("Failed");
	}
		
		
		
	     
	}


}
