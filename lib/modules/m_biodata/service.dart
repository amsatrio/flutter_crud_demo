import 'dart:convert';

import 'package:flutter_crud_demo/config/environment.dart';
import 'package:flutter_crud_demo/config/logger.dart';
import 'package:flutter_crud_demo/modules/m_biodata/model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'service.g.dart';

@riverpod
class Service extends _$Service {
  final _baseUrl = '${Environment.baseUrl}/v1/m-biodata';

  @override
  Future<List<MBiodata>> build() async {
    final response = await http.get(Uri.parse('$_baseUrl?page=0&size=10'));
    final Map<String, dynamic> pagination = jsonDecode(response.body)["data"];
    final List<dynamic> data = pagination["content"];
    if(data.isEmpty) {
      return [];
    }
    logger.d(data);
    return data.map((json) => MBiodata.fromJson(json)).toList();
  }

  // CREATE
  Future<void> addMBiodata(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: jsonEncode({'title': title, 'completed': false, 'userId': 1}),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      final newMBiodata = MBiodata.fromJson(jsonDecode(response.body));
      return [...state.value!, newMBiodata];
    });
  }

  // UPDATE
  Future<void> editMBiodata(int id, String fullname, String mobilePhone, bool isDelete) async {
    logger.d('id: $id');
    state = await AsyncValue.guard(() async {
      await http.put(
        Uri.parse(_baseUrl),
        body: jsonEncode({'id': id, 'fullname': fullname, 'mobilePhone': mobilePhone, 'isDelete': isDelete}),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      return state.value!.map((mBiodata) => mBiodata.id == id ? mBiodata.copyWith(fullname: fullname, mobilePhone: mobilePhone) : mBiodata).toList();
    });
  }

  // DELETE
  Future<void> removeMBiodata(int id) async {
    state = await AsyncValue.guard(() async {
      await http.delete(Uri.parse('$_baseUrl/$id'));
      return state.value!.where((mBiodata) => mBiodata.id != id).toList();
    });
  }
}

