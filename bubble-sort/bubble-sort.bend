def sort(xs):
  match xs:
    case List/Nil: 
      return List/Nil
    case List/Cons: 
      return insert(xs.head, sort(xs.tail))

def insert(v, xs):
  match xs:
    case List/Nil:
      return List/Cons(v, List/Nil)
    case List/Cons:
      return swap_gt(v, xs.head, xs.tail)

def swap_gt(v, x, xs):
  if x > v:
    return List/Cons(v, List/Cons(x, xs))
  else:
    return List/Cons(x, insert(v, xs))


def rnd(n):
  bend n, state=1:
    when n != 0:
      state = state ^ (state << 13)
      state = state ^ (state >> 17)
      state = state ^ (state << 5)
      return List/Cons(state % 100, fork(n - 1, state))
    else:
      return List/Nil

def sum(xs):
  fold xs:
    case List/Nil:
      return 0
    case List/Cons:
      return xs.head + xs.tail

def main:
  n = 100
  return sum(sort(rnd(n)))

