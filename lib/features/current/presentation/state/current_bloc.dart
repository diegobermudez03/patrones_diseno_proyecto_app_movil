import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/domain/use_cases/action_on_ocassion_use_case.dart';
import 'package:mobile_app/features/current/domain/use_cases/get_ocassions_use_case.dart';
import 'package:mobile_app/features/current/presentation/state/current_states.dart';

class CurrentBloc extends Cubit<CurrentState>{

  final GetOcassionsUseCase _getOcassionsUseCase;
  final ActionOnOcassionUseCase _actionOnOcassionUseCase;

  CurrentBloc(
    this._getOcassionsUseCase,
    this._actionOnOcassionUseCase
  ): super(CurrentInitialState());

  void seekOcassions() async{
    emit(CurrentLoadingState());
    final response = await _getOcassionsUseCase(null);
    
    response.fold(
      (f)=>emit(CurrentRetrieveFailure()), 
      (ocassions) => emit(CurrentRetrieveSuccess(ocassions))
    );
  }

  void actionOnOcassion(int ocassionId) async{
    final List<OcassionEntity> ocassions = switch(state){
      CurrentRetrieveSuccess(ocassions: final occ) => occ,
      CurrentLoadingAction(ocassions: final occ) => occ,
      CurrentActionFailure(ocassions: final occ) => occ,
      CurrentState _ => []
    };
    emit(CurrentLoadingAction(ocassions, ocassionId));

    final response = await _actionOnOcassionUseCase(ocassionId);

    response.fold(
      (f)=> emit(CurrentActionFailure(ocassions)),
      (s){
        ocassions.where((oc)=>oc.ocassionId == ocassionId).first.isInside = s;  //s is the returned by the api, if its now inside or outside
        emit(CurrentRetrieveSuccess(ocassions));
      }
    );
  }
}