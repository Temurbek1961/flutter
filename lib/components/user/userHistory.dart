import 'package:flutter/material.dart';

class UserHistory extends StatelessWidget {


  const UserHistory({super.key });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //
  //     child: Container(
  //       padding: const EdgeInsets.all(25),
  //       margin: const EdgeInsets.symmetric(horizontal: 25),
  //       decoration: BoxDecoration(
  //         color: Colors.black,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: const Center(
  //         child: Text(
  //           "Sign In",
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 16,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}