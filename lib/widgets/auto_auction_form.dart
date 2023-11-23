import 'package:bidbay_mobile/models/auto_auction_info_model.dart';
import 'package:flutter/material.dart';

class AutoAuctionForm extends StatefulWidget {
  final void Function(String?, int, int, int) onSubmit;
  final AutoAuctionInfo autoAuctionInfo;
  const AutoAuctionForm({super.key, required this.onSubmit, required this.autoAuctionInfo});

  @override
  _AutoAuctionFormState createState() => _AutoAuctionFormState();
}

class _AutoAuctionFormState extends State<AutoAuctionForm> {
  final _formKey = GlobalKey<FormState>();
  int _maxPrice = 0;
  int _delayTime = 0;
  int _jump = 0;

  @override
  void initState(){
    super.initState();
    _maxPrice = widget.autoAuctionInfo.maxPrice;
    _delayTime = widget.autoAuctionInfo.delayTime;
    _jump = widget.autoAuctionInfo.jump;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            initialValue: widget.autoAuctionInfo.maxPrice.toString(),
            validator: (value) {
              if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'Giá tiền không hợp lệ';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _maxPrice = int.tryParse(value) == null ? 0 : int.parse(value);
            }),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Giá cao nhất có thể đặt',
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
          const SizedBox(height: 15),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            initialValue: widget.autoAuctionInfo.delayTime.toString(),
            validator: (value) {
              if (value == null || int.tryParse(value) == null || int.parse(value) < 0) {
                return 'Thời gian không hợp lệ';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _delayTime = int.tryParse(value) == null ? 0 : int.parse(value);
            }),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Khoảng thời gian delay đặt lại sau khi có giá mới (phút)',
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
          const SizedBox(height: 15),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            initialValue: widget.autoAuctionInfo.jump.toString(),
            validator: (value) {
              if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'Giá tiền không hợp lệ';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _jump = int.tryParse(value) == null ? 0 : int.parse(value);
            }),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Bước nhảy',
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
              fillColor: Color.fromARGB(22, 255, 255, 255).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit(widget.autoAuctionInfo.id, _maxPrice, _delayTime, _jump);
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
              child: Text("Đặt đấu giá tự động"),
            ),
          )
        ],
      ),
    );
  }
}