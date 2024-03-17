import 'package:flutter/material.dart';
import 'models.dart'; // Make sure this path is correct for your project

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecast;

  const WeeklyForecastList({super.key, required this.weeklyForecast});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final daily = weeklyForecast.daily;
          if (daily == null || daily.temperature2MMax == null || daily.temperature2MMin == null || daily.weatherCode == null || daily.time == null) {
            return const SizedBox.shrink();
          }
          final highTemp = daily.temperature2MMax![index];
          final lowTemp = daily.temperature2MMin![index];
          final description = WeatherCode.fromInt(daily.weatherCode![index]).description;
          final date = DateTime.parse(daily.time![index]);
          final weatherUrl = WeatherCode.fromInt(daily.weatherCode![index]).imageUrl;

          return Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // This adds padding around the SizedBox
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Use the smallest dimension to keep the aspect ratio of the SizedBox as 1:1
                        final size = constraints.maxHeight < constraints.maxWidth ? constraints.maxHeight : constraints.maxWidth;
                        return SizedBox(
                          height: size - 16, // Adjusted for padding
                          width: size - 16, // Adjusted for padding
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(weatherUrl),
                              Center(
                                child: Text(
                                  date.day.toString(),
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: Colors.white, // Ensure text color is white for better contrast
                                    // Adding a faint white glow behind the text
                                    shadows: [
                                      Shadow(
                                        blurRadius: 15.0,
                                        color: Colors.black.withOpacity(1),
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(description, style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          '$highTemp | $lowTemp °C',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
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
    _ => '',
    };
  }
}
