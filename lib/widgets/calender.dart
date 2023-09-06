import 'package:calendar_builder/calendar_builder.dart';
import 'package:flutter/material.dart';
import 'package:todoey_flutter/screens/reminder.dart';

class MonthBuilderScreen extends StatelessWidget {
  MonthBuilderScreen({Key? key}) : super(key: key);
  String? date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: CbMonthBuilder(
              cbConfig: CbConfig(
                  startDate: DateTime(2020),
                  endDate: DateTime(2123),
                  selectedDate: DateTime.now(),
                  selectedYear: DateTime(2023),
                  weekStartsFrom: WeekStartsFrom.monday,
                  disabledDates: [
                    DateTime(2022, 1, 7),
                    DateTime(2022, 1, 9),
                  ],
                  eventDates: [
                    DateTime(2022, 1, 2),
                    DateTime(2022, 1, 2),
                    DateTime(2022, 1, 3)
                  ],
                  highlightedDates: [
                    DateTime(2022, 1, 6),
                    DateTime(2022, 1, 3)
                  ]),
              monthCustomizer: MonthCustomizer(
                  padding: const EdgeInsets.all(20),
                  monthHeaderCustomizer: MonthHeaderCustomizer(
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  monthButtonCustomizer: MonthButtonCustomizer(
                      currentDayColor: Colors.orange,
                      borderStrokeWidth: 2,
                      textStyleOnDisabled: const TextStyle(color: Colors.red),
                      highlightedColor: const Color.fromARGB(255, 255, 174, 0)),
                  monthWeekCustomizer: MonthWeekCustomizer(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 174, 0)))
                  // monthWidth: 500,
                  // monthHeight: 200
                  ),
              yearDropDownCustomizer: YearDropDownCustomizer(
                  yearButtonCustomizer: YearButtonCustomizer(
                    borderColorOnSelected: Colors.red,
                  ),
                  yearHeaderCustomizer: YearHeaderCustomizer(
                      titleTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 174, 0)))),
              onYearHeaderExpanded: (isExpanded) {},
              onDateClicked: (onDateClicked) {
                date = onDateClicked.selectedDate.day.toString() +
                    "-" +
                    onDateClicked.selectedDate.month.toString() +
                    "-" +
                    onDateClicked.selectedDate.year.toString();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SQLiteExample(
                      date: date,
                    ),
                  ),
                );
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TasksScreen(
                //       date: date,
                //     ),
                //   ),
                // );
                // print('selected date' +
                //     onDateClicked.selectedDate.toString() +
                //     '\n' +
                //     'isSelected ' +
                //     onDateClicked.isSelected.toString() +
                //     '\n' +
                //     'isHighlighted ' +
                //     onDateClicked.isHighlighted.toString() +
                //     '\n' +
                //     'hasEvent ' +
                //     onDateClicked.hasEvent.toString() +
                //     '\n' +
                //     'isCurrentDate ' +
                //     onDateClicked.isCurrentDate.toString() +
                //     '\n' +
                //     'isDisabled ' +
                //     onDateClicked.isDisabled.toString());
              },
              onYearButtonClicked: (year, isSelected) {},
            )),
          ],
        ),
      ),
    );
  }
}
