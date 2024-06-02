import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MySkeleton extends StatelessWidget {
  const MySkeleton({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}

class MyArticleSkeleton extends StatelessWidget {
  const MyArticleSkeleton({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                width: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                width: 170,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    width: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 70,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class MyAdSkeleton extends StatelessWidget {
  const MyAdSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }
}

class MyMedecineCardSkeleton extends StatelessWidget {
  const MyMedecineCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }
}

class MyDoctorCardSkeleton extends StatelessWidget {
  const MyDoctorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }
}
