import 'package:ecart/provider/provider_cart.dart';
import 'package:ecart/screens/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CartProductModel> cartList = [];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<Cart>().clear();
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
        ],
      ),
      body: context.watch<Cart>().getItems.isEmpty
          ? const Center(
              child: Text(
                "Empty Cart",
              ),
            )
          : Consumer<Cart>(builder: (context, cart, _) {
              cartList = cart.getItems;
              return ListView.builder(
                itemCount: cart.count,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              child: Image.network(
                                cart.getItems[index].imageUrl,
                              ),
                            ),
                            Flexible(
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cartList[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${cartList[index].price}',
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  cartList[index].qty == 1
                                                      ? cart.delete(
                                                          cart.getItems[index])
                                                      : cart.decrement(
                                                          cart.getItems[index]);
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                ),
                                              ),
                                              Text(cartList[index]
                                                  .qty
                                                  .toString()),
                                              IconButton(
                                                onPressed: () {
                                                  cart.increment(
                                                      cartList[index]);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      bottomSheet: context.watch<Cart>().getItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${context.watch<Cart>().totalPrice}",
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            cart: cartList,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
