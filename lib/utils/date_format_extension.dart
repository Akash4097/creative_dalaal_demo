extension DateTimeFormatting on DateTime {
  String toFormattedDate() {
    // Define month names
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    // Extract day, month, and year
    int day = this.day;
    int month = this.month;
    // int year = this.year;

    // Determine AM or PM period
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    int hour12 = hour % 12;
    if (hour12 == 0) {
      hour12 = 12;
    }

    // Format hour and minute with leading zeros if needed
    String hourString = hour12.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');
    // Get the month name
    String monthName = monthNames[month - 1];

    // Return formatted string
    return '$monthName $day, $hourString: $minuteString $period';
  }
}
