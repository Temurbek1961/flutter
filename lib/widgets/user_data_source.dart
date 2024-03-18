import 'package:firstapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the user which will be rendered in datagrid.

/// An object to set the user collection data source to the datagrid. This
/// is used to map the user data to the datagrid widget.
class UserDataSource extends DataGridSource {
  UserDataSource({required List<UserModel> user}) {
    dataGridRows = user
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'firstName', value: dataGridRow.firstName),
              DataGridCell<String>(columnName: 'lastName', value: dataGridRow.lastName),
              DataGridCell<String>(columnName: 'phone', value: dataGridRow.phone),
              DataGridCell<String>(columnName: 'lang', value: dataGridRow.lang),
              DataGridCell<int>(columnName: 'periodDay', value: dataGridRow.periodDay),
              DataGridCell<int>(columnName: 'ndybf', value: dataGridRow.ndybf),
              DataGridCell<String>(columnName: 'timeZone', value: dataGridRow.timeZone),
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
              '${dataGridCell.value ?? ''}',
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    if (sortColumn.name == 'firstName') {
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
    if (sortColumn.name == 'lastName') {
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
    if (sortColumn.name == 'phone') {
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
    if (sortColumn.name == 'lang') {
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
    if (sortColumn.name == 'periodDay') {
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
    if (sortColumn.name == 'ndybf') {
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
    if (sortColumn.name == 'timeZone') {
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
