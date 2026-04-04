package com.macfit.testbase;

import java.time.Duration;
import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import com.macfit.utils.ConfigsReader;
import com.macfit.utils.Constants;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class BaseClass {

	public static WebDriver driver;

	public static void setUp() {

		ConfigsReader.readProperties(Constants.CONFIGURATION_FILEPATH);

		String browser = ConfigsReader.getProperty("browser");

		switch (browser.toLowerCase()) {
		case "chrome":
//			ChromeOptions options = new ChromeOptions();
//				options.addArguments("--headless");
				
			driver = new ChromeDriver( /*options*/);
			break;

		case "firefox":
			driver = new FirefoxDriver();
			break;

		default:
			// We could use chrome as a case to cover the possibility of no match
			// driver = new ChromeDriver();
			break;

		}
		

		driver.manage().window().maximize();
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(Constants.IMPLICIT_WAIT_TIME));
//		JavascriptExecutor js = (JavascriptExecutor) driver;
//		js.executeScript("document.style.zoom='50%'");
		String url = ConfigsReader.getProperty("url");
		driver.get(url);

	//	PageInitializer.initialize();
	}

	public static void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}

	public static class BasePage {
		protected WebDriver driver;

		public BasePage(WebDriver driver) {
			this.driver = driver;
		}

		public void waitComs(By locator) {
			WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(Constants.EXPLICIT_WAIT_TIME));
			wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
		}

		public void waitLoader() {
			WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(Constants.LOADER_WAIT_TIME));
			wait.until(ExpectedConditions.invisibilityOfElementLocated(By.className("ols-loader")));
		}

		public void tusaBas(By locator) {
			waitLoader();
			waitComs(locator);
			driver.findElement(locator).click();
		}

		public void yaziYaz(By locator, String text) {
				waitComs(locator);
				driver.findElement(locator).sendKeys(text);
		}
		public void yaziYaz(WebElement element, String text) {
			element.clear();
			element.sendKeys(text);
		}
		public void hedefeScrollYap(By locator) {
			WebElement element = driver.findElement(locator);
			((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView({block:'nearest'});", element);
		}
		public void ekranZoomYap(int yuzde) {
			JavascriptExecutor js = (JavascriptExecutor) driver;
			js.executeScript("document.body.style.zoom='" + yuzde + "%'");
		}
		public void checkboxsec(By locator,By reasonlocator)
		{
			waitComs(locator);
			WebElement checkbox = driver.findElement(locator);
			if (!checkbox.isSelected())
			{
				checkbox.click();
			}
			waitComs(reasonlocator);
			driver.findElement(reasonlocator).click();
		}
		public void checkboxSec2(By locator) {
			WebElement checkbox = driver.findElement(locator);
			if (!checkbox.isSelected()) {
				checkbox.click();
			}
		}
		public void bekle(int saniye) {
			try {
				Thread.sleep(saniye * 1000L);
			} catch (InterruptedException e) {
				throw new RuntimeException(e);
			}
		}
		public void sekmeyeGec(int index) {
			driver.switchTo().window(new ArrayList<>(driver.getWindowHandles()).get(index));
		}
	}
}
