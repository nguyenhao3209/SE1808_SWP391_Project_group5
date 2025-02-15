/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Models.Customers;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import utils.Constants;
import utils.MailService;
import utils.PasswordUtils;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
@WebServlet(name="LoginWithGoogle", urlPatterns={"/login-gg"})
public class LoginWithGoogle extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            response.setContentType("text/html;charset=UTF-8");
            String code = request.getParameter("code");
            String accessToken = getToken(code);
            Customers user = getUserInfo(accessToken);

            CustomersDAO udao = new CustomersDAO();

            if (accessToken == null) {
                response.getWriter().write("Failed to get access token from Google.");
                return;
            }

            HttpSession session = request.getSession();
            Customers userInDB = udao.getUserByEmail(user.getEmail());

            if (userInDB != null) {
                // Nếu tài khoản đã tồn tại, đăng nhập vào hệ thống
                session.setAttribute("user", userInDB);
            } else {
                // Nếu tài khoản chưa tồn tại, tạo tài khoản mới và đăng ký
                String password = PasswordUtils.generateSimplePassword(8); // Sinh mật khẩu ngẫu nhiên dài 8 ký tự
                user.setPassword(PasswordUtils.hashPassword(password));
                user.setRole(Customers.Role.USER);
                user.setStatus(Customers.Status.ACTIVE);
                udao.registerUser(user);

                // Gửi mật khẩu đến email người dùng
                MailService.sendMail(user.getEmail(), "Password!", "Your password is: " + password);

                session.setAttribute("user", user);
            }

            response.sendRedirect("home.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Login fail");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // Call API to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE)
                        .build())
                .execute()
                .returnContent()
                .asString();

        System.out.println("Google token response: " + response);  // Log the full response for debugging

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        // Check if the response contains an error
        if (jobj.has("error")) {
            String errorDescription = jobj.get("error_description").getAsString();
            throw new IOException("Error retrieving token: " + errorDescription);
        }

        // Parse access token
        String accessToken = jobj.get("access_token").getAsString();
        return accessToken;
    }

    public static Customers getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        Customers s = new Customers(jobj.get("name").getAsString(), jobj.get("email").getAsString());
        return s;
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
