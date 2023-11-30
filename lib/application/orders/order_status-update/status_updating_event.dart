part of 'status_updating_bloc.dart';

@immutable
sealed class StatusUpdatingEvent {}

class UpdatingStatus extends StatusUpdatingEvent{
  final String anOrderId;
  final String anProductid;
  final String anStatus;
  UpdatingStatus({required this.anOrderId,required this.anProductid,required this.anStatus});
}
