import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:api_lessons/search_image/ob/response_ob.dart';
import 'package:api_lessons/search_image/ob/result_ob.dart';
import 'package:api_lessons/search_image/util/const.dart';
import 'package:http/http.dart' as http;

class SearchBloc {
  StreamController<ResponseOb> _controller =
      StreamController<ResponseOb>.broadcast();
  Stream<ResponseOb> getDataStream() => _controller.stream;
  int page = 1;
  searchImage(String str) async {
    page = 1;
    ResponseOb responseOb = ResponseOb(msgStatge: MsgStatge.loading);
    _controller.sink.add(responseOb);

    try {
      var response = await http
          .get(Uri.parse(BASE_URL + "?key=$API_KEY&q=$str&page=$page"));

      print("Response Status Code is ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Page is $page");

        ResultOb rOb = ResultOb.fromJson(json.decode(response.body));

        responseOb.msgStatge = MsgStatge.data;
        responseOb.data = rOb;
        responseOb.pageState = PageState.first;
        _controller.sink.add(responseOb);
      } else if (response.statusCode == 404) {
        responseOb.msgStatge = MsgStatge.error;
        responseOb.errState = ErrState.notFoundErr;
        _controller.sink.add(responseOb);
      } else if (response.statusCode == 500) {
        responseOb.msgStatge = MsgStatge.error;
        responseOb.errState = ErrState.serverErr;
        _controller.sink.add(responseOb);
      } else {
        responseOb.msgStatge = MsgStatge.error;
        responseOb.errState = ErrState.unknownErr;
        _controller.sink.add(responseOb);
      }
    } catch (e) {
      log("Error is " + e.toString());
      if (e.toString().contains("SocketException")) {
        responseOb.msgStatge = MsgStatge.error;
        responseOb.errState = ErrState.noConnectionErr;
        _controller.sink.add(responseOb);
      }
    }
  }

  searchImageMore(String str) async {
    page++;
    ResponseOb responseOb = ResponseOb(msgStatge: MsgStatge.loading);
    // _controller.sink.add(responseOb);
    var response =
        await http.get(Uri.parse(BASE_URL + "?key=$API_KEY&q=$str&page=$page"));

    if (response.statusCode == 200) {
      print("PageState $page");

      ResultOb rOb = ResultOb.fromJson(json.decode(response.body));
      responseOb.msgStatge = MsgStatge.data;
      responseOb.data = rOb;
      responseOb.pageState = PageState.load;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 404) {
      responseOb.msgStatge = MsgStatge.error;
      responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 500) {
      responseOb.msgStatge = MsgStatge.error;
      responseOb.errState = ErrState.serverErr;
      _controller.sink.add(responseOb);
    } else {
      responseOb.msgStatge = MsgStatge.error;
      responseOb.errState = ErrState.unknownErr;
      _controller.sink.add(responseOb);
    }
  }

  dispose() {
    _controller.close();
  }
}
