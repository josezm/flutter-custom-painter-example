import 'package:custom_painter_test/CustomChart/custom_chart_painter.dart';
import 'package:flutter/material.dart';

class CustomChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          // height: 500,
          color: Colors.black87,
          child: CustomPaint(
            size: Size(
                500,
                (500 * 0.7)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: CustomChartPainter(
                data: [0, 50, 40, 60, 80, 100, 65],
                tags: ['Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab', 'Dom']),
          ),
        ),
      ),
    );
  }
}
