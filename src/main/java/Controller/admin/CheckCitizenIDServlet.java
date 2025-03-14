/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import dal.StaffsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Haontce180451
 */
public class CheckCitizenIDServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckCitizenIDServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckCitizenIDServlet at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String citizenID = request.getParameter("citizenID");
        String staffID = request.getParameter("staffID");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            StaffsDAO staffDAO = new StaffsDAO();
            boolean exists = staffDAO.checkCitizenIDExists(citizenID, staffID);

            // Kiểm tra Citizen ID đã tồn tại
            if (exists) {
                out.print("{\"status\": \"exists\"}");
                return;
            }

            // Kiểm tra độ dài và định dạng
            if (citizenID == null || !citizenID.matches("\\d{12}")) {
                out.print("{\"status\": \"invalid\"}");
                return;
            }

          
            // Lấy mã tỉnh từ 2 chữ số kế tiếp
            String provinceCode = citizenID.substring(1, 3);
            String address = getProvinceName(provinceCode);

            // Tạo chuỗi JSON phản hồi
            String jsonResponse = String.format("{\"status\": \"not_exists\", \"address\": \"%s\"}", address);
            out.print(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\": \"error\"}");
        } finally {
            out.close();
        }
    }

    private String getProvinceName(String provinceCode) {
        switch (provinceCode) {
            case "01":
                return "Hà Nội";
            case "02":
                return "Hà Giang";
            case "04":
                return "Cao Bằng";
            case "06":
                return "Bắc Kạn";
            case "08":
                return "Tuyên Quang";
            case "10":
                return "Lào Cai";
            case "11":
                return "Điện Biên";
            case "12":
                return "Lai Châu";
            case "14":
                return "Sơn La";
            case "15":
                return "Yên Bái";
            case "17":
                return "Hòa Bình";
            case "19":
                return "Thái Nguyên";
            case "20":
                return "Lạng Sơn";
            case "22":
                return "Quảng Ninh";
            case "24":
                return "Bắc Giang";
            case "25":
                return "Phú Thọ";
            case "26":
                return "Vĩnh Phúc";
            case "27":
                return "Bắc Ninh";
            case "30":
                return "Hải Dương";
            case "31":
                return "Hải Phòng";
            case "33":
                return "Hưng Yên";
            case "34":
                return "Thái Bình";
            case "35":
                return "Hà Nam";
            case "36":
                return "Nam Định";
            case "37":
                return "Ninh Bình";
            case "38":
                return "Thanh Hóa";
            case "40":
                return "Nghệ An";
            case "42":
                return "Hà Tĩnh";
            case "44":
                return "Quảng Bình";
            case "45":
                return "Quảng Trị";
            case "46":
                return "Thừa Thiên Huế";
            case "48":
                return "Đà Nẵng";
            case "49":
                return "Quảng Nam";
            case "51":
                return "Quảng Ngãi";
            case "52":
                return "Bình Định";
            case "54":
                return "Phú Yên";
            case "56":
                return "Khánh Hòa";
            case "58":
                return "Ninh Thuận";
            case "60":
                return "Bình Thuận";
            case "62":
                return "Kon Tum";
            case "64":
                return "Gia Lai";
            case "66":
                return "Đắk Lắk";
            case "67":
                return "Đắk Nông";
            case "68":
                return "Lâm Đồng";
            case "70":
                return "Bình Phước";
            case "72":
                return "Tây Ninh";
            case "74":
                return "Bình Dương";
            case "75":
                return "Đồng Nai";
            case "77":
                return "Bà Rịa - Vũng Tàu";
            case "79":
                return "Hồ Chí Minh";
            case "80":
                return "Long An";
            case "82":
                return "Tiền Giang";
            case "83":
                return "Bến Tre";
            case "84":
                return "Trà Vinh";
            case "86":
                return "Vĩnh Long";
            case "87":
                return "Đồng Tháp";
            case "89":
                return "An Giang";
            case "91":
                return "Kiên Giang";
            case "92":
                return "Cần Thơ";
            case "93":
                return "Hậu Giang";
            case "94":
                return "Sóc Trăng";
            case "95":
                return "Bạc Liêu";
            case "96":
                return "Cà Mau";
            default:
                return "Unknown Province";
        }
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
