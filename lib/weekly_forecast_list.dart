import 'package:flutter/material.dart';
import 'models.dart';

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecast;

  const WeeklyForecastList({super.key, required this.weeklyForecast});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final daily = weeklyForecast.daily;
          if (daily == null) {
            return const SizedBox();
          }
          final highTemp = daily.temperature2MMax![index];
          final lowTemp = daily.temperature2MMin![index];
          final description = WeatherCode.fromInt(daily.weatherCode![index]).description;
          final date = DateTime.parse(daily.time![index]);

          return Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: <Color>[
                              Colors.grey[800]!,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: Placeholder(),
                        /*child: Image.network(
                          dailyForecast.imageId,
                          fit: BoxFit.cover,
                        ),*/
                      ),
                      Center(
                        child: Text(
                          date.day.toString(),
                          style: textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          weekdayAsString(date),
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(description),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$highTemp | $lowTemp C',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 7,
      ),
    );
  }

  String weekdayAsString(DateTime time) {
    return switch (time.weekday) {
      DateTime.monday => 'Monday',
      DateTime.tuesday => 'Tuesday',
      DateTime.wednesday => 'Wednesday',
      DateTime.thursday => 'Thursday',
      DateTime.friday => 'Friday',
      DateTime.saturday => 'Saturday',
      DateTime.sunday => 'Sunday',
      _ => ''
    };
  }
}
