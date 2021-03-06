% a) @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

% -> NEA kann bei einer Eingabe in mehrere Zustände wechseln

%Grammatik für die Dartellung der Sprache 0,1end
% G = (V, sigma (E<), S, P)
% V = {S, A}
% sigma = {0,1}
% Startsymbol S
% P = { 
        %S -> 0S
        %S -> 1S
        %S -> 0A
        %A -> 1
%      }

% N = (Z, sigma, delta, Z0, E)

% Endliche Zustandsmengen | Z , V und ende
zustand(z0). % S
zustand(z1). % A
zustand(z2). % end

% Eingabealphabet sigma
sigma(0).
sigma(1).

% Transitionsrelationen delta
delta(z0, 0, z0).
delta(z0, 1, z0).
delta(z0, 0, z1). % z0 -> z1
delta(z1, 1, z2). % z1 - z2

%sigma stern = wort über alphabet
%delta stern = Transitionsrelation

% Startzustandsmenge Z0
start(z0).
% Endzustandsmenge E
%ende(z0). -- leere menge?
ende(z2).

% b) @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

% delta(aktuellerzustand,A,neuerzustand)
% 1. Fall: S -> epsilon, also leer
delta_stern(Zakt, [], Zakt) :- zustand(Zakt).
% 2. Fall: Zaktuell -> AZneu
delta_stern(Zakt, [A|Ws], Zneu) :- delta(Zakt,A,Zzwischen),
                                   delta_stern(Zzwischen,Ws,Zneu),
                                   zustand(Zakt),
                                   zustand(Zzwischen),
                                   zustand(Zneu).
% Zaktuell, Zzwischen, Zneu sind die verschiedenen Zustände des NEA

% sigma_stern(Ws): Prüft ob Elemente aus Ws in Sigma
% Ws ist also ein Wort über Sigma
% 1. Fall: Leeres Wort
sigma_stern([]).
% 2. Fall: A aus Ws sind Elemente von Sigma
sigma_stern([A|Ws]) :- sigma(A), sigma_stern(Ws).

% lvonN(Ws): Ws ist ein Wort der Sprache von NEA N
lvonN(Ws) :- sigma_stern(Ws), delta_stern(S,Ws,E), start(S), ende(E).