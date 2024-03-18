import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firstapp/core/constants/api_values.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/pages/user/add_edit_user_screen.dart';
import 'package:firstapp/widgets/user_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
StreamController<bool> loadingController = StreamController<bool>();

class UserList extends StatefulWidget {
  /// Creates the home page.
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List<UserModel>> fetchUsers() async {
    var headers = {'Authorization': 'Bearer ${ApiValues.API_KEY_VALUE['value']}'};
    final response = await http.get(
      Uri.parse(ApiValues.baseURL + ApiValues.userList),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List data = body['data'];
          return data.map((json) {
          return UserModel.fromJson(json);
        }).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e.toString() + 'error');
      return [];
    }
  }

  late UserDataSource userDatSource;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: ScreenUtil.defaultSize.height,
          child: FutureBuilder(
              future: fetchUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserModel> user = snapshot.data!;
                  userDatSource = UserDataSource(user: user);
                  return SfDataGrid(
                    allowSwiping: true,
                    startSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            Platform.isIOS
                                ? CupertinoPageRoute(
                                    builder: (_) => AddUserScreen(
                                      id: user[rowIndex].id,
                                      user: user[rowIndex],
                                    ),
                                  )
                                : MaterialPageRoute(
                                    builder: (_) => AddUserScreen(
                                      id: user[rowIndex].id,
                                    ),
                                  ),
                          );
                          setState(() {});
                        },
                        child: Container(
                          color: Colors.yellowAccent,
                          child: const Center(
                            child: Icon(Icons.edit),
                          ),
                        ),
                      );
                    },
                    endSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Platform.isIOS
                                  ? CupertinoAlertDialog(
                                      title: const Text('Are you sure?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              userDatSource.dataGridRows.removeAt(rowIndex);
                                              userDatSource.updateDataGridSource();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Yes')),
                                      ],
                                    )
                                  : AlertDialog(
                                      icon: const Icon(Icons.warning),
                                      title: const Text('Are you sure?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            userDatSource.dataGridRows.removeAt(rowIndex);
                                            userDatSource.updateDataGridSource();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                            },
                          );
                        },
                        child: Container(
                          color: Colors.redAccent,
                          child: const Center(
                            child: Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
                    source: userDatSource,
                    columnWidthMode: ColumnWidthMode.auto,
                    allowPullToRefresh: true,
                    allowSorting: true,
                    allowFiltering: true,
                    shrinkWrapRows: true,
                    columns: <GridColumn>[
                      GridColumn(
                        columnName: 'firstName',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'First Name',
                            softWrap: true,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'lastName',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Last Name',
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'phone',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Phone',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'lang',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text('Lang'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'periodDay',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Period Day',
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ndybf',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Ndybf',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'timeZone',
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Time Zone',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () => Navigator.push(
          context,
          Platform.isIOS
              ? CupertinoPageRoute(
                  builder: (_) => const AddUserScreen(),
                )
              : MaterialPageRoute(
                  builder: (_) => const AddUserScreen(),
                ),
        ),
      ),
    );
  }

  Future<void> _deleteData(String id, List<UserModel> user) async {
    const url = 'https://api.dostonbarber.uz/api/user/delete';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      //   Remove item factory _AddUserScreenState.fromJson(Map<String, dynamic> json) => _$_AddUserScreenStateFromJson(json);list
      final removedList = user.removeWhere((element) => element.id == id);
      setState(() {});
      showSuccessMessage('Completed delete');
    } else {
      showErrorMessage('Failed delete');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: CupertinoColors.activeGreen,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: CupertinoColors.destructiveRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
