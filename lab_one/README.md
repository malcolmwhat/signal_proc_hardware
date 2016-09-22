#### Known Issues

In `test_decoder_gaussian_633.m`, the input of `1E1E01` and `1E1E00` both
yield [1, NaN, 1] as a result. Focusing on the second case, it should be 
identifying the [1 1 1] message correctly.
