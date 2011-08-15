package com.opscode.dbapp.model;

public class Product {
  
  private String name;
  private String code;
  private String msrp;
  
  public Product(){
    
  }
  
  public Product(String name, String code, String msrp) {
    this.name = name;
    this.code = code;
    this.msrp = msrp;
  }
  
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getCode() {
    return code;
  }
  public void setCode(String code) {
    this.code = code;
  }
  public String getMsrp() {
    return msrp;
  }
  public void setMsrp(String msrp) {
    this.msrp = msrp;
  }

}
