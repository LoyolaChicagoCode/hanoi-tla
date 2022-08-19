---- MODULE hanoi ----
EXTENDS TLC, Sequences, Integers

(* --algorithm hanoi

variables 
  full = <<1, 2, 3, 4>>,
  tower = <<full, <<>>, <<>>>>, 

define 
  D == DOMAIN tower
end define;

begin
while TRUE do
  assert tower[3] /= full;
  with from \in {x \in D : tower[x] /= <<>>},
       to \in {
                y \in D : 
                  \/ tower[y] = <<>>
                  \/ Head(tower[from]) < Head(tower[y])
              } 
  do
    tower[from] := Tail(tower[from]) ||
    tower[to] := <<Head(tower[from])>> \o tower[to];
  end with;
end while;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "7be5ed3e" /\ chksum(tla) = "d6d9ff5b")
VARIABLES full, tower

(* define statement *)
D == DOMAIN tower


vars == << full, tower >>

Init == (* Global variables *)
        /\ full = <<1, 2, 3, 4>>
        /\ tower = <<full, <<>>, <<>>>>

Next == /\ Assert(tower[3] /= full, 
                  "Failure of assertion at line 16, column 3.")
        /\ \E from \in {x \in D : tower[x] /= <<>>}:
             \E to \in {
                         y \in D :
                           \/ tower[y] = <<>>
                           \/ Head(tower[from]) < Head(tower[y])
                       }:
               tower' = [tower EXCEPT ![from] = Tail(tower[from]),
                                      ![to] = <<Head(tower[from])>> \o tower[to]]
        /\ full' = full

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 
====
