
class HocaPanelConstantsStrings{
HocaPanelConstantsStrings._();
static HocaPanelConstantsStrings get init{
_init??=HocaPanelConstantsStrings._();
return _init!;
}
static HocaPanelConstantsStrings ? _init;
 
final String pageTitle  ="Hoca Giris Ekranı";  
final String kullaniciTextFieldHintText  ="Kullanici Adinizi Giriniz";  
final String passwordTextFieldHintText  ="Sifrenizi Giriniz";  
final String buttonTitle = "Giris";
final String alertTitle = "Hoca Sistem Sifre Belirleme";
final String  newPasswordTextFieldHintText= "6 Haneli Sifre Giriniz";
final String  newRepeatPasswordTextFieldHintText = "Sifreyi Tekrar Giriniz";
final String alertButtonText1 = "Reset";
final String alertButtonText2 = "Confirm";


void dispose()
{
   _init = null;
}
}