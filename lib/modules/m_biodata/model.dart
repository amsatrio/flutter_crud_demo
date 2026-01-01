import 'package:flutter_crud_demo/config/logger.dart';

class MBiodata {
  final int id;
  final String? fullname;
  final String? mobilePhone;
  final List<int>? image;
  final String? imagePath;
  final int createdBy;
  final int? modifiedBy;
  final int? deletedBy;
  final DateTime createdOn;
  final DateTime? modifiedOn;
  final DateTime? deletedOn;
  final bool? isDelete;

  MBiodata({
    required this.id,
    this.fullname,
    this.mobilePhone,
    this.image,
    this.imagePath,
    required this.createdBy,
    this.modifiedBy,
    this.deletedBy,
    required this.createdOn,
    this.modifiedOn,
    this.deletedOn,
    this.isDelete,
  });

  factory MBiodata.fromJson(Map<String, dynamic> json) { 
    logger.d(json);
    return MBiodata(
        id: json['id'] ?? 0,
        fullname: json['fullname'],
        mobilePhone: json['mobilePhone'],
        image: json['image'],
        imagePath: json['imagePath'],
        createdBy: json['createdBy'],
        modifiedBy: json['modifiedBy'] ?? json['modifiedBy'],
        deletedBy: json['deletedBy'] ?? json['deletedBy'],
        createdOn: DateTime.parse(json['createdOn']),
        modifiedOn: json['modifiedOn'] == null ? null : DateTime.parse(json['modifiedOn']),
        deletedOn: json['deletedOn'] == null ? null : DateTime.parse(json['deletedOn']),
        isDelete: json['isDelete'],
      );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'mobilePhone': mobilePhone,
        'image': image,
        'imagePath': imagePath,
        'createdBy': createdBy,
        'modifiedBy': modifiedBy,
        'deletedBy': deletedBy,
        'createdOn': createdOn.toIso8601String(),
        'modifiedOn': modifiedOn?.toIso8601String(),
        'deletedOn': deletedOn?.toIso8601String(),
        'isDelete': isDelete,
      };

  MBiodata copyWith({ int? id, String? fullname, String? mobilePhone, List<int>? image, String? imagePath, int? createdBy, int? modifiedBy, int? deletedBy, DateTime? createdOn, DateTime? modifiedOn, DateTime? deletedOn, bool? isDelete }) {
    return MBiodata(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      image: image ?? this.image,
      imagePath: imagePath ?? this.imagePath,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      deletedBy: deletedBy ?? this.deletedBy,
      createdOn: createdOn ?? this.createdOn,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      deletedOn: deletedOn ?? this.deletedOn,
      isDelete: isDelete ?? this.isDelete,
    );
  }
}