type MyTree:
  Node { val, ~left, ~right }
  Leaf

def sum(tree):
  fold tree:
    case MyTree/Node:
      return tree.val + tree.left + tree.right
    case MyTree/Leaf:
      return 0

def gen(depth):
  bend height=0, val = 1:
    when height < depth:
      tree = MyTree/Node { val: val, left: fork(height+1, 2*val), right: fork(height+1, 2*val+1) }
    else:
      tree = MyTree/Leaf
  return tree

def main(n):
  return sum(gen(n))
