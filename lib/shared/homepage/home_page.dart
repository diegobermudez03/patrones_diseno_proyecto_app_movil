import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/bookings/presentation/bookings_page.dart';
import 'package:mobile_app/features/current/presentation/pages/current_page.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/events/presentation/pages/events_page.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: AppStrings.inProgress),
    BottomNavigationBarItem(icon: Icon(Icons.event), label: AppStrings.events),
    BottomNavigationBarItem(icon: Icon(Icons.home_repair_service_sharp), label: AppStrings.bookings),
  ];

  final List<Widget> pages = [
    BlocProvider(
      create: (context) => GetIt.instance.get<CurrentBloc>(),
      child: CurrentPage(),
    ),
    BlocProvider(
      create: (context) => GetIt.instance.get<EventsBloc>(),
      child: EventsPage(),
    ),
    BookingsPage(),
  ];
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Expanded(
        child: IndexedStack(index: page, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}
