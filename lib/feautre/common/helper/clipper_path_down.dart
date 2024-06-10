import 'package:flutter/material.dart';
class RPSCustomPainterDown extends CustomPainter{
  
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
    path_0.moveTo(0,size.height*0.6157635);
    path_0.quadraticBezierTo(size.width*0.3401333,size.height*0.6421182,size.width*0.4037333,size.height*0.8532020);
    path_0.quadraticBezierTo(size.width*0.4920000,size.height*1.0526478,size.width*1.0042667,size.height*0.9593596);
    path_0.lineTo(size.width,size.height*0.9987685);
    path_0.lineTo(0,size.height*0.9987685);
    path_0.lineTo(0,size.height*0.6157635);
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
    path_1.moveTo(size.width*-0.0042667,size.height*0.8620690);
    path_1.quadraticBezierTo(size.width*0.4449333,size.height*1.0487069,size.width,size.height*0.9352217);
    path_1.quadraticBezierTo(size.width,size.height*0.9536946,size.width,size.height*1.0012315);
    path_1.lineTo(0,size.height);
    path_1.lineTo(size.width*-0.0042667,size.height*0.8620690);
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
