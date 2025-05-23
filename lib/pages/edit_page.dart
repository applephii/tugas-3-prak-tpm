import 'package:flutter/material.dart';
import 'package:tugas_3_prak_tpm/models/item_model.dart';
import 'package:tugas_3_prak_tpm/pages/home_page.dart';
import 'package:tugas_3_prak_tpm/sevices/item_api.dart';

class EditPage extends StatefulWidget {
  final int itemId;
  const EditPage({super.key, required this.itemId});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _brand = TextEditingController();
  final TextEditingController _yearReleased = TextEditingController();
  final TextEditingController _rating = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _sold = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _material = TextEditingController();

  bool _isDataLoaded = false;

  Future<void> _updateItem(BuildContext context) async {
    try {
      Item updatedItem = Item(
        name: _name.text.trim(),
        brand: _brand.text.trim(),
        yearReleased: int.parse(_yearReleased.text),
        rating: double.parse(_rating.text),
        price: int.parse(_price.text),
        category: _category.text.trim(),
        sold: int.parse(_sold.text),
        stock: int.parse(_stock.text),
        material: _material.text.trim(),
      );

      final res = await ItemApi.updateItem(updatedItem, widget.itemId);
      if (res["status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Item ${updatedItem.name} updated successfully!"),
          ),
        );
        Navigator.pop(context);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      } else {
        throw Exception(res["message"]);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Item"),
        backgroundColor: Colors.pink[100],
      ),
      body: Padding(padding: const EdgeInsets.all(15), child: _itemEdit()),
    );
  }

  Widget _itemEdit() {
    return FutureBuilder(
      future: ItemApi.getItemById(widget.itemId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData) {
          if (!_isDataLoaded) {
            _isDataLoaded = true;
            Item item = Item.fromJson(snapshot.data!["data"]);
            _name.text = item.name!;
            _brand.text = item.brand!;
            _yearReleased.text = item.yearReleased.toString();
            _rating.text = item.rating.toString();
            _price.text = item.price.toString();
            _category.text = item.category!;
            _sold.text = item.sold.toString();
            _stock.text = item.stock.toString();
            _material.text = item.material!;
          }
          return _editItemForm(context);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _editItemForm(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          Center(
            child: Text(
              "Item Informations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _name,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _brand,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Brand",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _yearReleased,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Year Released",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _rating,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Rating",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _price,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Price",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _category,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Category",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _material,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Material",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _sold,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Sold",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _stock,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Stock",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _updateItem(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[200]),
            child: const Text(
              "Update Item",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
