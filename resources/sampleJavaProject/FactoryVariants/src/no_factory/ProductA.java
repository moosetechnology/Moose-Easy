package no_factory;

import simple_factory.IProduct;

public class ProductA implements IProduct {
    private ProductA() {}
    /* funny constructor */
    public ProductA(float i, int j) {
        System.out.println("i=" + i + " and j=" + j);
    }

    @Override
    public void m1() {

    }
}
