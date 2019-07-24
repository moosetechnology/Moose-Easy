import no_factory.*;
import simple_factory.IProduct;

public class ClientNoFactoryMain {

    public static void main(String[] args) {

        IProduct productA = new ProductA(1, 2);
        IProduct productB = new ProductB();
        IProduct productC = new ProductC();
    }
}
