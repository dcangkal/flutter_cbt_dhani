import 'package:bloc/bloc.dart';
import 'package:flutter_cbt_dhani/data/datasources/remote/ujian_remote_datasource.dart';
import 'package:flutter_cbt_dhani/data/models/responses/ujian_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ujian_by_kategori_event.dart';
part 'ujian_by_kategori_state.dart';
part 'ujian_by_kategori_bloc.freezed.dart';

class UjianByKategoriBloc
    extends Bloc<UjianByKategoriEvent, UjianByKategoriState> {
  final UjianRemoteDatasouce ujianRemoteDatasouce;
  UjianByKategoriBloc(this.ujianRemoteDatasouce) : super(const _Initial()) {
    on<_GetUjianByKategori>((event, emit) async {
      emit(const _Loading());
      final response =
          await ujianRemoteDatasouce.getUjianByKategori(event.kategori);
      response.fold((l) => emit(_Error(l)), (r) {
        if (r.data.isEmpty) {
          emit(const _NotFound());
        } else {
          emit(_Success(r));
        }
      });
    });
  }
}
