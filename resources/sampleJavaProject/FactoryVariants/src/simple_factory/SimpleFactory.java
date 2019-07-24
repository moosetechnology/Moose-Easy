package simple_factory;

public class SimpleFactory {
    public enum PRODUCT{A,B,C}
    public static IProduct createProduct(PRODUCT type) {
        IProduct product;
        switch (type) {
            case A:
                product = new ProductA(2);
                break;
            case B:
                product = new ProductB();
                break;
            case C:
                product = new ProductC();
                break;
            default:
                product = null;
        }
        return product;
    }
}
