import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/features/current/domain/use_cases/get_ocassions_use_case.dart';
import 'package:mobile_app/features/current/presentation/state/current_states.dart';

class CurrentBloc extends Cubit<CurrentState>{

  final GetOcassionsUseCase _getOcassionsUseCase;

  CurrentBloc(
    this._getOcassionsUseCase
  ): super(CurrentInitialState());

  void seekOcassions() async{
    emit(CurrentLoadingState());
    final response = await _getOcassionsUseCase(null);
    
    response.fold(
      (f)=>emit(CurrentRetrieveFailure()), 
      (ocassions) => emit(CurrentRetrieveSuccess(ocassions))
    );
  }
}