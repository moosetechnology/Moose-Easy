import no_factory.ProductA;
import simple_factory.IProduct;


public class NoInterfaceClient {

    public static void main(String[] args) {

        ProductA productA = new ProductA(1, 2);
    }
}
