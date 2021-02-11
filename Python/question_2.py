import re

while True:
  uzunluk = int(input("Uzantı uzunluğunu giriniz : "))
  mail = input("Mail adresinizi giriniz : ")
  bol=mail.split("@")
  x = re.findall("[^A-Za-z0-9_-]", bol[0])
  try:
    uzantı=bol[1].split(".")
    print(len(uzantı))
  except:
    print("Uzantı geçersiz")
  finally:
    break


  
def mailCheck(mail):
  if (uzunluk>3 or uzunluk<=0) or bol[0]=="" or "@" not in  mail or len(x)>0 or len(uzantı)!=uzunluk:
    #Ödevde açık var. Uzantı uzunluğu geçse bile verilen mailde uzantı uzunluğunun eşit olup olmadığı sonra tekrar kontrol edilmeli aksi taktirde uzunluğa 2 verilse Gaziuniversitesi@gazi.edu.tr adresi uzantısı 3 olur o nedenle geçersiz der
    return False
  else:
    return True



result = mailCheck(mail)

if(result):
  print("Mail adresiniz doğrudur.")
else:
  print("Mail adresiniz yanlıştır.")