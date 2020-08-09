import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          )
        )
      ),
      title: 'Personal Expenses',
      home: HomePage() ,
    );
  }
}

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction= [
    // Transaction(id: 't1', title: 'shoes', amount: 120.0, date: DateTime.now(),),
    // Transaction(id: 't1', title: 'shoes', amount: 120.0, date: DateTime.now(),),
  ];

  List<Transaction> get _recentTransaction{
    return _userTransaction.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days:7)),
      );
    }



    ).toList();
  }
  void _addTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newtx= Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: chosenDate,);
setState(() {
  _userTransaction.add(newtx);
});

  }
  void _startAddnewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addTransaction),
        behavior: HitTestBehavior.opaque,
        );
        
    },);
  }
  void _delete(String id){
    setState(() {
      return _userTransaction.removeWhere((tx) => tx.id==id);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Kharcha Paani'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed: ()=> _startAddnewTransaction(context),)
        ],
      ),
          body: SingleChildScrollView(
                      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     child: Text('Bar'),
            //     color: Colors.cyan,
            //     elevation: 5,
            //   ),
            // ),
            Chart(_recentTransaction),
           TransactionList(_userTransaction,_delete),
            
            

        ],
        
      ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: ()=> _startAddnewTransaction(context),),
    );
  }
}