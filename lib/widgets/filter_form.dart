import 'package:bidbay_mobile/common/static_values.dart';
import 'package:bidbay_mobile/models/dropdown_option.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class FilterForm extends StatefulWidget {
  final void Function(FilterData) onSubmit;

  final FilterData data;

  const FilterForm({super.key, required this.onSubmit, required this.data});

  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  final _formKey = GlobalKey<FormState>();

  FilterData filterData = FilterData();

  @override
  void initState() {
    super.initState();
    filterData.auctionType = widget.data.auctionType;
    filterData.brandId = widget.data.brandId;
    filterData.categoryId = widget.data.categoryId;
    filterData.priceStart = widget.data.priceStart;
    filterData.priceEnd = widget.data.priceEnd;
    filterData.sort = widget.data.sort;
  }

  @override
  Widget build(BuildContext context) {
    List<DropDownOption> categoryOptions = categoryList.map((cate) => DropDownOption(displayedValue: cate.name, value: cate.id)).toList();
    List<DropDownOption> brandOptions = brandList.map((brand) => DropDownOption(displayedValue: brand.name, value: brand.id)).toList();
    categoryOptions.insert(0, DropDownOption(displayedValue: "Chọn chủng loại", value: ""));
    brandOptions.insert(0, DropDownOption(displayedValue: "Chọn thương hiệu", value: ""));
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyDropdownButton(
            options: categoryOptions,
            onChanged: (val) {
              setState(() {
                filterData.categoryId = val;
              });
            },
            initValue: widget.data.categoryId ?? "",
          ),
          const SizedBox(height: 20),
          MyDropdownButton(
            options: brandOptions,
            onChanged: (val) {
              setState(() {
                filterData.brandId = val;
              });
            },
            initValue: widget.data.brandId ?? "",
          ),
          const SizedBox(height: 20),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            initialValue: widget.data.priceStart == null ? '' : widget.data.priceStart.toString(),
            validator: (value) {
              if (value == null ||
                  int.tryParse(value) == null ||
                  int.parse(value) <= 0) {
                return 'Giá tiền không hợp lệ';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              filterData.priceStart = int.tryParse(value) == null ? null : int.parse(value);
            }),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Giá thấp nhất',
              hintStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: const Color.fromARGB(22, 255, 255, 255).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            initialValue: widget.data.priceEnd == null ? '' : widget.data.priceEnd.toString(),
            validator: (value) {
              if (value == null ||
                  int.tryParse(value) == null ||
                  int.parse(value) <= 0) {
                return 'Giá tiền không hợp lệ';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              filterData.priceEnd = int.tryParse(value) == null ? null : int.parse(value);
            }),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Giá cao nhất',
              hintStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: const Color.fromARGB(22, 255, 255, 255).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 20,),
          MyDropdownButton(
            options: [
              DropDownOption(displayedValue: "Sắp xếp theo", value: ""),
              DropDownOption(displayedValue: "Số lượng lượt đấu giá tăng dần", value: "numberOfBids:asc"),
              DropDownOption(displayedValue: "Số lượng lượt đấu giá giảm dần", value: "numberOfBids:desc"),
              DropDownOption(displayedValue: "Thời gian đấu giá còn lại tăng dần", value: "timeLeft:asc"),
              DropDownOption(displayedValue: "Thời gian đấu giá còn lại giảm dần", value: "timeLeft:desc"),
              DropDownOption(displayedValue: "Giá tăng dần", value: "highestPrice:asc"),
              DropDownOption(displayedValue: "Giá giảm dần", value: "highestPrice:desc"),
            ],
            onChanged: (val) {
              setState(() {
                filterData.sort = val;
              });
            },
            initValue: widget.data.sort ?? "",
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit(filterData);
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
                    return const Color.fromARGB(255, 12, 8, 243);
                  }
                  return const Color.fromARGB(255, 38, 73, 187);
                }),
              ),
              child: const Text("Lọc"),
            ),
          )
        ],
      ),
    );
  }
}
