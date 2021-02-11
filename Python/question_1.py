while True:
  print("""İŞLEM SEÇİNİZ""")
  print("""************ 1 - FizzBuzz İşlemi ***************""")
  print("""************ 2 - Çıkış ***************""")
  islem = int(input("İşlem tercihiniz : "))
  if(islem==2):
    break
  elif(islem==1):
    sayi1 = int(input("İlk Sayıyı giriniz : "))
    sayi2 = int(input("İkinci Sayıyı giriniz : "))
    for sayi in range(sayi1,sayi2):
      if(sayi%15==0):
        print("FizzBuzz")
      elif(sayi%3==0):
        print("Fizz")
      elif(sayi%5==0):
        print("Buzz")
      else:
        print(sayi)
  else:
    print("Geçersiz İşlem")