/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Models.ProductSizes;
import Models.Products;
import Models.StockImportDetails;
import dal.ProductsDAO;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.math.BigInteger;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@MultipartConfig
public class ReadExcelFileToImportServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("file");
        if (filePart == null || filePart.getSubmittedFileName().isEmpty()) {
            request.setAttribute("error", "No file uploaded!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        File file = new File(uploadPath + File.separator + filePart.getSubmittedFileName());
        filePart.write(file.getAbsolutePath());

        ArrayList<StockImportDetails> productList = new ArrayList<>();
        ProductsDAO proDAO = new ProductsDAO();
        BigDecimal estimatedTotalCost = new BigDecimal(BigInteger.ZERO);
        String supplier = "";
        String personInCharge = "";
        String staffID = "";
        String importID = "";

        try ( FileInputStream fis = new FileInputStream(file);  Workbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (int i = 2; i <= sheet.getLastRowNum() - 5; i++) {
                Row row = sheet.getRow(i);
                if (row == null || row.getCell(0) == null) {
                    continue;
                }

                StockImportDetails product = new StockImportDetails();
                product.setProduct(proDAO.getProductByID(Integer.parseInt(getCellValue(row.getCell(0)).split("\\.")[0])));
                product.setSize(getSizeFromCell(product.getProduct(), row.getCell(2)));
                product.setQuantity((int) getNumericCellValue(row.getCell(3), 0));
                product.setCostPrice(BigDecimal.valueOf(getNumericCellValue(row.getCell(6), 0)));
                estimatedTotalCost = estimatedTotalCost.add(product.getCostPrice().multiply(BigDecimal.valueOf(product.getQuantity())));
                productList.add(product);
            }

            Row importIDRow = sheet.getRow(sheet.getLastRowNum() - 9);
            if (importIDRow != null && importIDRow.getCell(5) != null) {
                importID = getCellValue(importIDRow.getCell(5));
            }

            Row supplierRow = sheet.getRow(sheet.getLastRowNum() - 8);
            if (supplierRow != null && supplierRow.getCell(5) != null) {
                supplier = getCellValue(supplierRow.getCell(5));
            }

            Row personInChargeRow = sheet.getRow(sheet.getLastRowNum() - 7);
            if (personInChargeRow != null && personInChargeRow.getCell(5) != null) {
                personInCharge = getCellValue(personInChargeRow.getCell(5));
            }

            Row staffIDRow = sheet.getRow(sheet.getLastRowNum() - 6);
            if (staffIDRow != null && staffIDRow.getCell(5) != null) {
                staffID = getCellValue(staffIDRow.getCell(5));
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error processing Excel file: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("productList", productList);
        request.setAttribute("estimatedTotalCost", estimatedTotalCost);
        request.setAttribute("importID", importID);
        request.setAttribute("supplier", supplier);
        request.setAttribute("personInCharge", personInCharge);
        request.setAttribute("staffID", staffID);
        request.getRequestDispatcher("admin/stock_import_excel.jsp").forward(request, response);
    }

    private String getCellValue(Cell cell) {
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                }
                return String.valueOf(cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            default:
                return "";
        }
    }

    private double getNumericCellValue(Cell cell, double defaultValue) {
        if (cell == null) {
            return defaultValue;
        }
        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
            try {
                return Double.parseDouble(cell.getStringCellValue().trim());
            } catch (NumberFormatException e) {
                return defaultValue;
            }
            default:
                return defaultValue;
        }
    }

    private ProductSizes getSizeFromCell(Products products, Cell cell) {
        ProductsDAO proDAO = new ProductsDAO();
        if (cell == null || cell.getCellType() != CellType.STRING) {
            return null;
        }
        String sizeValue = cell.getStringCellValue().trim();
        if (sizeValue.equalsIgnoreCase("N/A") || sizeValue.isEmpty()) {
            return null;
        }
        try {
            return proDAO.getSize(products.getProductID(), sizeValue);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
