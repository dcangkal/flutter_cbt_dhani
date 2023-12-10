// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_dhani/data/datasources/remote/ujian_remote_datasource.dart';

part 'create_ujian_bloc.freezed.dart';
part 'create_ujian_event.dart';
part 'create_ujian_state.dart';

class CreateUjianBloc extends Bloc<CreateUjianEvent, CreateUjianState> {
  final UjianRemoteDatasouce ujianRemoteDatasouce;
  CreateUjianBloc(
    this.ujianRemoteDatasouce,
  ) : super(const _Initial()) {
    on<_CreateUjian>((event, emit) async {
      emit(const _Loading());
      final response = await ujianRemoteDatasouce.createUjian();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
