import 'package:mobx/mobx.dart';

import '../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../core/services/sql_select_service.dart';
import '../../../hoca_panel_folder/model/hoca_model.dart';

part 'hoca_setup_view_model.g.dart';

class HocaSetupViewModel = _HocaSetupViewModelBase with _$HocaSetupViewModel;

abstract class _HocaSetupViewModelBase with Store {
  int ? minVerilecekDers;
  int ? maxVerilecekDers;
  int ? minIlgiAlani;

  List<dynamic> _modelValuesList = [];
  HocaModel? _model;
  
  @observable
  List<Map<String , dynamic>> _ilgiAlanlari = [];

  @observable
  bool _isModelLoading = false;

  @observable
  bool _isIlgiAlanlariLoading  = false;

  @observable
  bool _isDerslerLoading  = false;

  @observable
  List<Map<String , dynamic>> _dersler = [];

  List<dynamic>? get modelValues => _modelValuesList;
  List<Map<String , dynamic>> get ilgiAlanlari => _ilgiAlanlari;
  List<Map<String , dynamic>> get dersler => _dersler;
  HocaModel? get model => _model;
  bool get isModelLoading => _isModelLoading;
  bool get isIlgiAlanleriLoading => _isIlgiAlanlariLoading;
  bool get isDerslerLoading => _isDerslerLoading;


  @action
  Future<void> getCurrentUser(int id, SqlTableName tableName) async {
    _isModelLoading = true;
    _modelValuesList = await SqlSelectService.getUser(id, tableName);
    _model = HocaModel.fromListToModel(_modelValuesList);
    _isModelLoading = false;
  }
   
  Future<void> getSistemAyarlari() async
  {
     final sistemData  = await SqlSelectService.getSistemAyarlari();
     minVerilecekDers =int.parse( sistemData[2] );
     minIlgiAlani =int.parse(sistemData[1]);
     maxVerilecekDers = int.parse (sistemData[3] );
  }


  @action
  Future<void> getAllIlgiAlani() async
  {
       _isIlgiAlanlariLoading =true;
       _ilgiAlanlari = await SqlSelectService.getAllIlgiAlani();
        _isIlgiAlanlariLoading =false;
  } 
  

  @action
  Future<void> getAllDersler() async
  {
       _isDerslerLoading =true;
       _dersler = await SqlSelectService.getAllDersler();
       _isDerslerLoading =false;
  } 

 
 
}