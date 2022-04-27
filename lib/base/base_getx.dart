
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ViewState { Init, Idle, Busy, Error, Empty }

///Controller
abstract class BaseXController extends GetxController {

  ViewState state = ViewState.Init;
  bool isDispose = false;

  BaseXController({this.state = ViewState.Init});

  bool isBusyState() => state == ViewState.Busy;
  bool isInitState() => state == ViewState.Init;

  setBusyState()=>setState(ViewState.Busy);

  setIdleState()=>setState(ViewState.Idle);

  setEmptyState()=>setState(ViewState.Empty);

  setErrorState()=>setState(ViewState.Error);

  void setState(ViewState state){
    this.state = state;
    update();
  }

  ///第一帧未回调的方法
  @override
  void onInit() {
    super.onInit();
  }

  ///第一帧已回调的方法
  @override
  void onReady() {
    super.onReady();
  }


  @override
  @mustCallSuper
  onClose(){
    super.onClose();
    isDispose = true;
  }

}


///Bindings
abstract class BaseBindings extends Bindings {}
