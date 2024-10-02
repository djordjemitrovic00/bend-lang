type MyTree = Leaf | (Node lft val rgt)

(Sort List/Nil) = MyTree/Leaf
(Sort (List/Cons head tail)) =
  ((Part head tail) λmin λmax
    let lft = (Sort min)  
    let rgt = (Sort max)
    (MyTree/Node lft head rgt))

  (Part p List/Nil) = λt (t List/Nil List/Nil)
  (Part p (List/Cons head tail)) = (Push (> head p) head (Part p tail))

  (Push 0 x pair) = (pair λmin λmax λp (p (List/Cons x min) max))
  (Push _ x pair) = (pair λmin λmax λp (p min (List/Cons x max)))

(Rnd 0 state) = List/Nil
(Rnd n state) =
  let state = (^ state (<< state 13))
  let state = (^ state (>> state 17))
  let state = (^ state (<< state 5))
  (List/Cons state (Rnd (- n 1) state))

(Sum MyTree/Leaf) = 0
(Sum (MyTree/Node lft val rgt)) = (+ val (+ (Sum lft) (Sum rgt)))

(Main n) = (Sum (Sort (Rnd (<< 1 n) 1)))
