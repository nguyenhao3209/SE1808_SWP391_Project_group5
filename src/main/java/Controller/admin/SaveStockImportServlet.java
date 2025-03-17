/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Models.ProductSizes;
import dal.ProductsDAO;
import dal.StaffsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.Arrays;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Haontce180451
 */
public class SaveStockImportServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SaveStockImportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaveStockImportServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action"); // Lấy giá trị của nút bấm
        String staffID = request.getParameter("staffId");
        String supplier = request.getParameter("supplier");
        String totalCost = request.getParameter("totalCost");
        BigDecimal totalCostValue = BigDecimal.ZERO;
        if (totalCost != null && !totalCost.isEmpty()) {
            totalCostValue = new BigDecimal(totalCost.trim());
        }
        String[] productIDs = request.getParameterValues("productIDs[]");
        String[] productNames = request.getParameterValues("productNames[]");
        String[] quantities = request.getParameterValues("quantities[]");
        String[] size = request.getParameterValues("size[]");
        String[] prices = request.getParameterValues("prices[]");
        ProductsDAO productDAO = new ProductsDAO();
        if ("saveNow".equals(action)) {
            productDAO.addImportStock(staffID, supplier, totalCostValue, "Completed", productIDs, quantities, size, prices);
            response.sendRedirect("admin/stock_import.jsp");
        } else {
            if (productIDs != null && productIDs.length != 0) {
                int importedID = productDAO.addImportStock(staffID, supplier, totalCostValue, "Pedding", productIDs, quantities, size, prices);
                exportToExcel(response, staffID, supplier, totalCostValue, productIDs, productNames, quantities, size, prices, importedID);
                response.sendRedirect("admin/stock_import.jsp");
            } else {
                exportFormToExcel(response);
                response.sendRedirect("admin/stock_import.jsp");
            }
        }

    }

    private void exportToExcel(HttpServletResponse response, String staffID, String supplier, BigDecimal totalCost,
            String[] productIDs, String[] productNames, String[] quantities,
            String[] size, String[] prices, int importedID) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Stock Import");

        // Title styling
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 14);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);

        // Merge title
        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("Stock Import Report");
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));

        // Column headers
        Row headerRow = sheet.createRow(1);
        String[] columns = {"Product ID", "Product Name", "Size", "Quantity", "Estimated Price",
            "Estimated Total Price", "Actual Price", "Actual Total Price"};

        CellStyle headerStyle = createHeaderCellStyle(workbook);
        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerStyle);
        }

        ProductsDAO proDAO = new ProductsDAO();
        StaffsDAO staffDAO = new StaffsDAO();
        ProductSizes proSize = null;

        // Writing data into the Excel file
        for (int i = 0; i < productIDs.length; i++) {
            Row row = sheet.createRow(i + 2); // Start from row 2
            row.createCell(0).setCellValue(productIDs[i]);
            row.createCell(1).setCellValue(productNames != null && i < productNames.length ? productNames[i] : "");

            if (size[i] != null && !size[i].isEmpty()) {
                proSize = proDAO.getProductSizeByID(Integer.parseInt(size[i]));
                row.createCell(2).setCellValue(proSize != null ? proSize.getSize() : "N/A");
            } else {
                row.createCell(2).setCellValue("N/A");
            }

            row.createCell(3).setCellValue(quantities != null && i < quantities.length ? quantities[i] : "0");

            row.createCell(4).setCellValue(prices != null && i < prices.length ? prices[i] : "0.00");
            BigDecimal totalPrice = new BigDecimal(prices[i]);
            BigDecimal quantity = new BigDecimal(quantities[i]);
            row.createCell(5).setCellValue(totalPrice.multiply(quantity).toString());

            row.createCell(6).setCellValue("0.00");
            row.createCell(7).setCellValue("0.00");
        }

        // Summary Section
        int lastRow = productIDs.length + 5;
        sheet.createRow(lastRow).createCell(4).setCellValue("Estimated Total Cost:");
        sheet.getRow(lastRow).createCell(5).setCellValue(totalCost.toString());

        sheet.createRow(lastRow + 1).createCell(4).setCellValue("Import ID:");
        sheet.getRow(lastRow + 1).createCell(5).setCellValue(importedID);

        sheet.createRow(lastRow + 2).createCell(4).setCellValue("Supplier:");
        sheet.getRow(lastRow + 2).createCell(5).setCellValue(supplier);

        sheet.createRow(lastRow + 3).createCell(4).setCellValue("Person in charge:");
        sheet.getRow(lastRow + 3).createCell(5).setCellValue(staffDAO.getStaffByID(staffID).getStaffName());

        sheet.createRow(lastRow + 4).createCell(4).setCellValue("Staff ID:");
        sheet.getRow(lastRow + 4).createCell(5).setCellValue(staffDAO.getStaffByID(staffID).getStaffID());

        // Notes Section
        int notesRowStart = lastRow + 6;
        Row notesTitleRow = sheet.createRow(notesRowStart);
        Cell notesTitleCell = notesTitleRow.createCell(0);
        notesTitleCell.setCellValue("⚠ Important Notes:");
        notesTitleCell.setCellStyle(headerStyle);

        String[] notes = {
            "1. New products can be added but must have a valid Product ID.",
            "2. The actual price must be updated before adding data to the inventory.",
            "3. Ensure Product ID and Size (if applicable) are entered as text format.",
            "4. Follow the correct form while entering data.",
            "5. In the case of a new order, leave the 'Import ID' blank."
        };

        for (int i = 0; i < notes.length; i++) {
            sheet.createRow(notesRowStart + i + 1).createCell(0).setCellValue(notes[i]);
        }

        // Auto-size columns
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Export the file
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=StockImport.xlsx");
        OutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }

    private void exportFormToExcel(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Stock Import Form");

        // Title styling
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 14);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);

        // Merge title
        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("Stock Import Report (Form Only)");
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));

        // Column headers
        Row headerRow = sheet.createRow(1);
        String[] columns = {"Product ID", "Product Name", "Size", "Quantity", "Estimated Price",
            "Estimated Total Price", "Actual Price", "Actual Total Price"};

        CellStyle headerStyle = createHeaderCellStyle(workbook);
        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerStyle);
        }

        // Summary Section (empty)
        int lastRow = 5;
        sheet.createRow(lastRow).createCell(4).setCellValue("Estimated Total Cost:");
        sheet.getRow(lastRow).createCell(5).setCellValue("0.00");

        sheet.createRow(lastRow + 1).createCell(4).setCellValue("Import ID:");
        sheet.getRow(lastRow + 1).createCell(5).setCellValue("");

        sheet.createRow(lastRow + 2).createCell(4).setCellValue("Supplier:");
        sheet.getRow(lastRow + 2).createCell(5).setCellValue("N/A");

        sheet.createRow(lastRow + 3).createCell(4).setCellValue("Person in charge:");
        sheet.getRow(lastRow + 3).createCell(5).setCellValue("N/A");

        sheet.createRow(lastRow + 4).createCell(4).setCellValue("Staff ID:");
        sheet.getRow(lastRow + 4).createCell(5).setCellValue("N/A");

        // Notes Section
        int notesRowStart = lastRow + 6;
        Row notesTitleRow = sheet.createRow(notesRowStart);
        Cell notesTitleCell = notesTitleRow.createCell(0);
        notesTitleCell.setCellValue("⚠ Important Notes:");
        notesTitleCell.setCellStyle(headerStyle);

        String[] notes = {
            "1. New products can be added but must have a valid Product ID.",
            "2. The actual price must be updated before adding data to the inventory.",
            "3. Ensure Product ID and Size (if applicable) are entered as text format.",
            "4. Follow the correct form while entering data.",
            "5. In the case of a new order, leave the 'Import ID' blank."
        };

        for (int i = 0; i < notes.length; i++) {
            sheet.createRow(notesRowStart + i + 1).createCell(0).setCellValue(notes[i]);
        }

        // Auto-size columns
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Export the file
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=StockImportForm.xlsx");
        OutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }

// Tạo style cho tiêu đề cột
    private CellStyle createHeaderCellStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 12);
        style.setFont(font);
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        return style;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
