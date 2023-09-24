import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, this.onChange});
final Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged:onChange ,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'ابحث عما تريد ...',
        hintStyle: TextStyle(color: Colors.grey[400]),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 22,
            color:Colors.grey[400]
          ),
        ),
      ),
    );
  }
}
