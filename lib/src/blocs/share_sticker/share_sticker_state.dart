part of 'share_sticker_bloc.dart';

enum ShareStickerStatus { initial, loading, success, failure }

class ShareStickerState extends Equatable {
  const ShareStickerState({
    required this.status,
    this.error,
  });

  final ShareStickerStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error];

  ShareStickerState copyWith({
    ShareStickerStatus? status,
    String? error,
  }) {
    return ShareStickerState(
      status: status ?? this.status,
      error: error,
    );
  }
}