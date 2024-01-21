import 'dart:async';
import 'dart:io';

import 'package:firstapp/pages/user/add_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<User> user = <User>[];

  late UserDataSource userDatSource;

  @override
  void initState() {
    super.initState();
    user = getUserData();
    userDatSource = UserDataSource(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: ScreenUtil.defaultSize.height,
          child: SfDataGrid(
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
                              name: user[rowIndex].name,
                              age: user[rowIndex].age.toString(),
                              role: user[rowIndex].role,
                            ),
                          )
                        : MaterialPageRoute(
                            builder: (_) => AddUserScreen(
                              id: user[rowIndex].id,
                              name: user[rowIndex].name,
                              age: user[rowIndex].age.toString(),
                              role: user[rowIndex].role,
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
                                    child: const Text('Yes')),
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
            horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
            columns: <GridColumn>[
              GridColumn(
                columnName: 'name',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Name'),
                ),
              ),
              GridColumn(
                columnName: 'age',
                label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Age',
                  ),
                ),
              ),
              GridColumn(
                columnName: 'role',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Role',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
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

  List<User> getUserData() {
    return [
      User(33, 'James', 'Project Lead', '1'),
      User(30, 'Kathryn', 'Manager', '2'),
      User(18, 'Lara', 'Developer', '3'),
      User(19, 'Michael', 'Designer', '4'),
      User(29, 'Martin', 'Developer', '5'),
      User(32, 'Newberry', 'Developer', '6'),
      User(17, 'Balnc', 'Developer', '7'),
      User(25, 'Perry', 'Developer', '8'),
      User(23, 'Gable', 'Developer', '9'),
      User(28, 'Grimes', 'Developer', '10')
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the user which will be rendered in datagrid.
class User {
  /// Creates the user class with required details.
  User(this.age, this.name, this.role, this.id);

  /// user id
  final String id;

  /// name of an user.
  final String name;

  /// age of an user.
  final int age;

  /// Role of an user.
  final String role;
}

/// An object to set the user collection data source to the datagrid. This
/// is used to map the user data to the datagrid widget.
class UserDataSource extends DataGridSource {
  UserDataSource({required List<User> user}) {
    dataGridRows = user
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<int>(columnName: 'age', value: dataGridRow.age),
              DataGridCell<String>(columnName: 'role', value: dataGridRow.role),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    if (sortColumn.name == 'name') {
      final String? value1 = a?.getCells().firstWhere((element) => element.columnName == sortColumn.name).value.toString();
      final String? value2 = b?.getCells().firstWhere((element) => element.columnName == sortColumn.name).value.toString();

      if (value1 == null || value2 == null) {
        return 0;
      }

      if (sortColumn.sortDirection == DataGridSortDirection.ascending) {
        return value1.toLowerCase().compareTo(value2.toLowerCase());
      } else {
        return value2.toLowerCase().compareTo(value1.toLowerCase());
      }
    }
    if (sortColumn.name == 'age') {
      final String? value1 = a?.getCells().firstWhere((element) => element.columnName == sortColumn.name).value.toString();
      final String? value2 = b?.getCells().firstWhere((element) => element.columnName == sortColumn.name).value.toString();

      if (value1 == null || value2 == null) {
        return 0;
      }

      if (sortColumn.sortDirection == DataGridSortDirection.ascending) {
        return value1.toLowerCase().compareTo(value2.toLowerCase());
      } else {
        return value2.toLowerCase().compareTo(value1.toLowerCase());
      }
    }
    if (sortColumn.name == 'role') {
      final String? value1 = a?.getCells().firstWhere((element) => element.columnName == sortColumn.name).value.toString();
      final String? value2 = b?.getCells().firstWhere((element) => element.columnName == sortColumn.name).value.toString();

      if (value1 == null || value2 == null) {
        return 0;
      }

      if (sortColumn.sortDirection == DataGridSortDirection.ascending) {
        return value1.toLowerCase().compareTo(value2.toLowerCase());
      } else {
        return value2.toLowerCase().compareTo(value1.toLowerCase());
      }
    }

    return super.compare(a, b, sortColumn);
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}
