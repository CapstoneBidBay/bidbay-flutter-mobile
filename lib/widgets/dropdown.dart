import 'package:bidbay_mobile/models/dropdown_option.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final List<DropDownOption> options;
  final Function(String?) onChanged;
  final String? initValue;

  const MyDropdownButton({super.key, required this.options, required this.onChanged, this.initValue});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String? dropdownValue;

  @override
  void initState(){
    super.initState();
    dropdownValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.options.where((element) => element.value == dropdownValue).isEmpty) {
      dropdownValue = null;
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        // width: 150,
        child: DropdownButton<String>(
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(8.0),
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
          elevation: 16,
          underline: const SizedBox.shrink(),
          isDense: false,
          onChanged: (String? value) {
            setState(() {
              widget.onChanged(value);
              dropdownValue = value;
            });
          },
          onTap: null,
          items: widget.options.map<DropdownMenuItem<String>>((DropDownOption option) {
            return DropdownMenuItem<String>(
              value: option.value,
              child: Text(option.displayedValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}