def fib(n):
  switch n:
    case 0:
      return 0
    case 1:
      return 1
    case _:
      return fib(n - 2) + fib(n - 1)

def main():
  return fib(40)
