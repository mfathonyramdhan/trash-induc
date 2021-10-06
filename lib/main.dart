import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'bloc/user_bloc.dart';
import 'services/auth_services.dart';
import 'shared/route.dart';
import 'shared/theme.dart';
import 'ui/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: "",
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserBloc()),
        ],
        child: ScreenUtilInit(
          designSize: Size(360, 640),
          builder: () => MaterialApp(
            title: 'Bank Sampah App',
            routes: appRoute,
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          ),
        ),
      ),
    );
  }
}
