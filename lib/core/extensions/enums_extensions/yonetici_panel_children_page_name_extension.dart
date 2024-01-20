
import '../../enums/yonetici_panel_children_pages_name_enum.dart';

extension YoneticiPageChildrenPageNameExtension on YoneticiPageChildrenPageName {
    String get getName {
             switch(this)
             {
                case YoneticiPageChildrenPageName.ayarlar:
                return "Ayarlar";
                case YoneticiPageChildrenPageName.islemKayitleri:
                return "Gecmis Islemler";
                case YoneticiPageChildrenPageName.kullanicilar:
                return "Sistemdeki Kullanıcılar";
                case YoneticiPageChildrenPageName.kullaniciEkle:
                return "Kullanici Ekle";

             }
    }
}