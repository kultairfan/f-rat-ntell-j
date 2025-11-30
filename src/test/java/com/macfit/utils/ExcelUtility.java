package com.macfit.utils;

import java.io.FileInputStream;
import java.io.IOException;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtility {
	
	private static Workbook book;
	private static Sheet sheet;
	
	/**
	 * This method initializes a Workbook object given the filePath.
	 * 
	 * @param filePath
	 */
	private static void openExcel(String filePath)
	{
		try 
		{
			FileInputStream fis = new FileInputStream(filePath);
			book = new XSSFWorkbook(fis);
		} 
		catch (IOException e) 
		{
				e.printStackTrace();
		}
			
	}
	
	/**
	 * This method loads a sheet given the sheetName.
	 * @param sheetName
	 */
	private static void loadSheet(String sheetName)
	{
		sheet = book.getSheet(sheetName);
	}
	
	/**
	 * This method returns the row count of the current sheet.
	 * @return
	 */
	private static int rowCount()
	{
		return sheet.getPhysicalNumberOfRows();
	}
	
	/**
	 * This method returns the column count for a given row index in the current sheet.
	 * @param rowIndex
	 * @return
	 */
	private static int colCount(int rowIndex)
	{
		return sheet.getRow(rowIndex).getLastCellNum();
	}
	
	/**
	 * This method returns the cell data as a String given the row and column indexes.
	 * @param rowIndex
	 * @param colIndex
	 * @return
	 */
	private static String cellData(int rowIndex, int colIndex)
	{
		return sheet.getRow(rowIndex).getCell(colIndex).toString();
	}
	
	public static Object[][] excelIntoArray(String filePath, String sheetName)
	{
		
		// open the file: filePath
		openExcel(filePath);
		
		// load the sheet: sheetName
		loadSheet(sheetName);
		
		// get the number of rows
		int rowNumber = rowCount();
		
		// get the number of columns 
		int columnNumber = colCount(0);
		
		
		
		Object[][] data = new Object[rowNumber - 1][columnNumber];
		
		//nested loop to iterate over all cells and get the data from them
		for (int row = 1; row < rowNumber; row++) //for each row except the header
		{
			for (int col = 0; col < columnNumber; col++) 
			{
				data[row - 1][col] = cellData(row, col);
			}
		}
		
		return data;
	}

}
