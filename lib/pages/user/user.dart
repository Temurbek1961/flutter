import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  var formGlobalKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();
  final _qtyController = TextEditingController();
  var selectedValue;
  var metrics = ['kg', 'ltr', 'gram'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grocessories Memo")),
      body: const Center(child: Text("NO Data")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showForm(BuildContext mContext, var itemKey, var index) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(mContext).viewInsets.bottom, top: 15, right: 15, left: 15),
        child: Form(
          key: formGlobalKey,
          child: Column(
            children: [
              TextFormField(
                maxLines: 1,
                controller: _itemController,
                decoration: const InputDecoration(hintText: "Item Name"),
                validator: (value) {
                  if (value!.isEmpty) return "Requred Field";
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(hintText: "Item Quantity"),
                validator: (value) {
                  if (value!.isEmpty) return "Requred Field";
                  return null;
                },
              ),
              DropdownButtonFormField(
                validator: (newValue) {
                  if (selectedValue == null) return "Metrics  is Required";
                  return null;
                },
                items: metrics.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
