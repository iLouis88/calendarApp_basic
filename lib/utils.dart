import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color_board.dart';
import 'models/event_model.dart';

final List<String> monthNames = [
  '', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
];

final List<String> weekDays  = [
  'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
];

final List<ColorPair> colorPairs = [
  ColorPair(leftColor: color2, rightColor: color3),
  ColorPair(leftColor: color4, rightColor: color5),

];

Future<void> customNavigator(BuildContext context, Widget page) async{
  Navigator.push(
    context, MaterialPageRoute(builder: (context) => page
  ));
}

const String content ='As nations better understand the transformative power of generative artificial intelligence (GenAI), Vietnam stands at the brink of a substantial opportunity.\n With its vibrant economy, youthful population, and enthusiastic uptake of cutting-edge technology, Vietnam is an ideal environment for the integration of GenAI, fostering an optimal landscape for its development and implementation.According to the Finastra Financial Services State of the Nation Survey 2023, Vietnam stands out as the frontrunner in terms of enthusiasm for generative AI, with a remarkable 91% of surveyed individuals expressing interest in the technology. This percentage is the highest among all the markets included in the survey. \nStatista Market Insights also projects that the Vietnamese generative AI market is anticipated to reach USD 153.80 million in 2024. The forecast suggests an annual growth rate (CAGR 2024-2030) of 23.20%, leading to a market volume of USD 537.70 million by 2030.';