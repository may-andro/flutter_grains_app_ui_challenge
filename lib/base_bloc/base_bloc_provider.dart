import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BaseBlocProvider<T extends BlocBase> extends StatefulWidget {
  BaseBlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BaseBlocProviderState<T> createState() => _BaseBlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BaseBlocProvider<T>>();
    BaseBlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BaseBlocProviderState<T> extends State<BaseBlocProvider<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}