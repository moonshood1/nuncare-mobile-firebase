import 'package:flutter/material.dart';

class MyCategoryRow extends StatelessWidget {
  const MyCategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Column(
          //   children: [
          //     const Text("Oncologie"),
          //     Container(
          //       height: 5,
          //       width: double.infinity,
          //       color: Colors.blue.shade200,
          //     )
          //   ],
          // ),
          // Column(
          //   children: [
          //     const Text("Dentiste"),
          //     Container(
          //       height: 5,
          //       width: double.infinity,
          //       color: Colors.green.shade200,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
