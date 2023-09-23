from Crypto.Util.number import *
from secret import flag, Curve

def is_on(C, P):
    c, d, p = C
    u, v = P
    return (u**2 + v**2 - c**2 * (1 + d * u**2*v**2)) % p == 0

def add(C, P, Q):
    c, d, p = C
    u1, v1 = P
    u2, v2 = Q
    assert is_on(C, P) and is_on(C, Q)
    u3 = (u1 * v2 + v1 * u2) * inverse(c * (1 + d * u1 * u2 * v1 * v2), p) % p
    v3 = (v1 * v2 - u1 * u2) * inverse(c * (1 - d * u1 * u2 * v1 * v2), p) % p
    return (int(u3), int(v3))

def mult(C, P, m):
    assert is_on(C, P)
    c, d, p = C
    B = bin(m)[2:]
    l = len(B)
    u, v = P
    PP = (-u, v)
    O = add(C, P, PP)
    Q = O
    if m == 0:
        return O
    elif m == 1:
        return P
    else:
        for _ in range(l-1):
            P = add(C, P, P)
        m = m - 2**(l-1)
        Q, P = P, (u, v)
        return add(C, Q, mult(C, P, m))

c, d, p = Curve

flag = flag.lstrip(b'iitbCTF{').rstrip(b'}')
l = len(flag)
lflag, rflag = flag[:l // 2], flag[l // 2:]

s, t = bytes_to_long(lflag), bytes_to_long(rflag)
assert s < p and t < p

P = (398011447251267732058427934569710020713094, 548950454294712661054528329798266699762662)
Q = (139255151342889674616838168412769112246165, 649791718379009629228240558980851356197207)

with open("output.txt", 'w') as f:
    f.write(f'is_on(C, P) = {is_on(Curve, P)}\n')
    f.write(f'is_on(C, Q) = {is_on(Curve, Q)}\n')

    f.write(f'P = {P}\n')
    f.write(f'Q = {Q}\n')

    f.write(f's*P = {mult(Curve, P, s)}\n')
    f.write(f't*Q = {mult(Curve, Q, t)}\n')

