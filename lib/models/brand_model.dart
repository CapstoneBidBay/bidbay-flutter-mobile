import 'dart:convert';

class BrandModel {
  final String id;
  final String description;
  final String name;
  final String status;

  BrandModel(this.id, this.description, this.name, this.status);

  factory BrandModel.fromJson(Map<String, dynamic> jsonInput) {
    // MAP FROM JSON LOGIC HERE
    return BrandModel(
      jsonInput['id'],
      jsonInput['description'],
      jsonInput['name'],
      jsonInput['status'],
    );
  }
}