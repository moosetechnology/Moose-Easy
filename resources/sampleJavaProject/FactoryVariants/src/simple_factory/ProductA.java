package simple_factory;

class ProductA implements IProduct, MarkerA {
    private ProductA() {}
    /* funny constructor */
    public ProductA(int i) {
        System.out.println("i=" + i);
    }

    @Override
    public void m1() {

    }

}
