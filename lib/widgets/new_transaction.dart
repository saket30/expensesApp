import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addtx;

    NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    final titleController= TextEditingController();

    final amountController= TextEditingController();
    DateTime _selectedDate;

    void _submitdata(){
      final editedText=titleController.text;
      final editedAmount= double.parse(amountController.text) ;
      if(editedText.isEmpty || editedAmount<=0 || _selectedDate==null){
        return;
      }
      widget.addtx(
        editedText,
        editedAmount,
        _selectedDate,
      ) ;
      Navigator.of(context).pop();
    }
    void _datepick(){
      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now(),
      ).then((pickedDate) {
        if(pickedDate==null){
          return;
        }
        setState(() {
          _selectedDate=pickedDate;
        });
        

      });
      print('...');
    }

  @override
  Widget build(BuildContext context) {
    
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    onSubmitted: (_) => _submitdata(),

                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitdata(),
                  ),

                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                                                  child: Text(_selectedDate==null ?'OOPS! no date choosen':
                          'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                        ),
                        FlatButton(onPressed: _datepick,
                        textColor: Theme.of(context).primaryColor, 
                        child: Text('Please choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        )
                      ],

                    ),
                  ),
                  RaisedButton(onPressed: _submitdata,
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  ),
                ],
              ),

            )
          );
      
    
  }
}