from functools import wraps
import time, os
DEBUG = False

def timer(func):
    wraps(func)
    def wrapper(*args, **kwargs):
        if DEBUG:
            start = time.time()
            result = func(*args, **kwargs)
            end = time.time()
            print(f"[TIMER] Function '{func.__name__}' executed in {(end - start):.4f} seconds")
        else:
            result = func(*args, **kwargs)
        return result
    return wrapper

class prbsPattern():
    txPrbsPattern = {
        'PRBS-7': 24,
        'PRBS-9': 25,
        'PRBS-11': 12,   
        'PRBS-15': 13,
        'PRBS-13': 30,
        'PRBS-20': 14,
        'PRBS-23': 15,
        'PRBS-31': 11,
        'PRBS-7INV': 16,
        'PRBS-9INV': 17,
        'PRBS-11INV': 4,   
        'PRBS-15INV': 5,
        'PRBS-13INV': 22,
        'PRBS-20INV': 6,
        'PRBS-23INV': 7,
        'PRBS-31INV': 3
    }

    rxPrbsPattern = {
        'PRBS-7': 24,
        'PRBS-9': 25,
        'PRBS-11': 12,   
        'PRBS-15': 13,
        'PRBS-13': 30,
        'PRBS-20': 14,
        'PRBS-23': 15,
        'PRBS-31': 11,
        'PRBS-7INV': 16,
        'PRBS-9INV': 17,
        'PRBS-11INV': 4,   
        'PRBS-15INV': 5,
        'PRBS-13INV': 22,
        'PRBS-20INV': 6,
        'PRBS-23INV': 7,
        'PRBS-31INV': 3,
        'Auto': 32
    }

    lockLostIcon = {
        0: 'Yes',
        2: 'No',
        3: 'Pre'
    }