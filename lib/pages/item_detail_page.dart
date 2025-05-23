import 'package:flutter/material.dart';
import 'package:tugas_3_prak_tpm/models/item_model.dart';
import 'package:tugas_3_prak_tpm/pages/edit_page.dart';
import 'package:tugas_3_prak_tpm/pages/home_page.dart';
import 'package:tugas_3_prak_tpm/sevices/item_api.dart';

class ItemDetailPage extends StatefulWidget {
  final int itemId;
  const ItemDetailPage({super.key, required this.itemId});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Detail"),
        backgroundColor: Colors.pink[100],
      ),
      body: Padding(padding: EdgeInsets.all(15), child: _itemDetailContainer()),
    );
  }

  Widget _itemDetailContainer() {
    return FutureBuilder(
      future: ItemApi.getItemById(widget.itemId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData) {
          Item item = Item.fromJson(snapshot.data!["data"]);
          return _itemDetail(context, item);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _itemDetail(BuildContext context, Item item) {
    return Center(
      child: Column(
        children: [
          Text(
            "${item.name!} by ${item.brand}",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 3),
          Text("(${item.yearReleased})", style: TextStyle(fontSize: 18)),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${item.rating ?? 'N/A'}", style: TextStyle(fontSize: 18)),
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Colors.pink, size: 16),
              Text(" | ${item.price} USD", style: TextStyle(fontSize: 18)),
            ],
          ),

          SizedBox(height: 15),
          Text("Category: ${item.category}", style: TextStyle(fontSize: 18)),
          Text("Material: ${item.material}", style: TextStyle(fontSize: 18)),
          Text("Sold: ${item.sold}", style: TextStyle(fontSize: 18)),
          Text("Stock: ${item.stock}", style: TextStyle(fontSize: 18)),

          const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditPage(itemId: item.id!),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Text("Edit"),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        _deleteItem(item.id!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Text("Delete"),
                    ),
                  ],
                ),

        ],
      ),
    );
  }

  void _deleteItem(int id) async {
    try {
      final res = await ItemApi.deleteItem(id);
      if (res["status"] == "Success") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Item deleted successfully!")));
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
      ).showSnackBar(SnackBar(content: Text("Gagal: $e")));
    }
  }
}
