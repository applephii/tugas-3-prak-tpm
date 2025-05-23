import 'package:flutter/material.dart';
import 'package:tugas_3_prak_tpm/models/item_model.dart';
import 'package:tugas_3_prak_tpm/pages/home_page.dart';
import 'package:tugas_3_prak_tpm/sevices/item_api.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _name = TextEditingController();
  final _brand = TextEditingController();
  final _yearReleased = TextEditingController();
  final _rating = TextEditingController();
  final _price = TextEditingController();
  final _category = TextEditingController();
  final _sold = TextEditingController();
  final _stock = TextEditingController();
  final _material = TextEditingController();

  Future<void> _createItem(BuildContext context) async {
    try {
      Item newItem = Item(
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

      final res = await ItemApi.createItem(newItem);

      if (res["status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Item ${newItem.name} created successfully!")),
        );
        Navigator.pop(context);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      } else {
        throw Exception(res["message"]);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Item"),
        backgroundColor: Colors.pink[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: _createItemForm(),
      ),
    );
  }

  Widget _createItemForm() {
    return Form(
      child: ListView(
        children: [
          Center(child: Text("New Item Informations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
          SizedBox(height: 10),
          TextFormField(
            controller: _name,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _brand,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(labelText: "Brand", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _yearReleased,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Year Released", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _rating,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Rating (From 0 to 5)", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _price,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Price", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _category,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _material,
            style: TextStyle(fontSize: 18),
            decoration: const InputDecoration(labelText: "Material", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _sold,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Sold", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _stock,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Stock", border: OutlineInputBorder(),),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _createItem(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[200]),
            child: const Text("Create Item", style: TextStyle(color: Colors.white, fontSize: 16),),
          ),
        ],
      ),
    );
  }
}
