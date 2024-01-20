

class OgrenciPanelConstantsStrings{
OgrenciPanelConstantsStrings._();
static OgrenciPanelConstantsStrings get init{
_init??=OgrenciPanelConstantsStrings._();
return _init!;
}
static OgrenciPanelConstantsStrings ? _init;

final String pageTitle  ="Ögrenci Giris Ekranı";  
final String kullaniciTextFieldHintText  ="Kullanici Adinizi Giriniz";  
final String passwordTextFieldHintText  ="Sifrenizi Giriniz";  
final String buttonTitle = "Giris";
final String alertTitle = "Ogrenci Sistem Sifre Belirleme";
final String  newPasswordTextFieldHintText= "6 Haneli Sifre Giriniz";
final String  newRepeatPasswordTextFieldHintText = "Sifreyi Tekrar Giriniz";
final String alertButtonText1 = "Reset";
final String alertButtonText2 = "Confirm";


void dispose()
{
   _init = null;
}

}