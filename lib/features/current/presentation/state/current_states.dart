import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

abstract class CurrentState{}

class CurrentInitialState implements CurrentState{}

class CurrentLoadingState implements CurrentState{}

class CurrentRetrieveFailure implements CurrentState{}

class CurrentRetrieveSuccess implements CurrentState{
  final List<OcassionEntity> ocassions;

  CurrentRetrieveSuccess(this.ocassions);
}