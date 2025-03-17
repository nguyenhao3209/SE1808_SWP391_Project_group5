/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import Models.Customers;
import Models.Staffs;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author HAO
 */
public class Authentication implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    
    public Authentication() {
    }
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AutificationFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AutificationFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        Object user = (session != null) ? session.getAttribute("user") : null;
        String uri = req.getRequestURI();

        // Mảng URI dành riêng cho admin
        String[] adminURIs = {"viewImported", "viewImportedDetails", "addStaff", "editStaff", "deleteStaff", "viewImported"};
        // Mảng URI dành riêng cho staff
        String[] staffURIs = {"VoucherServlet", "importStock", "CategoryServlet", "stockImport", "viewStockProducts",
            "addProduct", "editProduct", "deleteProduct", "dashboard", "CustomerProfile",
            "CustomerOrders", "contact-list", "contact-detail", "CustomerOrders",
            "listProducts", "OrdersServlet", "add-news", "news-management", "update-news", "delete-news", "profileStaff.jsp"};
        if (uri.contains("img") || uri.contains("css") || uri.contains("common") || uri.contains("icomoon") || uri.contains("js") || uri.contains("resources") || uri.contains("assets")) {
            chain.doFilter(request, response);
            return;
        }
        // Nếu người dùng chưa đăng nhập
        if (user == null) {
            // Nếu yêu cầu truy cập trang không phải là trang đăng nhập, đăng ký, hoặc trang chủ
            if (!uri.endsWith("login") && !uri.endsWith("register") && !uri.endsWith("home") && !uri.contains("news-list") && !uri.endsWith("ViewVouchersServlet") && !uri.endsWith("forget-password.jsp") && !uri.endsWith("forgotPassword") && !uri.endsWith("searchServlet") && !uri.contains("productDetails") && !uri.endsWith("ProductFilterServlet") && !uri.endsWith("filter-feedback")) {
                res.sendRedirect("login");
                return;
            }
        } else if (user instanceof Staffs) {
            // Nếu là nhân viên nhưng truy cập tài nguyên của admin
            for (String adminURI : adminURIs) {
                if (uri.contains(adminURI) && ((Staffs) user).getRole().equals("STAFF")) {
                    res.sendRedirect("contact-list");
                    return;
                }
            }
        } else if (user instanceof Customers) {
            // Nếu là khách hàng nhưng truy cập tài nguyên của nhân viên hoặc admin
            for (String staffURI : staffURIs) {
                if (uri.contains(staffURI)) {
                    res.sendRedirect("home");
                    return;
                }
            }
            for (String adminURI : adminURIs) {
                if (uri.contains(adminURI)) {
                    res.sendRedirect("home");
                    return;
                }
            }
        }

        // Nếu tất cả kiểm tra đều hợp lệ, tiếp tục xử lý yêu cầu
        chain.doFilter(request, response);
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AutificationFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AutificationFilter()");
        }
        StringBuffer sb = new StringBuffer("AutificationFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
    
    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
    
}
