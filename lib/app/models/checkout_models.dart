class CheckoutContent {
  final String img;
  final String productName;
  final String bakery;
  final String price;
  final String quantity;
  CheckoutContent(
      {required this.img,
      required this.productName,
      required this.bakery,
      required this.price,
      required this.quantity});
}

class Address {
  final String nama;
  final String telpon;
  final String alamat;
  final String kabupaten;

  Address(
      {required this.nama,
      required this.telpon,
      required this.alamat,
      required this.kabupaten});
}
