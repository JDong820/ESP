#!/usr/bin/env escript

main([]) ->
    io:format("Usage: sieve.escript <N>~n");
main([N]) ->
    io:format("~w~n", [primes:sieve(list_to_integer(N))]).
