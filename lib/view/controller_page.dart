import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:quran_karim/view/home_view.dart';

import '../services/auth.dart';
import 'auth_view/login.dart';
import 'profile_view.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<Auth>(
          init: Auth(),
          builder: (controller) {
            return (controller.user == null) ? Login() :  HomeView();
          },
        );
  }
}
