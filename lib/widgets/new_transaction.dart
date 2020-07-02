import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTn;

  NewTransaction(this.addTn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submit() {
    final stitle = _titleController.text;
    final samount = double.parse(_amountController.text);

    if (stitle.isEmpty || samount.isNaN || _selectedDate == null) {
      return;
    } else {
      widget.addTn(stitle, samount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (date) {
        if (date == null) {
          return;
        }
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.grey[900],
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onSubmitted: (_) => _submit(),
                style: TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  labelText: "Title :",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Enter Title",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                controller: _titleController,
                // onChanged: (val) => titleInput = val,
              ),
              TextField(
                onSubmitted: (_) => _submit(),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  labelText: "Amount :",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Enter Amount",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Chosen!"
                            : DateFormat("dd/MM/yyyy").format(_selectedDate),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.white,
                      onPressed: _presentDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.black,
                child: Text("Save Transaction"),
                textColor: Colors.white,
                onPressed: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
