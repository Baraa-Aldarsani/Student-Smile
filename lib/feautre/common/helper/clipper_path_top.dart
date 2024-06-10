import 'package:flutter/material.dart';

class RPSCustomPainterTop extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  
  Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(125, 51, 163, 189)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0005600,size.height*0.0307162);
    path_0.quadraticBezierTo(size.width*0.5649067,size.height*-0.0283514,size.width*0.6374933,size.height*0.1017027);
    path_0.quadraticBezierTo(size.width*0.7067733,size.height*0.2417838,size.width*0.9998667,size.height*0.2461622);
    path_0.lineTo(size.width*1.0025333,size.height*-0.0024865);
    path_0.lineTo(size.width*0.0004000,size.height*-0.0035676);
    path_0.lineTo(size.width*0.0005600,size.height*0.0307162);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
  

  // Layer 1
  
  Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    
    canvas.drawPath(path_0, paintStroke0);
  

  // Layer 1
  
  Paint paintFill1 = Paint()
      ..color = const Color.fromARGB(125, 51, 163, 189)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    Path path_1 = Path();
    path_1.moveTo(size.width*-0.0006933,size.height*0.0213919);
    path_1.quadraticBezierTo(size.width*0.3640267,size.height*0.0174730,size.width*0.5868000,size.height*0.1009054);
    path_1.quadraticBezierTo(size.width*0.7686133,size.height*0.1715946,size.width*1.0005333,size.height*0.1699730);
    path_1.lineTo(size.width*1.0006933,size.height*-0.0042703);
    path_1.lineTo(size.width*-0.0007733,size.height*-0.0045405);
    path_1.lineTo(size.width*-0.0006933,size.height*0.0213919);
    path_1.close();

    canvas.drawPath(path_1, paintFill1);
  

  // Layer 1
  
  Paint paintStroke1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    
    canvas.drawPath(path_1, paintStroke1);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
