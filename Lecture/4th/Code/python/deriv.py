from math import sin, cos

class Derivative:
    def __init__(self, f):
        self.f = f

    def __call__(self, x, h=1e-06):
        return (self.f(x + h) - self.f(x)) / h

def main():
    dsin = Derivative(sin)
    print("dsin=",[dsin(x) for x in range(0, 7)])
    print("cos=", [cos(x) for x in range(0, 7)])
    ddsin = Derivative(dsin)
    print()
    print([ddsin(x) for x in range(0, 7)])
    print([-sin(x) for x in range(0, 7)])

if __name__ == '__main__':
    main()
