:- module('ex4',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(a, asimov).
author(h, herbert).
author(m, morris).
author(t, tolkien).

genre(s, science).
genre(l, literature).
genre(sf, science_fiction).
genre(f, fantasy).

book(inside_the_atom, a, s, s(s(s(s(s(zero)))))).
book(asimov_guide_to_shakespeare, a, l, s(s(s(s(zero))))).
book(i_robot, a, sf, s(s(s(zero)))).
book(dune, h, sf, s(s(s(s(s(zero)))))).
book(the_well_at_the_worlds_end, m, f, s(s(s(s(zero))))).
book(the_hobbit, t, f, s(s(s(zero)))).
book(the_lord_of_the_rings, t, f, s(s(s(s(s(s(zero))))))).

% You can add more facts.


% Helper predicate: A <= B for Church numerals
less_eq(zero, _).
less_eq(s(A), s(B)) :-
    less_eq(A, B).

% Signature: max_list(Lst, Max)/2
% Purpose: true if Max is the maximum church number in Lst, false if Lst is empty.
max_list([], false).
max_list([X], X).
max_list([H | T], H) :-
    max_list(T, M),
    less_eq(M, H).
max_list([H | T], M) :-
    max_list(T, M),
    less_eq(H, M).








% Signature: author_of_genre(GenreName, AuthorName)/2
% Purpose: true if an author by the name AuthorName has written a book belonging to the genre named GenreName.
author_of_genre(GenreName, AuthorName) :-
    genre(GenreId, GenreName),
    author(AuthorId, AuthorName),
    book(_, AuthorId, GenreId, _).




% Convert Church numerals to integers
church_to_int(zero, 0).
church_to_int(s(N), I) :-
    church_to_int(N, I0),
    I is I0 + 1.


% Signature: longest_book(AuthorName, BookName)/2
% Purpose: true if the longest book that an author by the name AuthorName has written is titled BookName.
longest_book(AuthorName, BookName) :-
    author(AuthorId, AuthorName),
    findall((LengthInt, Title), (
        book(Title, AuthorId, _, Length),
        church_to_int(Length, LengthInt)
    ), Pairs),
    max_member((_, BookName), Pairs).
