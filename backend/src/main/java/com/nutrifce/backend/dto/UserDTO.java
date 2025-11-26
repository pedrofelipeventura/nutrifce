package com.nutrifce.backend.dto;

public class UserDTO {
    private String name;
    private int age;
    private double height;
    private double weight;
    private String gender;

    private String restricaoAlimentar;  // 🆕
    private String objetivoDieta;       // 🆕

    public UserDTO() {}

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public double getHeight() { return height; }
    public void setHeight(double height) { this.height = height; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getRestricaoAlimentar() { return restricaoAlimentar; }
    public void setRestricaoAlimentar(String restricaoAlimentar) {
        this.restricaoAlimentar = restricaoAlimentar;
    }

    public String getObjetivoDieta() { return objetivoDieta; }
    public void setObjetivoDieta(String objetivoDieta) {
        this.objetivoDieta = objetivoDieta;
    }
}
