/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

/**
 *
 * @author HaoNTCE180451
 */
public class Specifications {
    private int specificationID;
    private int productID;
    private String key;
    private String value;

    public Specifications() {
    }

    public Specifications(int specificationID, int productID, String key, String value) {
        this.specificationID = specificationID;
        this.productID = productID;
        this.key = key;
        this.value = value;
    }

    public int getSpecificationID() {
        return specificationID;
    }

    public void setSpecificationID(int specificationID) {
        this.specificationID = specificationID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    
    
}
