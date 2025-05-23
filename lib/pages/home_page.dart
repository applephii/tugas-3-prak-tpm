import 'package:flutter/material.dart';
import 'package:tugas_3_prak_tpm/models/item_model.dart';
import 'package:tugas_3_prak_tpm/pages/create_page.dart';
import 'package:tugas_3_prak_tpm/pages/edit_page.dart';
import 'package:tugas_3_prak_tpm/pages/item_detail_page.dart';
import 'package:tugas_3_prak_tpm/sevices/item_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("022 Fashion Store"),
        backgroundColor: Colors.pink[100],
      ),
      body: Padding(padding: EdgeInsets.all(15), child: _itemContainer()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create Page
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => CreatePage()));
        },
        backgroundColor: Colors.pink[200],
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemContainer() {
    return FutureBuilder(
      future: ItemApi.getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData) {
          ItemModel res = ItemModel.fromJson(snapshot.data!);
          return _itemList(context, res.data!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _itemList(BuildContext context, List<Item> items) {
    // Tampilkan data ke dalam Grid
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: Colors.pink[50],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category ?? "No Category",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  item.name ?? "No Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Row(
                  children: [
                    Text(
                      "${item.rating ?? 'N/A'}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Colors.pink, size: 16),
                  ],
                ),

                Text("${item.price} USD", style: TextStyle(fontSize: 20)),

                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(itemId: item.id!),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100],
                  ),
                  child: const Text("More"),
                ),
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
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Icon(Icons.edit, color: Colors.pink[200]),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        _deleteItem(item.id!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteItem(int id) async {
    try {
      final res = await ItemApi.deleteItem(id);
      if (res["status"] == "Success") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Item deleted successfully!")));
        setState(() {});
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
