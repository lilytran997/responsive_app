
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc{
  // Repository get repository => _repository;
  // Repository _repository = Repository();

  BuildContext _context;

  setContext(BuildContext context) => _context = context;
  BuildContext get context => _context;

  set(BehaviorSubject<dynamic> stream, dynamic event){
    if(!stream.isClosed) stream.sink.add(event);
  }

  @protected
  @mustCallSuper
  void dispose(){

  }
}