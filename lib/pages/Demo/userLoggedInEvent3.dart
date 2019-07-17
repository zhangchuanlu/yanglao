import 'package:event_bus/event_bus.dart';

// test
EventBus eventBus=EventBus();
class UserLoggedInEvent{
  String Text;
  UserLoggedInEvent(this.Text);
}