import 'package:flutter/cupertino.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'HeaderState.dart';

class Header extends StatefulWidget {
  const Header({
    required this.stateManager,
    Key? key,
  }) : super(key: key);

  final PlutoGridStateManager stateManager;

  @override
  State<Header> createState() => HeaderState();
}