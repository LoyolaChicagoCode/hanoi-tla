---- MODULE hanoi ----

EXTENDS TLC, Sequences, Integers

CONSTANTS TSIZE, TSPACES

VARIABLES tower

FullTower[n \in 1..TSIZE] == n \* <<1, 2, 3, ...>>

Board[n \in 1..TSPACES] == IF n = 1 THEN FullTower ELSE <<>>

D == DOMAIN tower

Init == tower = Board

Next == \E from \in { x \in D : tower[x] /= <<>> }:
          \E to \in { y \in D : 
            \/ tower[y] = <<>>
            \/ Head(tower[from]) < Head(tower[y])
          }:
            tower' = [tower EXCEPT 
              ![from] = Tail(tower[from]), 
              ![to] = <<Head(tower[from])>> \o tower[to]
            ]

Spec == Init /\ [][Next]_tower

Unsolved == TRUE

\* Unsolved == tower[TSPACES] # FullTower

====
