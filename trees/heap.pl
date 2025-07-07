heapify(void, void).
heapify(tree(X, L, R), Heap) :-
  heapify(L, HeapL), heapify(R, HeapR), adjust(X, HeapL, HeapR, Heap).

adjust(X, HeapL, HeapR, tree(X, HeapL, HeapR)) :- greater(X, HeapL), greater(X, HeapR).
adjust(X, tree(Xl, L, R), HeapR, tree(Xl, HeapL, HeapR)) :-
  Xl > X, greater(Xl, HeapR), adjust(X, L, R, HeapL).
adjust(X, HeapL, tree(Xr, L, R), tree(Xr, HeapL, HeapR)) :-
  Xr > X, greater(Xr, HeapL), adjust(X, L, R, HeapR).

greater(_, void).
greater(X,tree(X1,_,_)) :- X >= X1. 