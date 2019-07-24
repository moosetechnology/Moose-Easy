import simple_factory.IProduct;

public class ClientWithUnprotected {

    public static void main(String[] args) {

        IProduct productA = new no_factory.ProductA(1, 2);
    }
}
