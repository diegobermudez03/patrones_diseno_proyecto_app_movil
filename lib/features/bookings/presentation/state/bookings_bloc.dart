import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/bookings/domain/get_bookings_use_case.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_states.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/domain/confirm_invitation_use_case.dart';

class BookingsBloc extends Cubit<BookingsState>{

  final GetBookingsUseCase _getBookingsUseCase;
  final ConfirmInvitationUseCase _confirmInvitationUseCase;
  
  BookingsBloc(
    this._confirmInvitationUseCase,
    this._getBookingsUseCase
  ): super(BookingsInitialState());

  void retrieveBookings() async{
    await Future.delayed(Duration.zero);
    emit(BookingsRetrievingState());
    
    final response = await _getBookingsUseCase(null);

    emit(response.fold(
      (f)=>BookingsRetrievingFailureState(), 
      (bookings){
        print(bookings);
        return BookingsRetrievedState(bookings, false, false);
        }
      ));
  }

  void confirmInvitation(int ocassionId) async{
    await Future.delayed(Duration.zero);
    
    final response = await _confirmInvitationUseCase(ocassionId);

    final List<OcassionEntity> bookings = switch(state){
      BookingsRetrievedState(bookings: final b)=>b,
      BookingsState() => []
    };

    final bool result = response.fold((f)=>false, (t)=>true);

    if(!result){
      emit(BookingsRetrievedState(bookings, false, true));
      return;
    }
    final newBookings = bookings.map((e){
      if(e.ocassionId == ocassionId){
        e.state = AppStrings.confirmed;
      }
      return e;
    }).toList();

    emit(BookingsRetrievedState(newBookings, true, false));
  }

}