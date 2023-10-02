import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "flutter-gsheets-mad",
  "private_key_id": "0adbd7fb3aa1953259ea17c0f9d67f6ab771e0a3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCbAvPrGUllTyNX\n6yYJDxP36pC1bCRKHS41UrZ60JRIGMGD7ywBYg0aMDs8v20phr5DuTOEunO3HVZZ\nUWRUR6wu6FZvynjhqcaq5FEcZz8PJo5NkJJQYa367lKP0A7sH8WMKUkbA8+Dyvpi\nYKOuzW9IS78WfzP3SAVtFK0xlRkd3oyDjoQAp6LKCZz0Xv+GFZcEpZUP77gQPIHy\nE4qeo8rBTqypPPIegcbI2cIl5R4tfXOkF8yHlAFXg1xyb6lAS9EJfq9uWaeGz0K2\n6gq9ddjjPonULUKt6AD/3W/xPzPY0FmS+C3QnhnIU+31UwVS56ykKcan6tUVX+C2\ndLrrqQaFAgMBAAECggEAFihd5YU/0JN3YeHjFfhpyk5lUQmcRlvVdxnTq8qU55li\nUBGoIKp7ZPrv/McAO6dfGx8mFhrw34P6C9pulP2Jx0q+0EwI63jxRQxN69l2UhwY\ny02XHJZZ4Dyg4J3FBEumWVqtcIci6pvhHp7hxuLmvVbWgci9DOPmoqkJ+MRvSq2E\nRIZp51z2iSAGHiynqUKsc92pQ++xR20QHa8VnWxgkDFNLC/nOn7Ty8DJE/3gO4H9\nShmDhRBdvz6V4ymhcYRC6Xlkk8DyEWVqPQiHTo9f4BaCMG6VopA2bq4lredkKokj\nWczZO1reCA9aCtMzePKnmD80wd7xf5hw06gO+EX2AQKBgQDI4pUdgS2vvy6mNF/3\ncqa+3mGcVFuEF1sh0Gm2sO4GFs3mczF6MY2ApSnnabA1ANNMOy0ENNP89cLGo11z\nbcCOvCpvjpCFZ3IeievwUdkSNU5PsuyeuSD/CIDLzuc+YwFfP5XP+7gVxv4+V58S\n2X2KkE5seQuOzLw0lpv3GFEjdQKBgQDFimIpIKCzsiLozslPnti3nZKIie1BjO3Z\nY30j0aw0QRQxnteQIGHY+q4xLUKReK65HYbwlmo+G3U9qJuYHSeq3New+hZdTbmE\nTNXCV8Eb9GCIpGa7iQ7nwzS72ke5ga/99j+GDTCGqG3lHhsuQwe9pzy38K8WOmBT\nsPvj9ABE0QKBgGeCYQVv74OURkw7xosxV3wYCEHOMc2xXzLgOeh56FvY2kV5a7Aj\n4l68PAhSrAnToAyynTKCqgy48aD6wodcsRCbIl6THiKvN91Ggf01n11DfFOSxVvP\n1pGy5vKdbQf3adiTYfVmJeeKvqyO55eF26tPSimYgX0WP4/1Xu4GaKCVAoGAYjL3\ntyA8IvhD+F2Ln6QEccrIJE4EfpiTSIT3mY3KwDM12bDv0fr3CUkcvN+V/wDyQp3W\nDdWIPRWjQ6KErqqXpI2iP50i7wELXyRfAvxiyAXE00h+tW1d1oKovVW2YBaDKYl3\nbKkz3UzvTH2Z33Z865+uRHZGY5NjfVc28MvEMnECgYATMSJJFKmQoADpDMmGIRLp\nc58tXRURwWsWl99NWaOs1e5CXqQ3J5fzUI7oa8ePArzbPzPJPaVXSnuYsptdrbTt\npndCMqsPNZn0YGq/QEWG8hr3rQHbu0uEdFX6pOfpz7Z9APKrAehkl4qeqlG9+qJc\nGTU9IkVtshDmzRCUwrucBQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-mad@flutter-gsheets-mad.iam.gserviceaccount.com",
  "client_id": "116634308326967623460",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-mad%40flutter-gsheets-mad.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }
  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1mC7XTjOZN-JSfHy4JqSxxjdTgaJq_jyWJNJFrBcFqbM';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
