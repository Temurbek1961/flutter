import 'dart:async';
import 'dart:io';

import 'package:firstapp/components/sms/add_customer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
StreamController<bool> loadingController = StreamController<bool>();

class CustomerList extends StatefulWidget {
  /// Creates the home page.
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Customer> customer = <Customer>[];

  late CustomerDataSource customerDatSource;

  @override
  void initState() {
    super.initState();
    customer = getCustomerData();
    customerDatSource = CustomerDataSource(customer: customer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SfDataGrid(
                allowSwiping: true,
                startSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                  return GestureDetector(
                    onTap: () {},
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
                      customerDatSource.dataGridRows.removeAt(rowIndex);
                      customerDatSource.updateDataGridSource();
                    },
                    child: Container(
                      color: Colors.redAccent,
                      child: const Center(
                        child: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
                source: customerDatSource,
                columnWidthMode: ColumnWidthMode.auto,
                allowPullToRefresh: true,
                allowSorting: true,
                allowFiltering: true,
                // allowMultiColumnSorting: true,
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
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () => Navigator.push(
          context,
          Platform.isIOS
              ? CupertinoPageRoute(
                  builder: (_) => const AddCustomerScreen(),
                )
              : MaterialPageRoute(
                  builder: (_) => const AddCustomerScreen(),
                ),
        ),
      ),
    );
  }

  List<Customer> getCustomerData() {
    return [
      Customer(33, 'James', 'Project Lead'),
      Customer(30, 'Kathryn', 'Manager'),
      Customer(18, 'Lara', 'Developer'),
      Customer(19, 'Michael', 'Designer'),
      Customer(29, 'Martin', 'Developer'),
      Customer(32, 'Newberry', 'Developer'),
      Customer(17, 'Balnc', 'Developer'),
      Customer(25, 'Perry', 'Developer'),
      Customer(23, 'Gable', 'Developer'),
      Customer(28, 'Grimes', 'Developer')
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the customer which will be rendered in datagrid.
class Customer {
  /// Creates the customer class with required details.
  Customer(this.age, this.name, this.role);

  /// name of an customer.
  final String name;

  /// age of an customer.
  final int age;

  /// Role of an customer.
  final String role;
}

/// An object to set the customer collection data source to the datagrid. This
/// is used to map the customer data to the datagrid widget.
class CustomerDataSource extends DataGridSource {
  CustomerDataSource({required List<Customer> customer}) {
    dataGridRows = customer
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
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
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
