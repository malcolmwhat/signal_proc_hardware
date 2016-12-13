# Real-Time Error Control Decoding in Hardware

## Organization
The MatLab orriented questions can be found in the matlab directory.


## Lab Specification
Consider the (16,5,8) Reed-Muller code discussed in class and used in Mariner Mars probes. Its decoding is to be done in the presence of both errors and erasures due to thresholded effects of AWGN noise.
- (a) In Matlab, first implement the encoder and, in the presence of binary errors only, build a syndrome decoder for the (16,5,8) Reed-Muller code.
- (b) Extend the architecture from (a) so it can handle both errors and erasures during the decoding step. First ‘remove’ symbols affected by erasures and syndrome decode errors in the reduced code. Consequently, after the errors were fixed, resolve the erasures as done in Lab 2.
- (c) Test the overall system architecture from (a) and (b) to obtain bit-error vs. SNR curves for thresholded AWGN noise.
- (d) Extend your implementation to the Altera FPGA board, so it can decode a stream of packets real-time corrupted by thresholded AWGN noise. Optimize your design to maximize the processing speed, in bits per second, when your board decodes arriving noisy packets.
- (e) Document your design in a write-up and prepare/perform the final real-time demonstration of your FPGA system (e.g., with audio data).

## Refferences
[Reed-Muller Codes](http://www-math.ucdenver.edu/~wcherowi/courses/m7823/reedmuller.pdf)
[Mariner](http://www-math.ucdenver.edu/~wcherowi/courses/m7823/reedmuller.pdf)
