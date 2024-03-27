import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_doctor_booking_app/shared/widgets/avatars/circle_avatar_with_text_label.dart';
import 'package:flutter_doctor_booking_app/shared/widgets/bottom_nav_bars/main_nav_bar.dart';
import 'package:flutter_doctor_booking_app/shared/widgets/cards/appointment_preview_card.dart';
import 'package:flutter_doctor_booking_app/shared/widgets/llist_tiles/doctor_list_tile.dart';
import 'package:flutter_doctor_booking_app/shared/widgets/titles/section_title.dart';
import 'package:flutter_doctor_booking_app/state/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final gapH4 = const SizedBox(height: 4);
  final gapH24 = const SizedBox(height: 24);
  final gapW4 = const SizedBox(width: 4);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: textTheme.bodyMedium,
            ),
            gapH4,
            Text(
              "User One",
              style: textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            gapH4,
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: colorScheme.secondary,
                ),
                gapW4,
                Text(
                  "India, IN",
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                gapW4,
                Icon(
                  Icons.expand_more,
                  color: colorScheme.secondary,
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(
            width: 8,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search doctor",
                suffixIcon: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: colorScheme.surfaceVariant,
                    )),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading ||
              state.status == HomeStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == HomeStatus.loaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const _DoctorCategories(),
                    gapH24,
                    const _MySchedule(),
                    gapH24,
                    const _NearbyDoctors()
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("Erro occured!"),
            );
          }
        },
      ),
      bottomNavigationBar: const MainNavBar(),
    );
  }
}

class _NearbyDoctors extends StatelessWidget {
  const _NearbyDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: "Nearby Doctors",
              action: "See all",
              onPressed: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.nearbyDoctors.length,
              itemBuilder: (context, index) {
                final doctor = state.nearbyDoctors[index];
                return DoctorListTile(doctor: doctor);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 24,
                  color: colorScheme.surfaceVariant,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _MySchedule extends StatelessWidget {
  const _MySchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: "My Schedule",
              action: "See all",
              onPressed: () {},
            ),
            AppointmentPreviewCard(
                appointment: state.myAppointments.firstOrNull)
          ],
        );
      },
    );
  }
}

class _DoctorCategories extends StatelessWidget {
  const _DoctorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: "Categories",
              action: "See all",
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.doctorCategories
                  .take(5)
                  .map((category) => Expanded(
                        child: CircleAvatatWithTextLabel(
                            icon: category.icon, label: category.name),
                      ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
