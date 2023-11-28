abstract class UberStates{}

class InitialUberState extends UberStates{}

class LoadingUberState extends UberStates{}

class SuccessUberState extends UberStates{}

class ErrorUberState extends UberStates{
  String error;
  ErrorUberState({required this.error});

}