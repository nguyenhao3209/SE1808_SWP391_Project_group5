/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author CE180220_TranMinhKhanh
 */
public class Constants {
    //gg

    public static String GOOGLE_CLIENT_ID = "306610528753-fh3idh9puib2socq0qe81q5ddf2rbl1t.apps.googleusercontent.com";

    public static String GOOGLE_CLIENT_SECRET = "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";

    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/SP25_SE1808_SWP391_Project_G5/login-gg";

    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    //fb
    public static final String FACEBOOK_CLIENT_ID = "2699429560235648";

    public static final String FACEBOOK_CLIENT_SECRET = "5ed46f3ce1c8d0c08a585e8d26d15b59";

    public static final String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/v19.0/oauth/access_token";

    public static String FACEBOOK_LINK_GET_USER_INFO = "https://graph.facebook.com/me?fields=id,name,email&access_token=";

    public static String FACEBOOK_REDIRECT_URI = "http://localhost:8080/SP25_SE1808_SWP391_Project_G5/login-fb";

}
