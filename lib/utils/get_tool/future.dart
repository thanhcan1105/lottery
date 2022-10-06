part of 'get_tool.dart';

extension GetToolFuture on GetTool {
  setTimeout(Function callback, int timeout) => Future.delayed(Duration(milliseconds: timeout), callback());
  setInterval(Function callback, int timeout) => Timer.periodic(Duration(milliseconds: timeout), callback());
}
