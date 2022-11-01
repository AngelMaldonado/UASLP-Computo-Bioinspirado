import numpy as np


L = 14              # Distancia del sustrato (in)
P = 6000            # Carga (lbs)
max_T = 13600       # Maxima tension (psi)
max_sigma = 30000   # Maxima tension normal (psi)
max_delta = 0.25    # Maximo factor de peso
min_Pc = 6000       # Maxima capacidad de pandeo (lbs)


def tau_1(x1, x2):
    return 1/(np.sqrt(2)*x1*x2)


def R(x1, x2, x3):
    return x2**2 + (x1 + x3)**2


def tau_2(x1, x2, x3):
    return \
        ((L + x2/2)*R(x1, x2, x3)) /\
        (np.sqrt(2)*x1*x3*((x2**2)/3 + (x1 + x3)**2))


def T(tau_1, tau_2, x2, R):
    return P*(np.sqrt(
        tau_1**2 + tau_2**2 + (2*tau_1*tau_2*(x2**2))/R
    ))


def sigma(x3, x4):
    return P*(6*L)/(x4*(x3**2))


def Pc(x3, x4):
    return 64746.022*(1 - 0.02822346*x3)*x3*(x4**3)


def delta(x3, x4):
    return 2.1952/((x3**3)*x4)


def Fw(X):
    if T(tau_1(X[0], X[1]), tau_2(X[0], X[1], X[2]), X[1], R(X[0], X[1], X[2])) > max_T or \
       sigma(X[2], X[3]) > max_sigma or \
       Pc(X[2], X[3]) < min_Pc or \
       sigma(X[2], X[3]) > max_delta:
        return np.inf
    else:
        return 1.10471*(X[0]**2)*X[1] + 0.04811*X[2]*X[3]*(14 + X[1])
