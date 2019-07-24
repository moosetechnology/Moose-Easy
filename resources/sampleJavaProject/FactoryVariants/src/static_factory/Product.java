package static_factory;

public abstract class Product {

    public enum PRODUCT_TYPE{PRODUCT_A, PRODUCT_B, PRODUCT_C};

    public static Product createProduct(PRODUCT_TYPE productType) {
        Product product;
        if (productType.equals(PRODUCT_TYPE.PRODUCT_A)) {
            product = new ProductA();
        } else if (productType.equals(PRODUCT_TYPE.PRODUCT_B)) {
            product = new ProductB();
        } else if (productType.equals(PRODUCT_TYPE.PRODUCT_C)) {
            product = new ProductC();
        } else {
            // error in if conditions above...
            product = null;
        }
        return product;
    }
}
