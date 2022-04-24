class CartItems {
  String name;
  int quantity;
  int amount;
  CartItems({this.name, this.amount, this.quantity});
}

class DataListBuilder {
  List<CartItems> itemList = <CartItems>[];

  CartItems item1 = new CartItems(name: 'Idli Vada', quantity: 2, amount: 130);
  CartItems item2 = new CartItems(name: 'Sweet Corn', quantity: 1, amount: 60);
  CartItems item3 =
      new CartItems(name: 'Ragi Masala Dosa', quantity: 1, amount: 75);
  CartItems item4 = new CartItems(name: 'Pakora', quantity: 1, amount: 35);
  CartItems item5 =
      new CartItems(name: 'Baby Corn Chilli', quantity: 1, amount: 145);
  DataListBuilder() {
    itemList.add(item1);
    itemList.add(item2);
    itemList.add(item3);
    itemList.add(item4);
    itemList.add(item5);
  }
}
