import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget
{
  String message;
  ProgressDialog({required this.message});


  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      backgroundColor: Colors.white54,
      child: Container(
        margin: EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),),
              SizedBox(width: 26.0,),
              Text(
                message,
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),

            ],
          ),
        ),

      ),

    );
  }
}
