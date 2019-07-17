import 'package:event_bus/event_bus.dart';


EventBus eventBus=EventBus();
class UserLoggedInEvent{
  String Text;
  UserLoggedInEvent(this.Text);
}