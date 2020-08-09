import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletetx;
  TransactionList(this.transaction,this.deletetx);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transaction.isEmpty? Column(
        children: <Widget>[
          Text('You have spent nothing yet!',
          style: Theme.of(context).textTheme.title,
          
          ),
          SizedBox(height:20),
          Container(
            height: 200,
            child: Image.asset('assets/images/zero1.png'))
        ],
        
      ) 
      : ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
                      child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\$${transaction[index].amount}'),
                  ),
                ),
              ),
              title: Text(transaction[index].title,
              style: Theme.of(context).textTheme.title,),

              subtitle: Text(DateFormat.yMMMd().format( transaction[index].date),
              ),
              trailing: IconButton(icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
               onPressed: () => deletetx(transaction[index].id)),
              
            ),
          );

        },
        itemCount: transaction.length,
              
      ),
    );
      
    
  }
}