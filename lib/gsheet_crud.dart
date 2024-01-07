import 'package:gsheed_crud_backend_demo/gsheet_setup.dart';

insertDataIntoSheet(userDetailsList) async {
  await gsheetCrudUserDetails!.values.map.appendRows(userDetailsList);
  print('Data Stored');
}

List dataFromSheet = [];

readDataFromSheet() async {
  dataFromSheet = (await gsheetCrudUserDetails!.values.map.allRows())!;
  print('Data Fetched');
}

updateDataFromSheet() async {
  await gsheetCrudUserDetails!.values.map.insertRowByKey(
      '145342xxHa2Vr7Ax', {'name': 'Flutter Plabs Name Updated'});
  print('Data Updated');
}

deleteDataFromSheet() async {
  final index =
      await gsheetCrudUserDetails!.values.rowIndexOf('311936kTc4YpmXv');

  await gsheetCrudUserDetails!.deleteRow(index);

  print('Row Deleted');
}
