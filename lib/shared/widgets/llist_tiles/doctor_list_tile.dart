// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_doctor_booking_app/screens/doctor_details_screen.dart';
import 'package:models/models.dart';

class DoctorListTile extends StatelessWidget {
  const DoctorListTile({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DoctorDetailsScreen(doctorId: doctor.id);
            },
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(doctor.profileImageUrl),
        backgroundColor: colorScheme.background,
      ),
      title: Text(
        doctor.name,
        style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          Text(
            doctor.category.name,
            style: textTheme.bodyMedium!.copyWith(
              color: colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color.fromRGBO(255, 204, 128, 1),
                size: 16,
              ),
              const SizedBox(width: 4.0),
              Text(
                doctor.rating.toString(),
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.work,
                color: colorScheme.tertiary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '3 years',
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onBackground.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: FilledButton(
        onPressed: () {},
        child: const Text('Book Now'),
      ),
    );
  }
}
