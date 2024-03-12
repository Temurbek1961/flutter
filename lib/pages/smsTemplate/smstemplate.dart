import 'dart:convert';
import 'package:firstapp/pages/smsTemplate/add_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SmsTemplate extends StatefulWidget {
  const SmsTemplate({super.key});
  @override
  State<SmsTemplate> createState() => _SmsTemplate();
  }

  class _SmsTemplate extends State<SmsTemplate>{
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
        appBar: AppBar(title: Text('SmS Template')),
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
                    trailing: PopupMenuButton(
                      onSelected: (value){
                        if(value == 'edit'){
                          //Open edit page
                          navigateToEditPage(item);
                        } else if (value == 'delete'){
                          //delete value
                          deleteById(id);
                        }
                      },
                      itemBuilder: (context){
                        return [
                          PopupMenuItem(
                              child: Text('Edit'),
                              value: 'edit',
                          ),
                          PopupMenuItem(
                              child: Text('Delete'),
                              value: 'Delete',
                          ),
                        ];
                      },
                    ),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => navigateToAddPage(context),
          label: Text('Add Todo'),
        ),
      );
  }
// add page
  Future<void> navigateToAddPage(BuildContext context) async{
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
  await Navigator.push(context, route);
  setState(() {
    isLoading = false;
  });
  fetchTodo();
  }
  //edit page
    Future<void>  navigateToEditPage(Map item) async{
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();

  }

  //delete item
  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if(response.statusCode == 200){
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }else {
      showErrorMessage('Deletion Failed');
    }
  }

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
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
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
