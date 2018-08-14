class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def introduce(self):
        print("Name is", self.name, "age is", self.age)

def main():
    p = Person("Tae Geun", 25)
    p.introduce()

if __name__ == '__main__':
    main()
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
