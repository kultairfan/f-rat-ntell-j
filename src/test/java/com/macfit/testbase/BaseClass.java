package com.macfit.testbase;

import java.time.Duration;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import com.macfit.utils.ConfigsReader;
import com.macfit.utils.Constants;

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

		PageInitializer.initialize();
	}

	public static void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}

}
