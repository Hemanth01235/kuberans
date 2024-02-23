import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/TabBar/tab_bar_bloc.dart';
import 'Bloc/SignIn/SignIn.dart';
import 'Bloc/SignUp/SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin{
  int selectedIndex = 0;
  int selectedIndex1 = 0;
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
    tabBarBloc.add(TabBarChanged(tabController.index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarBloc, TabBarState>(bloc: tabBarBloc,
      builder: (context, state) {
        if (state is TabBarUpdated) {
          tabController.animateTo(state.selectedIndex);
        }
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 30,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFDA3C5B),
                  ), dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ]),
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
