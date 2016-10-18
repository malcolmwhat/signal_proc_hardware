#!/usr/bin/env python
import sys

if __name__ == "__main__":
    try:
        reg_count = int(sys.argv[1])
        filename = "reg" + str(reg_count) + ".v"

    except IndexError as e:
        print(e)
        sys.exit(255)

    except ValueError as e:
        print("Lenght is not an integer")
        sys.exit(1)

    fileoutput = open(filename, 'w')
    fileoutput.write("module reg" + str(reg_count) + " ( in, clk, rst, out );\n")
    fileoutput.write("\tinput[31:0] in;\n")
    fileoutput.write("\tinput clk;\n")
    fileoutput.write("\tinput rst;\n")
    fileoutput.write("\toutput[31:0] out;\n\n")

    for i in range(0, reg_count):
        fileoutput.write("\twire [31:0] r" + str(i) + "_out;\n")

    fileoutput.write("\n")
    for i in range(0, reg_count):
        if i == 0:
            in_sig = "in"
        else:
            in_sig = "r" + str(i-1) + "_out"

        fileoutput.write("\treg32 r" + str(i) + " (rst, clk, " + in_sig + ", r" + str(i) + "_out);\n")

    fileoutput.write("\n")
    fileoutput.write("\tassign out = r" + str(reg_count-1) + "_out;\n")
    fileoutput.write("endmodule\n")

    fileoutput.close()
