-module(primes).
-export([sieve/1, isqrt/1, update_trials/2]).

isqrt(0) -> 0;
isqrt(N) when erlang:is_integer(N), N >= 0 ->
    isqrt(N, N).
isqrt(N, X_n) ->
    X_m = (X_n + N div X_n) div 2,
    if
        X_m >= X_n -> X_n;
        X_m < X_n -> isqrt(N, X_m)
    end.

passes_filter(X, Trial) ->
    ((X-(Trial*Trial)) rem Trial /= 0) or (X < Trial*Trial).

update_trials([Trial|Trials], [Candidate|Candidates]) when Trial < Candidate ->
    update_trials(Trials, [Candidate|Candidates]);
update_trials([Trial|Trials], [Candidate|Candidates]) when Trial > Candidate ->
    update_trials([Trial|Trials], Candidates);
update_trials([Trial|Trials], [Candidate|_]) when Trial == Candidate ->
    [Trial|Trials];
update_trials([], _) ->
    [].

sieve(N) ->
    sieve(N, lists:seq(2,isqrt(N)), lists:seq(2,N)).
sieve(N, [Trial|RemainingTrials], Candidates) ->
    % io:format("Currenty using: ~w~n", [Trial]),
    RemainingCandidates = [X || X <- Candidates, passes_filter(X, Trial)],
    sieve(N, update_trials(RemainingTrials, RemainingCandidates), RemainingCandidates);
sieve(_, [], Primes) ->
    Primes.
