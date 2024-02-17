// ignore_for_file: must_be_immutable

import 'package:api_lessons/search_image/error_room/error_widget.dart';
import 'package:api_lessons/search_image/ob/response_ob.dart';
import 'package:api_lessons/search_image/ob/result_ob.dart';
import 'package:api_lessons/search_image/pages/searchpage/search_bloc.dart';
import 'package:api_lessons/search_image/widgets/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ResultlPage extends StatefulWidget {
  String str;
  ResultlPage({required this.str});
  @override
  State<ResultlPage> createState() => _ResultlPageState();
}

class _ResultlPageState extends State<ResultlPage> {
  SearchBloc _bloc = SearchBloc();
  RefreshController _controller = RefreshController();
  @override
  void initState() {
    super.initState();
    _bloc.searchImage(widget.str);

    _bloc.getDataStream().listen((ResponseOb responseOb) {
      if (responseOb.msgStatge == MsgStatge.data) {
        if (responseOb.pageState == PageState.first) {
          _controller.refreshCompleted();
        } else if (responseOb.pageState == PageState.load) {
          ResultOb rro = responseOb.data;
          if (rro.hits!.length < 20) {
            _controller.loadNoData(); //no data ပေါ် ချင်လို့
          } else {
            _controller.loadComplete();
          }
        }
      }
    });
  }

  List<Hits> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.str),
        centerTitle: true,
      ),
      body: StreamBuilder<ResponseOb>(
          initialData: ResponseOb(msgStatge: MsgStatge.loading),
          stream: _bloc.getDataStream(),
          builder: (context, AsyncSnapshot snapshot) {
            ResponseOb rOb = snapshot.data;

            if (rOb.msgStatge == MsgStatge.data) {
              ResultOb resultOb = rOb.data;
              if (rOb.pageState == PageState.first) {
                list = resultOb.hits!;
              }
              if (rOb.pageState == PageState.load) {
                list.addAll(resultOb.hits!);
              }
              return SmartRefresher(
                  controller: _controller,
                  enablePullDown: true,
                  enablePullUp: list.length >
                      19, //ဒါဆို data မရှိတော့လည်း load ထပ်ပေးအုန်းမာ.. ဒါကိုပဲ သူံးချင်ရင်တော့ အပေါ် က  controller နက်တွဲသုံးရမယ်
                  // enablePullUp: resultOb.hits!.length >
                  //     19, // ဒါဆို မရှိတော့ ရင် load ထပ်မပေးတော့ဘူး... ဒါသုံးမာဆို load ဆွဲမရတာပဲဖြစ်မာ no more data လို့မပေါ်ဘူး  အပေါ်က controller နဲ့ တွဲ မသုံးရဘူး
                  onRefresh: () {
                    _bloc.searchImage(widget.str);
                  },
                  onLoading: () {
                    _bloc.searchImageMore(widget.str);
                  },
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ResultWidget(list[index]);
                      }));
            } else if (rOb.msgStatge == MsgStatge.error) {
              return ErrorControl(
                  errState: rOb.errState!,
                  tryAgain: () {
                    _bloc.searchImage(widget.str);
                  });

              // return Center(
              //   child: Text("Error"),
              // );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
