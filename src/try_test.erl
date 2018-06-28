%%%-------------------------------------------------------------------
%%% @author abrinza
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Jul 2018 9:26 AM
%%%-------------------------------------------------------------------
-module(try_test).
-author("abrinza").
-test("No Test").
%% API
-compile(export_all).

demo1() -> [catcher(I) || I <- [1, 2, 3, 4, 5, 6]].
demo2() -> [{I, (catch generate_exception(I))} || I <- [1, 2, 3, 4, 5, 6]].

catcher(N) ->
  try generate_exception(N) of
    Val -> {N, normal, Val}
  catch
    throw:X -> {N, caught, thrown, X};
    exit:X -> {N, caught, exited, X};
    error:X -> {N, caught, thrown, X};
    _:_ -> io:fwrite('GG WP')  %matches everything //not reachable here
  end.

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a);
generate_exception(6) -> throw(z).