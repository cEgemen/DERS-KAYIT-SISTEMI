
import '../../enums/panel_names_enum.dart';

extension PanelNameExtension on PanelNameEnum {
    String get panelName {
       switch(this)
       {
           case PanelNameEnum.hocaPanel:
           return "Hoca Paneli";
           case PanelNameEnum.ogrenciPanel:
           return "Ögrenci Paneli";
           case PanelNameEnum.yoneticiPanel:
           return "Yönetici Paneli";
            case PanelNameEnum.talepOlusturanOgrencilerPanel:
           return "Talep Olusturanlar";
           case PanelNameEnum.dersiAlanOgrencilerPaneli:
           return "Dersi Alanlar";
           case PanelNameEnum.hocaninDersiniAlanFakatBostaOlanOgrencilerPaneli:
           return "Dersi Almayıp Bosta Olanlar";
              case PanelNameEnum.derslerVeIlgiAlanlariPanel:
           return "Dersler Ve Ilgi Alanlari ";
           case PanelNameEnum.gecmisBilgilarPanel:
           return "Gecmis Bilgiler ";
           case PanelNameEnum.talepOlusturPanel:
           return "Talep Olusturma";
           case PanelNameEnum.talepGecmisiPanel:
           return "Talep Gecmisi";
            case PanelNameEnum.gelenTalepPanel:
           return "Gelen Talep";
       }
    }
}