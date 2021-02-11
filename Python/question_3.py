list=[]
i=0
while True:
  print("""İŞLEM SEÇİNİZ""")
  print("""************ 1 - Sıfırı Taşı ***************""")
  print("""************ 2 - Listeyi Gör ***************""")
  print("""************ 3 - Çıkış ***************""")
  islem = int(input("İşlem tercihiniz : "))
  if islem==3:
    break
  elif islem==1:
    print("Sayı girişini tamamlamak için q ' ya basınız...'")
    while True:
      sayi = input("Sayı giriniz : ")
      if(sayi=="q"):
        break 
      else:
        list.append(sayi)
        #sosyal mesafe     
        while i<len(list):
          if int(list[i])==0:
            list.pop()
            list.insert(0, 0)
            i+=1
          else:
            i+=1
            continue
  elif islem ==2:
    if len(list)==0:
      print("Boş Liste")
    else:
      print(list)  
  else:
    print("Geçersiz işlem")