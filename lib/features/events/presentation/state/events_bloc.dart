import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/domain/confirm_invitation_use_case.dart';
import 'package:mobile_app/features/events/domain/get_events_use_case.dart';
import 'package:mobile_app/features/events/presentation/state/events_state.dart';

class EventsBloc extends Cubit<EventsState>{

  final GetEventsUseCase _getEventsUseCase;
  final ConfirmInvitationUseCase _confirmInvitationUseCase;
  
  EventsBloc(
    this._confirmInvitationUseCase,
    this._getEventsUseCase
  ): super(EventsInitialState());

  void retrieveEvents() async{
    await Future.delayed(Duration.zero);
    emit(EventsRetrievingState());
    
    final response = await _getEventsUseCase(null);

    emit(response.fold(
      (f)=>EventsRetrievingFailureState(), 
      (events)=>EventsRetrievedState(events, false, false)));
  }

  void confirmInvitation(int ocassionId) async{
    await Future.delayed(Duration.zero);
    
    final response = await _confirmInvitationUseCase(ocassionId);

    final List<OcassionEntity> events = switch(state){
      EventsRetrievedState(events: final e)=>e,
      EventsState() => []
    };

    final bool result = response.fold((f)=>false, (t)=>true);

    if(!result){
      emit(EventsRetrievedState(events, false, true));
      return;
    }
    final newEvents = events.map((e){
      if(e.ocassionId == ocassionId){
        e.state = AppStrings.confirmed;
      }
      return e;
    }).toList();

    emit(EventsRetrievedState(newEvents, true, false));
  }

}