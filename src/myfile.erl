-module(myfile).
-author("abrinza").
-include("assertion.hrl").

%% API
-export([
  readFile/1,
  test/0]).

test() ->
  FileName = 'name list',
  ?assertEquals(file:read_file(FileName), {ok, readFile(FileName)}),
  ?assertEquals('File cannot be found: name lists', try readFile('name lists')
                                                    catch
                                                      throw:Reason -> Reason
                                                    end),
  'All tests passed'.

readFile(File) -> case file:read_file(File) of
                    {ok, T} -> T;
                    {error, _} -> throw(list_to_atom("File cannot be found: " ++ atom_to_list(File)))
                  end.