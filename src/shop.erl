-module(shop).
-author("abrinza").

%% API
-compile(export_all).

cost(apple) -> 18;
cost(newspaper) -> 5;
cost(orange) -> 25;
cost(cherry) -> 30;
cost(pc) -> 500.

total(L) -> misc:sum(
  [shop:cost(What) * Count || {What, Count} <- L]
).

count_sum([Value | Tail]) -> Value + count_sum(Tail);
count_sum([]) -> 0.

print_elements([H | T]) -> io:fwrite(H), print_elements(T);
print_elements([]) -> done.

array_length([_ | Tail]) -> 1 + array_length(Tail);
array_length([]) -> 0.

iterate_from_end([H | T]) -> iterate_from_end(T), io:fwrite(H);
iterate_from_end([]) -> begins.