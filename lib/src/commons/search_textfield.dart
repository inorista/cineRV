import 'package:cinerv/src/blocs/search_field/search_field_bloc.dart';
import 'package:cinerv/src/blocs/search_history/search_history_bloc.dart';
import 'package:cinerv/src/blocs/search_result/search_result_bloc.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        height: 45,
        child: BlocBuilder<SearchFieldBloc, SearchFieldState>(
          builder: (context, state) {
            return TextFormField(
              style: kStyleTextField,
              autofocus: false,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) async {
                if (value.isEmpty) {
                  context.read<SearchResultBloc>().add(ClearSearch());
                }
              },
              onFieldSubmitted: (value) async {
                if (!value.isEmpty) {
                  context
                      .read<SearchResultBloc>()
                      .add(SearchMovieByKeyWord(keyword: value));
                }
                context
                    .read<SearchHistoryBloc>()
                    .add(AddKeywordToHistoryList(keyword: value));
              },
              controller: state.textController,
              maxLines: 1,
              cursorColor: const Color(0xffFE53BB),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    context.read<SearchResultBloc>().add(ClearSearch());
                    state.textController.clear();
                  },
                  child: const Icon(
                    Iconsax.close_circle5,
                    color: Colors.white60,
                    size: 15,
                  ),
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(
                  EvaIcons.search,
                  color: Colors.white,
                  size: 25,
                ),
                filled: true,
                fillColor: const Color(0xff2d2d2d),
                counterText: "",
                hintText: "Bạn đang tìm phim nào?",
                hintStyle: kStyleHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: const Color(0xff767680).withOpacity(0.12),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: const Color(0xff767680).withOpacity(0.12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
