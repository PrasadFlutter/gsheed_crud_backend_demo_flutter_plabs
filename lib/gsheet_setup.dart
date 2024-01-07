import 'package:gsheets/gsheets.dart';

var sheetId = 'ADD HERE YOUR GSHEET ID';

var credentials = r'''
ADD HERE YOUR CREDENTIALS JSON
''';

final gsheetinit = GSheets(credentials);

var GsheetController;

Worksheet? gsheetCrudUserDetails;

GsheetIntit() async {
  GsheetController = await gsheetinit.spreadsheet(sheetId);

  gsheetCrudUserDetails =
      await GsheetController.worksheetByTitle('gsheet_crud_demo');
}
