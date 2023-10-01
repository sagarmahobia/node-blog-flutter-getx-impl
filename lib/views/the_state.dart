class RxResponse{}

class RxResponseSuccess<T> extends RxResponse{
  final T? data;
  RxResponseSuccess({this.data});
}

class RxResponseError extends RxResponse{
  final String? error;
  RxResponseError({this.error});
}

class RxResponseLoading extends RxResponse{}
