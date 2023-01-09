import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign_app/data/models/wechat_model_impl.dart';

import '../data/models/wechat_model.dart';
import '../data/vos/moment_vo.dart';

class MomentBloc extends ChangeNotifier {
  List<MomentVO>? moments;

  ///Model
  WechatModel _model = WechatModelImpl();

  bool isDisposed = false;
  MomentBloc() {
    _model.getMoments().listen((momentList) {
      moments = momentList;
      debugPrint("Posts====>$moments");
      if (!isDisposed) {
        notifyListeners();
      }
    });


  }

  void onTapDeletePost(int postId)async{
    await _model.deletePost(postId);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
