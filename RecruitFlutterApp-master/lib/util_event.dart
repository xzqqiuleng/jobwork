import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
 class ReplayChatEvent {
   String type;
   ReplayChatEvent(this.type);
}

class CitySelEvent {
  String city;
  CitySelEvent(this.city);
}
class RefListEvent {
  bool isRefresh;
  RefListEvent(this.isRefresh);
}
