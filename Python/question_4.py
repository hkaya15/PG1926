list=[]
teklist=[]
i=0
while True:
  print("**Sayı girişi için 1'e basınız**")
  print("**En büyük tek sayıyı görmek için 2'e basınız**")
  print("**Çıkış-3**")
  

  tercih=int(input("Tercihiniz : "))
  if(tercih==2):
    if len(list)==0:
      print("Boş Liste")
    else:
      while i<len(list):
        a=list[i]
        i+=1
        if int(a)%2 != 0:
          
          teklist.append(int(a))
      print(max(teklist))

  elif(tercih==1):
    while True:
      print("***Tamamlamak için q'ya basın***")
      print("------------------")
      sayi=input("Sayı giriniz : ")
      if(sayi=="q"):
        break
      else:
        x = sayi.isnumeric()
        if(x):
          list.append(sayi)
          print("liste : "+str(list))
        else:
          print("Sayı değil siliyorum")
          del sayi
  elif(tercih==3):
    break
  else:
    print("Geçersiz sistem")