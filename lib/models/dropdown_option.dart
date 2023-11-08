class DropDownOption {
  String displayedValue;
  String value;

  DropDownOption({
    required this.displayedValue,
    required this.value,
  });

  @override
  bool operator ==(dynamic other) => other != null && other is DropDownOption && value == other.value;
  
  @override
  int get hashCode => super.hashCode;
  
}