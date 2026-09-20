% ============================================================
% FOL KNOWLEDGE BASE: Requirement <-> Class/Method/Attribute traceability
% Source: Python OOP Coffee Machine (Class: CoffeeMaker, MenuItem, Menu, MoneyMachine)
% Goal  : mencari hubungan antara requirement dan kode
% Note  : semua nonkapital/lowercase
% ============================================================

% ------------------------------------------------------------
% 1. CLASSES : class(C)
% ------------------------------------------------------------
class(coffeemaker).
class(menuitem).
class(menu).
class(moneymachine).

% ------------------------------------------------------------
% 2. METHODS : method(Class, Method)
% ------------------------------------------------------------
method(coffeemaker, init).
method(coffeemaker, report).
method(coffeemaker, is_resource_sufficient).
method(coffeemaker, make_coffee).

method(menuitem, init).

method(menu, init).
method(menu, get_items).
method(menu, find_drink).

method(moneymachine, init).
method(moneymachine, report).
method(moneymachine, process_coins).
method(moneymachine, make_payment).

% ------------------------------------------------------------
% 3. ATTRIBUTES : attribute(Class, Attribute)
%    part_of(Child, Parent): dict key inside a dict attribute
% ------------------------------------------------------------
attribute(coffeemaker, resources).
attribute(coffeemaker, water).
attribute(coffeemaker, milk).
attribute(coffeemaker, coffee).
part_of(attribute(coffeemaker, water), attribute(coffeemaker, resources)).
part_of(attribute(coffeemaker, milk), attribute(coffeemaker, resources)).
part_of(attribute(coffeemaker, coffee), attribute(coffeemaker, resources)).

attribute(menuitem, name).
attribute(menuitem, cost).
attribute(menuitem, ingredients).
attribute(menuitem, water).
attribute(menuitem, milk).
attribute(menuitem, coffee).
part_of(attribute(menuitem, water), attribute(menuitem, ingredients)).
part_of(attribute(menuitem, milk), attribute(menuitem, ingredients)).
part_of(attribute(menuitem, coffee), attribute(menuitem, ingredients)).

attribute(menu, menu).

attribute(moneymachine, currency).
attribute(moneymachine, coin_values).
attribute(moneymachine, profit).
attribute(moneymachine, money_received).

% ------------------------------------------------------------
% 4. REQUIREMENTS : id_r(id, deskripsi)
% ------------------------------------------------------------
id_r(r1, 'inisialisasi stok water, milk & coffee').
id_r(r2, 'Print report sisa resources & profit').
id_r(r3, 'cek apakah ingredients cukup dan memberikan warning bila tidak').
id_r(r4, 'mengurangi ingredients dari resources & sajikan minuman').
id_r(r5, 'inisialisasi minuman punya name, cost dan jumlah ingredient').
id_r(r6, 'inisialisasi sistem menampilkan daftar minuman tersedia').
id_r(r7, 'menampilkan minuman tersedia ke pelanggan').
id_r(r8, 'mencari minuman berdasarkan nama dan memberitahu jika tidak tersedia').
id_r(r9, 'inisialisasi mesin nol profit dan uang').
id_r(r10, 'menerima koin (quarters, dimes, nickles, pennies) dan menjumlahkannya').
id_r(r11, 'menerima pembayaran jika uang minimal seharga minuman dipesan').
id_r(r12, 'berikan kembalian setelah pembayaran').
id_r(r13, 'mengembalikan uang jika pembayaran tidak mencukupi harga minuman dipesan').
id_r(r14, 'akumulasi profit dan pembayaran dan ditampilkan').

% ------------------------------------------------------------
% 5. IMPLEMENTS : implements(Requirement, method(Class, Method))
%    (the requirement is realised directly by this method)
% ------------------------------------------------------------
implements(r1, method(coffeemaker, init) ).

implements(r2, method(coffeemaker, report) ).
implements(r2, method(moneymachine, report) ).

implements(r3, method(coffeemaker, is_resource_sufficient) ).

implements(r4, method(coffeemaker, make_coffee) ).

implements(r5, method(menuitem, init) ).

implements(r6, method(menu, init) ).
implements(r7, method(menu, get_items) ).
implements(r8, method(menu, find_drink) ).

implements(r9, method(moneymachine, init)).
implements(r10, method(moneymachine, process_coins) ).
implements(r11, method(moneymachine, make_payment) ).
implements(r12, method(moneymachine, make_payment) ).
implements(r13, method(moneymachine, make_payment) ).

implements(r14, method(moneymachine, init) ).
implements(r14, method(moneymachine, make_payment) ).
implements(r14, method(moneymachine, report) ).

% ------------------------------------------------------------
% 6. CALLS / CREATES : calls(method(C1,M1), method(C2,M2))
% ------------------------------------------------------------
calls(method(menu, init), method(menuitem, init)). % creates MenuItem objects
calls(method(moneymachine, make_payment), method(moneymachine, process_coins)).

% ------------------------------------------------------------
% 7. USES : uses(method(C,M), attribute(C2,A), Mode) [Mode = read | write]
% ------------------------------------------------------------
% CoffeeMaker
uses(method(coffeemaker, init), attribute(coffeemaker, resources), write).
uses(method(coffeemaker, init), attribute(coffeemaker, water), write).
uses(method(coffeemaker, init), attribute(coffeemaker, milk), write).
uses(method(coffeemaker, init), attribute(coffeemaker, coffee), write).

uses(method(coffeemaker, report), attribute(coffeemaker, resources), read).
uses(method(coffeemaker, report), attribute(coffeemaker, water), read).
uses(method(coffeemaker, report), attribute(coffeemaker, milk), read).
uses(method(coffeemaker, report), attribute(coffeemaker, coffee), read).

uses(method(coffeemaker, is_resource_sufficient), attribute(coffeemaker, resources), read).
uses(method(coffeemaker, is_resource_sufficient), attribute(menuitem, ingredients), read).

uses(method(coffeemaker, make_coffee), attribute(coffeemaker, resources), write).
uses(method(coffeemaker, make_coffee), attribute(menuitem, ingredients), read).
uses(method(coffeemaker, make_coffee), attribute(menuitem, name), read).

% MenuItem
uses(method(menuitem, init), attribute(menuitem, name), write).
uses(method(menuitem, init), attribute(menuitem, cost), write).
uses(method(menuitem, init), attribute(menuitem, ingredients), write).
uses(method(menuitem, init), attribute(menuitem, water), write).
uses(method(menuitem, init), attribute(menuitem, milk), write).
uses(method(menuitem, init), attribute(menuitem, coffee), write).

% Menu
uses(method(menu, init), attribute(menu, menu), write).
uses(method(menu, get_items), attribute(menu, menu), read).
uses(method(menu, get_items), attribute(menuitem, name), read).
uses(method(menu, find_drink), attribute(menu, menu), read).
uses(method(menu, find_drink), attribute(menuitem, name), read).

% MoneyMachine
uses(method(moneymachine, init), attribute(moneymachine, profit), write).
uses(method(moneymachine, init), attribute(moneymachine, money_received), write).

uses(method(moneymachine, report), attribute(moneymachine, currency), read).
uses(method(moneymachine, report), attribute(moneymachine, profit), read).

uses(method(moneymachine, process_coins), attribute(moneymachine, coin_values), read).
uses(method(moneymachine, process_coins), attribute(moneymachine, money_received), write).

uses(method(moneymachine, make_payment), attribute(moneymachine, money_received), read).
uses(method(moneymachine, make_payment), attribute(moneymachine, money_received), write).
uses(method(moneymachine, make_payment), attribute(moneymachine, currency), read).
uses(method(moneymachine, make_payment), attribute(moneymachine, profit), write).

% ============================================================
% 8. INFERENCE RULES (the linkage theory)
% ============================================================

% reachable(M1,M2): M2 dipanggil (transitively) dari M1
reachable(A, B) :- calls(A, B).
reachable(A, B) :- calls(A, X), reachable(X, B). % rekursif

% linked_method(R,M): method terhubung langsung dengan Requirement atau via method lain
linked_method(R, M) :- implements(R, M).
linked_method(R, M) :- implements(R, M0), reachable(M0, M).

% touched_attr(R,A): attribute A dibaca/ditulis oleh method yang terhubung ke Requirement
touched_attr(R, A) :- linked_method(R, M), uses(M, A, _).

% linkage(R, method) via linked_method(R, M) 
linkage(R, method(C, M)) :- linked_method(R, method(C, M)).

% linkage(R, attribute) via touched_attr(R, A) 
linkage(R, attribute(C, A)) :- touched_attr(R, attribute(C, A)).
% atau linked attribute via part_of
linkage(R, attribute(C, A)) :- touched_attr(R, P), part_of(attribute(C, A), P).
linkage(R, attribute(C, P)) :- touched_attr(R, K), part_of(K, attribute(C, P)).

% Requirement terhubung dengan suatu kelas jika menggunakan
% method atau attribute kelas tersebut
linkage(R, class(C)) :- linked_method(R, method(C, _)).
linkage(R, class(C)) :- touched_attr(R, attribute(C, _)).

% ============================================================
% 9. CONTOH QUERIES LINKAGE
% ============================================================
% ?- id_r(r1, X) % menampikan deskripsi requirement r1
% ? - id_r(X, Y) % menampilkan deskripsi semua requirement
% ?- linkage(r2, attribute(coffeemaker, water)).   % true
% ?- linkage(r2, attribute(menu, menu)).           % false
% ?- linkage(r2, class(moneymachine)).             % true
% ?- linkage(R, attribute(menuitem, cost)).      % 
