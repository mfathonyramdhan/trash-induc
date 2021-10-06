class ResponseHandler<T> {
  final T? user;
  final String? message;
  final bool? success;

  ResponseHandler({
    this.user,
    this.message,
    this.success,
  });
}
