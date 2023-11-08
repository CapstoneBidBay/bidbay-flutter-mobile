import 'package:flutter/material.dart';

class ManualAuctionForm extends StatefulWidget {
  final void Function(int) onSubmit;
  const ManualAuctionForm({super.key, required this.onSubmit});

  @override
  _ManualAuctionFormState createState() => _ManualAuctionFormState();
}

class _ManualAuctionFormState extends State<ManualAuctionForm> {
  final _formKey = GlobalKey<FormState>();
  int _placedPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 15),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'Giá tiền không hợp lệ';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _placedPrice = int.tryParse(value) == null ? 0 : int.parse(value);
            }),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Giá bạn đặt',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit(_placedPrice);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Color.fromARGB(255, 12, 8, 243);
                  }
                  return Color.fromARGB(255, 38, 73, 187);
                }),
              ),
              child: Text("Đặt đấu giá thủ công"),
            ),
          )
        ],
      ),
    );
  }
}