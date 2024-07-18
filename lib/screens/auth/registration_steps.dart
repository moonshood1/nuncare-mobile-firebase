import 'package:flutter/material.dart';

class RegistrationSteps extends StatelessWidget {
  const RegistrationSteps({
    super.key,
    required this.pages,
    required this.activePage,
  });

  final List<Widget> pages;
  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) {
          return StepsButton(
            isActive: index == activePage,
          );
        },
      ),
    );
  }
}

class StepsButton extends StatelessWidget {
  const StepsButton({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      height: 5,
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
