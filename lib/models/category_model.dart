import 'dart:convert';

class CategoryModel {
  final String id;
  final String description;
  final String name;
  final String status;

  CategoryModel(this.id, this.description, this.name, this.status);

  factory CategoryModel.fromJson(Map<String, dynamic> jsonInput) {
    // MAP FROM JSON LOGIC HERE
    return CategoryModel(
      jsonInput['id'],
      jsonInput['description'],
      jsonInput['name'],
      jsonInput['status'],
    );
  }
}