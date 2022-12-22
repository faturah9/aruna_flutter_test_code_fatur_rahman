// ignore: constant_identifier_names
enum Status { LOADING, COMPLETED, ERROR }

class ResultModel<T> {
  final Status? status;
  final T? data;
  final String? message;

  ResultModel.loading([this.data, this.message = 'Pesan tidak dikenal']) : status = Status.LOADING;
  ResultModel.completed(this.data, [this.message = 'Pesan tidak dikenal']) : status = Status.COMPLETED;
  ResultModel.error(this.message, [this.data]) : status = Status.ERROR;
}
