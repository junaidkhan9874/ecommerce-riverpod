import 'package:flutter/material.dart';

class Utils {
  String fontFamily = 'Poppins';

  normalPoppins(text, size, color, align, {maxlines}) {
    return Text(text,
      textAlign: align,
      maxLines: maxlines,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: color,
          fontFamily: fontFamily
      ),
    );
  }

  mediumPoppins(text, size, color, align, {maxlines}) {
    return Text(text,
      textAlign: align,
      maxLines: maxlines,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
          color: color,
          fontFamily: fontFamily
      ),);
  }
  boldPoppins(text,size,color,align)
  {
    return Text(text,
      textAlign: align,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          color: color,
          fontFamily: fontFamily
      ),);

  }
  semiBoldPoppins(text,size,color,align)
  {
    return Text(text,
      textAlign: align,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          color: color,
          fontFamily: fontFamily
      ),);

  }
}