import alaw
import math
import numpy as np
import matplotlib.pyplot as plt

def main():
    fs = 1000.0
    dt = 1.0 / fs
    t = np.arange(0.0, 1.0, dt)
    f = 5
    x = 0.1 * np.sin(2 * math.pi * f * t)
    noise = 0.03 * np.random.randn(len(x))
    x += noise
    x_alaw = np.array([alaw.encode(xx) for xx in x])
    x_decoded = np.array([alaw.decode(xx) for xx in x_alaw])
    x_diff = x - x_decoded
    
    lookup = alaw.lookup_table_8bit()
    reverse_lookup = alaw.lookup_table_8bit_reverse()
    plt.plot(lookup.keys(), lookup.values(), 'b.')
    plt.title('Lookup tables')
    plt.plot(reverse_lookup.keys(), reverse_lookup.values(), 'r.')
    plt.savefig('lookup.png', format='png')
    
    fig = plt.figure()
    ax = fig.add_subplot(221)
    ax.plot(t, x)
    plt.title('Original signal')
    ax = fig.add_subplot(222)
    ax.plot(t, x_alaw)
    plt.title('A-law encoded signal')
    ax = fig.add_subplot(223)
    ax.plot(t, x_decoded)
    plt.title('Decoded signal')
    ax = fig.add_subplot(224)
    ax.plot(t, x_diff)
    plt.title('Difference')
    plt.savefig('test.png', format='png')
    plt.show()

if __name__ == "__main__":
    main()

