import 'package:bakery_store/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakery_store/models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Produk'),
        backgroundColor: const Color.fromARGB(255, 244, 244, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddProductDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 204, 194, 108),
              ),
              child: const Text('Tambah Produk'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (productProvider.errorMessage.isNotEmpty) {
                    return Center(child: Text(productProvider.errorMessage));
                  }

                  return ListView.builder(
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) {
                      final product = productProvider.products[index];
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditProductDialog(context, product);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  productProvider.deleteProduct(product.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Produk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                final product = Product(
                  id: DateTime.now().millisecondsSinceEpoch,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );
                Provider.of<ProductProvider>(context, listen: false)
                    .addProduct(product);
                Navigator.of(context).pop();
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    final nameController = TextEditingController(text: product.name);
    final descriptionController =
        TextEditingController(text: product.description);
    final priceController =
        TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Produk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                final updatedProduct = Product(
                  id: product.id,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );
                Provider.of<ProductProvider>(context, listen: false)
                    .updateProduct(updatedProduct);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
