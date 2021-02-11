  
class Okul:
  def __init__(self,name,location):
    self.name = name
    self.location = location

  def printschool(self):
    print(self.name, self.location)

class Personel(Okul):
  def __init__(self,name,lastname,id):
    self.name=name
    self.lastname=lastname
    self.id=id
  
  def show(self):
    print(self.name, self.lastname, self.id)

class Ogretmen(Personel):
  def __init__(self,name,lastname,id,brans):
    super().__init__(name, lastname,id)
    self.brans=brans

  def printstaff(self):
    print(self.name, self.lastname, self.id,self.brans)

class Ogrenci:
  def __init__(self,name,lastname,id,gecmenotu=[]):
    self.name=name
    self.lastname=lastname
    self.id=id
    self.gecmenotu=gecmenotu
  
  def printstaff(self):
    print(self.name, self.lastname, self.id,self.gecmenotu)

x=Okul("Mustafa Kemal İ.O","Ankara")
y=Okul("Mehmet Akif Ersoy İ.O","Antalya")
z=Okul("İsmet İnönü İ.O","Samsun")

p1=Ogretmen("Huseyin","Kaya","123","Matematik")
p2=Personel("Hasan","Kaya","123")

x.location="Bursa"
x.name="Kazım Karabekir İ.O"
p1.brans="Beden"

x.printschool()
p1.show()
p1.printstaff()