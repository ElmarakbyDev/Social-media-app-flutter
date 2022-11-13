import 'package:flutter/material.dart';
import 'package:future_chat/app/modules/add_post/views/add_post_view.dart';
import 'package:future_chat/app/modules/chats/views/chats_view.dart';
import 'package:future_chat/app/modules/home/views/home_view.dart';
import 'package:future_chat/app/modules/notifications/views/notifications_view.dart';
import 'package:future_chat/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  Widget _currentScreen = const HomeView();

  get CurrentScreen => _currentScreen;

  int _navIndex = 0;
  get navIndex => _navIndex;
  onSelected(int index) {
    _navIndex = index;
    switch (index) {
      case 0:
        {
          _currentScreen = const HomeView();
          break;
        }
      case 1:
        {
          _currentScreen = const ChatsView();
          break;
        }
      case 2:
        {
          _currentScreen = const AddPostView();
          break;
        }
      case 3:
        {
          _currentScreen = const NotificationsView();
          break;
        }
      case 4:
        {
          _currentScreen = const ProfileView();
          break;
        }
    }
    update();
  }
}
