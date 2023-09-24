abstract class BookMarkStates {}

class InitialBookMarkState extends BookMarkStates {}

class SuccessBookMarkState extends BookMarkStates {}

class SliderChangeState extends BookMarkStates {}

class LoadingBookMarkState extends BookMarkStates {}

class FailureBookMarkState extends BookMarkStates {
  final String error ;
  FailureBookMarkState(this.error);
}
class changeFontState extends BookMarkStates {}
