-module(geometry).
-author("abrinza").
-include("assertion.hrl").

%% API
-compile(export_all).

test() ->
  ?assertEquals(150, area({rectangle, 10, 15})),
  ?assertEquals(100, area({square, 10})),
  ?assertEquals(314, trunc(area({circle, 10}))),
  ?assertEquals(60, perimeter({rectangle, 10, 20})),
  ?assertEquals(80, perimeter({square, 20})),
  ?assertEquals(6.28, perimeter({circle, 1})),
  'All Tests Passed'.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14 * Radius * Radius.

perimeter({rectangle, Width, Height}) -> (Width + Height) * 2;
perimeter({circle, Radius}) -> 2 * 3.14 * Radius;
perimeter({square, Size}) -> Size * 4.