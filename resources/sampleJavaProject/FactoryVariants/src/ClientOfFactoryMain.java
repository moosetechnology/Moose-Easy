import simple_factory.SimpleFactory;

public class ClientOfFactoryMain {

    public static void main(String[] args) {

        static_factory.Product stpA =
                static_factory.Product.createProduct(static_factory.Product.PRODUCT_TYPE.PRODUCT_A);
        simple_factory.IProduct smpA =
                simple_factory.SimpleFactory.createProduct(SimpleFactory.PRODUCT.A);
				
		static_factory.Product stpB;
		simple_factory.IProduct smpB;
		
		stpB = static_factory.Product.createProduct(static_factory.Product.PRODUCT_TYPE.PRODUCT_B);
		smpB = simple_factory.SimpleFactory.createProduct(SimpleFactory.PRODUCT.B);


    }
}
