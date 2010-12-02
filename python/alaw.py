import math

__all__ = ['encode', 'decode', 'lookup_table_8bit']


A = 87.7
A_INV = 1.0/A
ONE_PLUS_LN_A = 1.0 + math.log(A)

sign = lambda x: math.copysign(1, x)


def encode(x):
    abs_x = math.fabs(x)
    if abs_x < A_INV:
        y = A * abs_x / ONE_PLUS_LN_A
    else:
        y = (1.0 + math.log(A * abs_x)) / ONE_PLUS_LN_A
    return sign(x) * y

def decode(x):
    abs_x = math.fabs(x)
    if abs_x < 1 / ONE_PLUS_LN_A:
        y = abs_x * ONE_PLUS_LN_A / A
    else:
        y = math.exp(abs_x * ONE_PLUS_LN_A - 1) / A
    return sign(x) * y


def lookup_generator(size, func=encode):
    for i in range(size):
        yield (i, int(size * func(i / float(size))))

def lookup_table_8bit():
    return dict(lookup_generator(256, encode))

def lookup_table_8bit_reverse():
    return dict(lookup_generator(256, decode))

