import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String domainName;
  @HiveField(4)
  String contactNumber;
  @HiveField(5)
  String image;

  StudentModel({
    required this.name,
    required this.email,
    required this.domainName,
    required this.contactNumber,
    this.image = '',
    this.id,
  });
}
