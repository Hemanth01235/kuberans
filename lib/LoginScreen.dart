import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/TabBar/tab_bar_bloc.dart';
import 'SignIn.dart';
import 'SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late final TabController tabController;
  late TabBarBloc tabBarBloc;

  @override
  void initState() {
    super.initState();
    tabBarBloc = TabBarBloc();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    tabController.dispose();
    tabBarBloc.close();
    super.dispose();
  }

  void _handleTabSelection() {
  //  selectedIndex = tabController.index;
    tabBarBloc.add(TabBarChanged(tabController.index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarBloc, TabBarState>(
      builder: (context, state) {
        if (state is TabBarUpdated) {
          tabController.animateTo(state.selectedIndex);
        }
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20),
                    ),
                ),
                color: Color(0xFFFFFFFF),
                elevation: 0.0,
                child: SizedBox(
                  height: 60,
                  child: TabBar(
                      indicatorColor: Colors.transparent,
                      onTap: (index) {
                        context.read<TabBarBloc>().add(TabBarChanged(index));
                        tabController.animateTo(index);
                        tabBarBloc.add(TabBarChanged(index));
                      },
                      controller: tabController,
                      tabs: [
                        Tab(
                          child: Card(
                            margin: EdgeInsets.all(10),
                            elevation: 0.0,
                            color: tabController.index == 0
                                ? Color(0xFFDA3C5B)
                                : Color(0xFFFFFFFF),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: tabController.index == 0
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF707070),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Card(
                            margin: EdgeInsets.all(10),
                            elevation: 0.0,
                            color: tabController.index == 1
                                ? Color(0xFFDA3C5B)
                                : Color(0xFFFFFFFF),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: tabController.index == 1
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF707070),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          body: TabBarView(
              controller: tabController,
              children: [
                SignIn(),
                SignUp(),
              ]),
        );
      },
    );
  }
}