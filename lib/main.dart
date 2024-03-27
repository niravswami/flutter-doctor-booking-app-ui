import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_doctor_booking_app/repositories/doctor_repository.dart';
import 'package:flutter_doctor_booking_app/screens/home_screen.dart';
import 'package:flutter_doctor_booking_app/shared/theme/app_theme.dart';
import 'package:flutter_doctor_booking_app/state/home/home_bloc.dart';

void main() {
  const doctorRepository = DoctorRepository();
  runApp(const MyApp(doctorRepository: doctorRepository));
}

class MyApp extends StatelessWidget {
  final DoctorRepository doctorRepository;

  const MyApp({
    super.key,
    required this.doctorRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: doctorRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(doctorRepository: doctorRepository)
              ..add(LoadHomeEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: const AppTheme().themeData,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
