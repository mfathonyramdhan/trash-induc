import 'package:flutter/cupertino.dart';
import 'package:kiloin/models/officer_navigation.dart';

class OfficerDrawerRepository extends ChangeNotifier {
  OfficerNavigation _officerNavigation = OfficerNavigation.dashboard;

  OfficerNavigation get officerNavigation => _officerNavigation;

  void setOfficerNavigation(OfficerNavigation petugasNavigation) {
    _officerNavigation = petugasNavigation;

    notifyListeners();
  }
}
