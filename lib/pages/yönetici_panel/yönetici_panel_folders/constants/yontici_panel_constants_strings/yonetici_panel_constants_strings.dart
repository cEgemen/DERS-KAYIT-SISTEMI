
class YoneticiPanelConstantsStrings{
YoneticiPanelConstantsStrings._();
static YoneticiPanelConstantsStrings get init{
_init??=YoneticiPanelConstantsStrings._();
return _init!;
}
static YoneticiPanelConstantsStrings ? _init;
  final String pageTitle  ="Yönetici Giris Ekranı";  
final String kullaniciTextFieldHintText  ="Kullanici Adinizi Giriniz";  
final String passwordTextFieldHintText  ="Sifrenizi Giriniz";  
final String buttonTitle = "Giris";
final String alertTitle = "Yönetici Sistem Sifre Belirleme";
final String  newPasswordTextFieldHintText= "6 Haneli Sifre Giriniz";
final String  newRepeatPasswordTextFieldHintText = "Sifreyi Tekrar Giriniz";
final String alertButtonText1 = "Reset";
final String alertButtonText2 = "Confirm";

  

  void dispose()
  {
    _init = null;
  }
 
}