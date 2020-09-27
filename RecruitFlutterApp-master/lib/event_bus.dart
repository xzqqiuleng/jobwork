import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
 class ChatReplayEvent {
   String type;
   ChatReplayEvent(this.type);
}

class CitySelectEvent {
  String city;
  CitySelectEvent(this.city);
}
