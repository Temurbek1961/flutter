import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingList extends StatefulWidget {
  const SettingList({super.key});
  @override
  State<SettingList> createState() => _SettingList();
}

class _SettingList extends State<SettingList>{
  bool isLoading =  true;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }
  @override
  // TODO: implement widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                final item = items[index] as Map;
                final id = item['_id'] as String;
                return ListTile(
                  leading: CircleAvatar(child: Text('${index+1}')),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),

                );
              }),
        ),
      ),

    );
  }
// add page


  void showErrorMessage(String message){
    final snackBar = SnackBar(content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//get list
  Future<void> fetchTodo() async{
    setState(() {
      isLoading = false;
    });
    const url = 'https://api.dostonbarber.uz/api/settings/index';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as Map;
      final result  = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
