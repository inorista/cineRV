import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'share_sticker_events.dart';
part 'share_sticker_state.dart';

class ShareStickerBloc extends Bloc<ShareStickerEvent, ShareStickerState> {
  ShareStickerBloc()
      : super(const ShareStickerState(
          status: ShareStickerStatus.initial,
        )) {}
}
