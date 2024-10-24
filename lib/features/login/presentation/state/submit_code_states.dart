abstract class SubmitCodeState{}

class SubmitCodeInitialState implements SubmitCodeState{}

class SubmitCodeLoadingState implements SubmitCodeState{}

class SubmitCodeFailure implements SubmitCodeState{
  final String message;

  SubmitCodeFailure(this.message);
}

class SubmitCodeSuccess implements SubmitCodeState{

}