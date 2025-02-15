/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

/**
 *
 * @author HaoNTCE180451
 */
public class Slider {
    private int sliderID;
    private Products product;
    private String imageURL;

    public Slider() {
    }

    public Slider(int sliderID, Products product, String imageURL) {
        this.sliderID = sliderID;
        this.product = product;
        this.imageURL = imageURL;
    }

    public int getSliderID() {
        return sliderID;
    }

    public void setSliderID(int sliderID) {
        this.sliderID = sliderID;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
