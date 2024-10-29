import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/dep_injection.dart';
import 'package:mobile_app/features/login/domain/use_cases/submit_code_use_case.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_states.dart';
import 'package:mobile_app/shared/storage_service/storage_service.dart';

class SubmitCodeBloc extends Cubit<SubmitCodeState>{
  final SubmitCodeUseCase _submitCodeUseCase;
  final StorageService _storageService;

  SubmitCodeBloc(
    this._submitCodeUseCase,
    this._storageService
  ): super(SubmitCodeInitialState());

  void submit(String number, String code)async{
    emit(SubmitCodeLoadingState());

    final response = await _submitCodeUseCase(Tuple2(number, code));
    
    response.fold(
      (f)=> emit(SubmitCodeFailure(f.message)),
      (token)async{
        await _storageService.writeToken(token);
        emit(SubmitCodeSuccess());
      }
    );
  }

}