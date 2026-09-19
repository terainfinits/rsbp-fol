% ============================================================
% FOL KNOWLEDGE BASE: Requirement <-> Class/Method/Attribute traceability
% Source: Python OOP Coffee Machine (CoffeeMaker, MenuItem, Menu, MoneyMachine)
% Goal  : help a developer find which code to modify when a requirement changes
% Run   : swipl -s coffee_traceability_kb.pl
% Note  : names follow your query spelling (coffemaker), all lowercase atoms
% ============================================================

:- discontiguous requirement/2, implements/2, uses/3, calls/2, part_of/2.

% ------------------------------------------------------------
% 1. CLASSES                     class(C)
% ------------------------------------------------------------
class(coffemaker).
class(menuitem).
class(menu).
class(moneymachine).

% ------------------------------------------------------------
% 2. METHODS                     method(Class, Method)
% ------------------------------------------------------------
method(coffemaker,  init).
method(coffemaker,  report).
method(coffemaker,  is_resource_sufficient).
method(coffemaker,  make_coffee).

method(menuitem,    init).

method(menu,        init).
method(menu,        get_items).
method(menu,        find_drink).

method(moneymachine, init).
method(moneymachine, report).
method(moneymachine, process_coins).
method(moneymachine, make_payment).

% ------------------------------------------------------------
% 3. ATTRIBUTES                  attribute(Class, Attribute)
%    part_of(Child, Parent): dict key inside a dict attribute
% ------------------------------------------------------------
attribute(coffemaker, resources).
attribute(coffemaker, water).
attribute(coffemaker, milk).
attribute(coffemaker, coffee).
part_of(attribute(coffemaker, water),  attribute(coffemaker, resources)).
part_of(attribute(coffemaker, milk),   attribute(coffemaker, resources)).
part_of(attribute(coffemaker, coffee), attribute(coffemaker, resources)).

attribute(menuitem, name).
attribute(menuitem, cost).
attribute(menuitem, ingredients).
attribute(menuitem, water).
attribute(menuitem, milk).
attribute(menuitem, coffee).
part_of(attribute(menuitem, water),  attribute(menuitem, ingredients)).
part_of(attribute(menuitem, milk),   attribute(menuitem, ingredients)).
part_of(attribute(menuitem, coffee), attribute(menuitem, ingredients)).

attribute(menu, menu).

attribute(moneymachine, currency).
attribute(moneymachine, coin_values).
attribute(moneymachine, profit).
attribute(moneymachine, money_received).

% ------------------------------------------------------------
% 4. REQUIREMENTS                requirement(Id, Description)
% ------------------------------------------------------------
requirement(requirement_store_machine_resources,
    'Machine keeps initial stock of water, milk and coffee').
requirement(requirement_make_report,
    'Print report of remaining resources and profit').
requirement(requirement_check_resource_sufficient,
    'Check whether ingredients are enough for a drink and warn if not').
requirement(requirement_make_coffee,
    'Deduct ingredients from resources and serve the drink').
requirement(requirement_define_menu_item,
    'A drink has name, cost and ingredient amounts').
requirement(requirement_provide_menu,
    'System offers the list of available drinks').
requirement(requirement_show_menu_options,
    'Show the names of available drinks to the customer').
requirement(requirement_find_drink,
    'Find drink by name; tell customer if it is unavailable').
requirement(requirement_initialize_money_machine,
    'Money machine starts with zero profit and zero received money').
requirement(requirement_process_coins,
    'Accept coins (quarters, dimes, nickles, pennies) and total their value').
requirement(requirement_process_payment,
    'Accept payment when money received is at least the drink cost').
requirement(requirement_calculate_change,
    'Give back change after payment').
requirement(requirement_refund_insufficient_payment,
    'Refund money when payment is not enough').
requirement(requirement_track_profit,
    'Accumulate profit from successful payments and show it').

% ------------------------------------------------------------
% 5. IMPLEMENTS   implements(Requirement, method(Class, Method))
%    (the requirement is realised directly by this method)
% ------------------------------------------------------------
implements(requirement_store_machine_resources,       method(coffemaker, init)).

implements(requirement_make_report,                   method(coffemaker, report)).
implements(requirement_make_report,                   method(moneymachine, report)).

implements(requirement_check_resource_sufficient,     method(coffemaker, is_resource_sufficient)).

implements(requirement_make_coffee,                   method(coffemaker, make_coffee)).

implements(requirement_define_menu_item,              method(menuitem, init)).

implements(requirement_provide_menu,                  method(menu, init)).
implements(requirement_show_menu_options,             method(menu, get_items)).
implements(requirement_find_drink,                    method(menu, find_drink)).

implements(requirement_initialize_money_machine,      method(moneymachine, init)).
implements(requirement_process_coins,                 method(moneymachine, process_coins)).
implements(requirement_process_payment,               method(moneymachine, make_payment)).
implements(requirement_calculate_change,              method(moneymachine, make_payment)).
implements(requirement_refund_insufficient_payment,   method(moneymachine, make_payment)).

implements(requirement_track_profit,                  method(moneymachine, init)).
implements(requirement_track_profit,                  method(moneymachine, make_payment)).
implements(requirement_track_profit,                  method(moneymachine, report)).

% ------------------------------------------------------------
% 6. CALLS / CREATES   calls(method(C1,M1), method(C2,M2))
% ------------------------------------------------------------
calls(method(menu, init),                method(menuitem, init)).        % creates MenuItem objects
calls(method(moneymachine, make_payment), method(moneymachine, process_coins)).

% ------------------------------------------------------------
% 7. USES   uses(method(C,M), attribute(C2,A), Mode)   Mode = read | write
% ------------------------------------------------------------
% CoffeeMaker
uses(method(coffemaker, init), attribute(coffemaker, resources), write).
uses(method(coffemaker, init), attribute(coffemaker, water),     write).
uses(method(coffemaker, init), attribute(coffemaker, milk),      write).
uses(method(coffemaker, init), attribute(coffemaker, coffee),    write).

uses(method(coffemaker, report), attribute(coffemaker, resources), read).
uses(method(coffemaker, report), attribute(coffemaker, water),     read).
uses(method(coffemaker, report), attribute(coffemaker, milk),      read).
uses(method(coffemaker, report), attribute(coffemaker, coffee),    read).

uses(method(coffemaker, is_resource_sufficient), attribute(coffemaker, resources),  read).
uses(method(coffemaker, is_resource_sufficient), attribute(menuitem,   ingredients), read).

uses(method(coffemaker, make_coffee), attribute(coffemaker, resources),   write).
uses(method(coffemaker, make_coffee), attribute(menuitem,   ingredients), read).
uses(method(coffemaker, make_coffee), attribute(menuitem,   name),        read).

% MenuItem
uses(method(menuitem, init), attribute(menuitem, name),        write).
uses(method(menuitem, init), attribute(menuitem, cost),        write).
uses(method(menuitem, init), attribute(menuitem, ingredients), write).
uses(method(menuitem, init), attribute(menuitem, water),       write).
uses(method(menuitem, init), attribute(menuitem, milk),        write).
uses(method(menuitem, init), attribute(menuitem, coffee),      write).

% Menu
uses(method(menu, init),       attribute(menu, menu),      write).
uses(method(menu, get_items),  attribute(menu, menu),      read).
uses(method(menu, get_items),  attribute(menuitem, name),  read).
uses(method(menu, find_drink), attribute(menu, menu),      read).
uses(method(menu, find_drink), attribute(menuitem, name),  read).

% MoneyMachine
uses(method(moneymachine, init), attribute(moneymachine, profit),         write).
uses(method(moneymachine, init), attribute(moneymachine, money_received), write).

uses(method(moneymachine, report), attribute(moneymachine, currency), read).
uses(method(moneymachine, report), attribute(moneymachine, profit),   read).

uses(method(moneymachine, process_coins), attribute(moneymachine, coin_values),     read).
uses(method(moneymachine, process_coins), attribute(moneymachine, money_received),  write).

uses(method(moneymachine, make_payment), attribute(moneymachine, money_received), read).
uses(method(moneymachine, make_payment), attribute(moneymachine, money_received), write).
uses(method(moneymachine, make_payment), attribute(moneymachine, currency),       read).
uses(method(moneymachine, make_payment), attribute(moneymachine, profit),         write).

% ============================================================
% 8. INFERENCE RULES (the linkage theory)
% ============================================================

% reachable(M1,M2): M2 is called (transitively) from M1
reachable(A, B) :- calls(A, B).
reachable(A, B) :- calls(A, X), reachable(X, B).

% linked_method(R,M): method M must be inspected when R changes
linked_method(R, M) :- implements(R, M).
linked_method(R, M) :- implements(R, M0), reachable(M0, M).

% touched_attr(R,A): attribute A is read/written by a method linked to R
touched_attr(R, A) :- linked_method(R, M), uses(M, A, _).

% linkage(R, Element) with Element = class(C) | method(C,M) | attribute(C,A)
linkage(R, method(C, M))    :- linked_method(R, method(C, M)).

linkage(R, attribute(C, A)) :- touched_attr(R, attribute(C, A)).
% dict parent accessed dynamically (resources[item]) => its keys are linked
linkage(R, attribute(C, A)) :- touched_attr(R, P), part_of(attribute(C, A), P).
% a key is used => the containing dict is linked
linkage(R, attribute(C, P)) :- touched_attr(R, K), part_of(K, attribute(C, P)).

linkage(R, class(C))        :- linked_method(R, method(C, _)).
linkage(R, class(C))        :- touched_attr(R, attribute(C, _)).

% ------------------------------------------------------------
% 9. DEVELOPER SEARCH / CHANGE-IMPACT RULES
% ------------------------------------------------------------
% Where to edit: methods that directly realise R
modify_candidates(R, Methods) :-
    setof(M, implements(R, M), Methods).

% Full scope of a requirement change
change_scope(R, Elements) :-
    setof(E, linkage(R, E), Elements).

% Which requirements are impacted if this code element changes?
affected_requirements(Element, Reqs) :-
    setof(R, linkage(R, Element), Reqs).

% Evidence: which method touches an attribute for a requirement, and how
evidence(R, attribute(C, A), method(MC, MN), Mode) :-
    linked_method(R, method(MC, MN)),
    uses(method(MC, MN), attribute(C, A), Mode).

% Traceability gaps
orphan_method(method(C, M)) :-
    method(C, M),
    \+ linked_method(_, method(C, M)).

orphan_attribute(attribute(C, A)) :-
    attribute(C, A),
    \+ linkage(_, attribute(C, A)).

% ============================================================
% 10. EXAMPLE QUERIES
% ============================================================
% ?- linkage(requirement_make_report, attribute(coffemaker, water)).    % true
% ?- linkage(requirement_make_report, attribute(menu, menu)).           % false
% ?- linkage(requirement_make_report, class(moneymachine)).             % true
% ?- modify_candidates(requirement_make_report, Ms).
% ?- change_scope(requirement_process_payment, E).
% ?- affected_requirements(attribute(coffemaker, water), Rs).
% ?- affected_requirements(method(moneymachine, make_payment), Rs).
% ?- evidence(requirement_make_report, attribute(coffemaker, water), M, Mode).
% ?- orphan_method(M).
% ?- linkage(R, attribute(menuitem, cost)).      % who depends on drink cost?
