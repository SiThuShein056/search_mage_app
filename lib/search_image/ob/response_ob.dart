class ResponseOb {
  MsgStatge? msgStatge;
  ErrState? errState;
  dynamic data;
  PageState? pageState;
  ResponseOb({this.data, this.errState, this.msgStatge, this.pageState});
}

enum MsgStatge {
  error,
  data,
  loading,
  other,
}

enum ErrState {
  notFoundErr,
  serverErr,
  noConnectionErr,
  unknownErr,
}

enum PageState {
  load,
  noMore,
  first,
}
