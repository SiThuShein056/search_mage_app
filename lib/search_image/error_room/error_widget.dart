// ignore_for_file: must_be_immutable

import 'package:api_lessons/search_image/error_room/no_connection_err.dart';
import 'package:api_lessons/search_image/error_room/no_found_err.dart';
import 'package:api_lessons/search_image/error_room/server_err.dart';
import 'package:api_lessons/search_image/error_room/unknown_err.dart';
import 'package:api_lessons/search_image/ob/response_ob.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorControl extends StatelessWidget {
  ErrState errState;
  Function tryAgain;
  ErrorControl({required this.errState, required this.tryAgain});
  @override
  Widget build(BuildContext context) {
    return errState == ErrState.noConnectionErr
        ? NoConnectionErr(tryAgain: tryAgain)
        : errState == ErrState.notFoundErr
            ? NoFoundErr(tryAgain: tryAgain)
            : errState == ErrState.serverErr
                ? ServerErr(tryAgain: tryAgain)
                : UnknownErr(tryAgain: tryAgain);
  }
}
