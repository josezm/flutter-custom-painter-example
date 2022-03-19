import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomChartPainter extends CustomPainter {
  List<double> data;
  List<String> tags;

  CustomChartPainter({
    required this.data,
    required this.tags,
  }) : assert(data.length == tags.length);

  // List<double> data = [70, 50, 40, 70, 55, 59, 60];
  // List<String> tags = ['Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab', 'Dom'];

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );

    final textPainterList = tags
        .map((e) => TextPainter(
              text: TextSpan(
                text: e,
                style: textStyle,
              ),
              textDirection: TextDirection.ltr,
            ))
        .toList();

    Paint chartPaint = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    chartPaint.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, size.height * 0.14),
        Offset(size.width * 0.50, size.height * 1.00),
        [Color(0xff16DDD1), Color(0xff239DF5)],
        [0.00, 1.00]);

    Paint pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint pointStrokePaint = Paint()
      ..color = Color(0xff16DDD1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint dashedLinePaint = Paint()
      ..color = Colors.white38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Path path0 = Path();

    List<double> dataPercent = data
        .map((e) => (size.height / 1.5) - (((e / 100)) * (size.height / 1.5)))
        .toList();

    double gridWidth = size.width / (data.length + 1);

    double offset = gridWidth / 3;

    // Punto inicial
    path0.moveTo(0, dataPercent[0] + 50);

    // Curvas
    for (int i = 0; i < dataPercent.length; i++) {
      if (i == 0) {
        path0.cubicTo(
          offset, // offset
          dataPercent[0] + 50,
          gridWidth - offset, // X actual - offset
          dataPercent[i], // Y actual
          gridWidth,
          dataPercent[i],
        );
      } else {
        path0.cubicTo(
          gridWidth * i + offset, // X anterior + offset
          dataPercent[i - 1], // Y anterior
          gridWidth * (i + 1) - offset, // X actual - offset
          dataPercent[i], // Y actual
          gridWidth * (i + 1),
          dataPercent[i],
        );
      }
    }

    // Ultimo punto
    int lastIndex = dataPercent.length - 1;
    path0.cubicTo(
      gridWidth * (lastIndex + 1) + offset,
      dataPercent[lastIndex],
      size.width - offset,
      dataPercent[lastIndex] + 50,
      size.width,
      dataPercent[lastIndex] + 50,
    );

    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);

    canvas.drawPath(path0, chartPaint);

    double startY = 0.7;
    // Puntos lineas y letras
    for (int i = 0; i < dataPercent.length; i++) {
      canvas.drawCircle(
          Offset(gridWidth * (i + 1), dataPercent[i]), 8, pointPaint);
      canvas.drawCircle(
          Offset(gridWidth * (i + 1), dataPercent[i]), 8, pointStrokePaint);
      _drawDashedLine(canvas, size, dashedLinePaint, gridWidth * (i + 1),
          dataPercent[i], size.height * startY);

      textPainterList[i].layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainterList[i].paint(canvas,
          Offset(gridWidth * (i + 1) - 20, size.height * (startY + 0.03)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawDashedLine(
      Canvas canvas, Size size, Paint paint, double x, double y1, double y2) {
    const int dashWidth = 15;
    const int dashSpace = 10;
    y1 = y1 + 10;
    while (y1 < y2) {
      canvas.drawLine(
          Offset(x, y1),
          Offset(x, y1 + dashWidth + dashSpace > y2 ? y2 : y1 + dashWidth),
          paint);
      y1 += dashWidth + dashSpace;
    }
  }
}
