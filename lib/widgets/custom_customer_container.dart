import 'package:flutter/material.dart';

class CustomCustomerContainer extends StatelessWidget {
  const CustomCustomerContainer({
    super.key,
    required this.height,
    required this.width,
    required this.name,
    required this.date,
    required this.choice,
    required this.money,
  });

  final double height;
  final double width;
  final String name;
  final String date;
  final int choice;
  final String money;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .13,
      width: width * .88,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(
          right: BorderSide(
            color: choice == 0
                ? Colors.grey
                : choice == 1
                ? Color.fromARGB(255, 255, 126, 100)
                : Color.fromARGB(255, 112, 255, 136),
            width: 5,
          ),
          left: BorderSide(color: Theme.of(context).colorScheme.surface),
          bottom: BorderSide(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                money,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: choice == 0
                      ? Colors.grey
                      : choice == 1
                      ? Color.fromARGB(255, 255, 126, 100)
                      : Color.fromARGB(255, 112, 255, 136),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("اخر حركة: $date"),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: choice == 0
                      ? Theme.of(context).colorScheme.surface
                      : choice == 1
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  choice == 0
                      ? "مصفى"
                      : choice == 1
                      ? "عليه دين"
                      : "له رصيد",
                  style: choice == 0
                      ? const TextStyle(fontSize: 12, color: Colors.grey)
                      : choice == 1
                      ? const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 255, 126, 100),
                        )
                      : const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 62, 255, 94),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
