-module(misc).
-author("abrinza").
-include("assertion.hrl").

%% API
-export([test/0,
  forAll/2,
  for/3,
  sum/1,
  map/2,
  concatTwoLists/2,
  filter/2,
  tupleToList/1,
  reverse_binary/1,
  listContains/2,
  printList/1,
  removeIf/2,
  findMin/1,
  list_size/1,
  check_prelast_elem/2,
  reverse_list/1]).

test() ->
  ?assertEquals([10, 20, 30], forAll(fun(Val) -> Val * 10 end, [1, 2, 3])),
  ?assertEquals([10, 20, 30, 40, 50], for(1, 5, fun(Val) -> Val * 10 end)),
  ?assertTrue(50 == sum([30, 20])),
  ?assertEquals([2, 3, 4, 5], map(fun(Val) -> (Val div 5) end, [10, 15, 20, 25])),
  ?assertEquals(50, rec_sum([10, 20, 20])),
  ?assertEquals([1, 2, 3], concatTwoLists([1, 2], [3])),
  ?assertEquals([3, 2, 1], reverse_list([1, 2, 3])),
  ?assertTrue(check_prelast_elem([1, 2, 3, 4, 5], 4)),
  ?assertFalse(check_prelast_elem([1, 2, 3, 4, 5], 3)),
  'All Tests Passed'.

forAll(Function, [H | T]) -> [Function(H) | forAll(Function, T)];
forAll(_Function, []) -> [].

for(Max, Max, Function) -> [Function(Max)];
for(It, Max, Function) -> [Function(It) | for(It + 1, Max, Function)].

concatTwoLists([H | T], Tail) -> [H | concatTwoLists(T, Tail)];
concatTwoLists([], Tail) -> Tail.

%% Simple recursion (wrong)
sum([H | T]) -> H + sum(T);
sum([]) -> 0.

rec_sum(L) -> rec_sum(L, 0).
rec_sum([H | T], Sum) -> rec_sum(T, H + Sum);
rec_sum([], Sum) -> Sum.

map(F, L) -> [F(H) || H <- L].

filter(P, [H | T]) ->
  case P(H) of
    true -> [H | filter(P, T)];
    false -> filter(P, T)
  end.

listContains(Val, [H | T]) ->
  case Val =:= H of
    true -> true;
    false -> listContains(Val, T)
  end;
listContains(_, []) -> false.

printList([H | T]) -> io:fwrite(H), printList(T);
printList([]) -> done.

removeIf(F, [H | T]) ->
  case F(H) of
    true -> removeIf(F, T);
    false -> [H | removeIf(F, T)]
  end;
removeIf(_, []) -> [].

findMin([H | T]) -> findMin(T, H).

findMin([H | T], MinValue) ->
  case H < MinValue of
    true -> findMin(T, H);
    false -> findMin(T, MinValue)
  end;
findMin([], MinValue) -> MinValue.

tupleToList(Tuple) -> tupleToList(Tuple, size(Tuple), []).
tupleToList(Tuple, S, L) when S =/= 0 -> tupleToList(Tuple, S - 1, [element(S, Tuple) | L]);
tupleToList(_, 0, L) -> L.

reverse_binary(X) when is_binary(X) ->
  list_to_binary(lists:reverse(binary_to_list(X)));
reverse_binary(_) -> error('Not a binary').

list_size(List) -> list_size(List, 0).

list_size([_ListElement | OtherElements], Size) -> list_size(OtherElements, Size + 1);
list_size([], Size) -> Size.

reverse_list(L) -> reverse_list(L, []).

reverse_list([H | T], List) -> reverse_list(T, [H | List]);
reverse_list([], List) -> List.

check_prelast_elem(GivenList, ValueToFind) when is_list(GivenList)
  -> ReversedList = lists:reverse(GivenList),
  [_LastValue, TestValue | _] = ReversedList,
  TestValue == ValueToFind.