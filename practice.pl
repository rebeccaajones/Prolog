:-use_module(library(lists)).

% Rebecca Anne Jones 2012


%---------------------------------------------
% Q1
%---------------------------------------------

subList([],_).
subList([H|T],L2):- member(H,L2),subList(T,L2).



%---------------------------------------------
% Q2 a)
%---------------------------------------------

intersect_a(L1,L2,I):-  setof(L1v,(member(L1v,L1),subList([L1v],L2)),L)
                        -> I=L; I=[].



%---------------------------------------------
% Q2 b)
%---------------------------------------------

acc(V,[V|T],N,C):- M is N+1, acc(V,T,M,C).
acc(V,[H|T],N,C):- V\=H, acc(V,T,N,C).
acc(V,[],N,N).
count_occ(V, L2, C):- acc(V,L2,0,C).

remove_counts([],[]).
remove_counts([H1-H2|T],L) :- remove_counts(T,L2),append([H2],L2,L).

intersect_b(L1,L2,I):-  setof(C-L1v,  (member(L1v,L1),subList([L1v],L2), count_occ(L1v,L2,C))  ,L)
                        -> remove_counts(L,I);I=[].



%---------------------------------------------
% Q3
%---------------------------------------------

disjoint(L1,L2):- (L1\=[];L2\=[]),intersect_b(L1,L2,[]).



%---------------------------------------------
% Q4
%---------------------------------------------

difference(L1,L2,L):- findall(L1v, (member(L1v,L1),\+member(L1v,L2)) ,L).



%---------------------------------------------
% Q5
%---------------------------------------------

sift(L,N,Result):-findall(L1, (member(L1,L),L1=<N) ,Result).




%---------------------------------------------
% Q6
%---------------------------------------------

process(L1,L2,Consistent, Inconsistent):-   get_consistent_list(L1,L2,Consistent),
                                            get_inconsistent_list(L1,L2,Inconsistent).

get_consistent_list(L1,L2,List):- findall((H1,H2,H3), (append(_,[(H1,H2)|_],L1),append(_,[(H1,H2,H3)|_],L2))  ,List).

get_inconsistent_list(L1,L2,List):- findall((H1,H2,H3),  (member(M,L2),M = (H1,H2,H3), N = (H1,H2),\+member(N,L1))  ,List).


