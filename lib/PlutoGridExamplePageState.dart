import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'Header.dart';
import 'PlutoGridExamplePage.dart';
import 'dart:async';

import 'PlutoScreen.dart';


class PlutoGridExamplePageState extends State<PlutoGridExamplePage> {
  final List<PlutoColumn> columns = [];

  final List<PlutoColumnGroup> columnGroups = [];

  final List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;

  bool checkReadOnly(PlutoRow row, PlutoCell cell) {
    return row.cells['status']!.value != 'created';
  }

  @override
  void initState() {
    super.initState();

    columns.addAll([
      PlutoColumn(
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
        readOnly: true,
        checkReadOnly: checkReadOnly,
        titleSpan: const TextSpan(children: [
          WidgetSpan(
              child: Icon(
                Icons.lock_outlined,
                size: 17,
              )),
          TextSpan(text: 'Id'),
        ]),
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.select(<String>[
          'saved',
          'edited',
          'created',
        ]),
        enableEditingMode: false,
        frozen: PlutoColumnFrozen.end,
        titleSpan: const TextSpan(children: [
          WidgetSpan(
              child: Icon(
                Icons.lock,
                size: 17,
              )),
          TextSpan(text: 'Status'),
        ]),
        renderer: (rendererContext) {
          Color textColor = Colors.black;

          if (rendererContext.cell.value == 'saved') {
            textColor = Colors.green;
          } else if (rendererContext.cell.value == 'edited') {
            textColor = Colors.red;
          } else if (rendererContext.cell.value == 'created') {
            textColor = Colors.blue;
          }

          return Text(
            rendererContext.cell.value.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    ]);

    columnGroups.addAll([
      PlutoColumnGroup(title: 'User', fields: ['id', 'name']),
      PlutoColumnGroup(
        title: 'Status',
        fields: ['status'],
        expandedColumn: true,
      ),
    ]);

    rows.addAll([
      PlutoRow(cells: {
        'id': PlutoCell(value: 'user1'),
        'name': PlutoCell(value: 'user name 1'),
        'status': PlutoCell(value: 'saved'),
      }),
      PlutoRow(cells: {
        'id': PlutoCell(value: 'user2'),
        'name': PlutoCell(value: 'user name 2'),
        'status': PlutoCell(value: 'saved'),
      }),
      PlutoRow(cells: {
        'id': PlutoCell(value: 'user3'),
        'name': PlutoCell(value: 'user name 3'),
        'status': PlutoCell(value: 'saved'),
      }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PlutoScreen(
      title: 'BudgetCulator',
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        columnGroups: columnGroups,
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);

          if (event.row.cells['status']!.value == 'saved') {
            event.row.cells['status']!.value = 'edited';
          }

          stateManager.notifyListeners();
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
        },
        createHeader: (stateManager) => Header(stateManager: stateManager),
      ),
    );
  }
}