#!/usr/bin/env python3

# -----------------------------------------------------------------------------------------------------
# Elmer circuit builder main:
#
# Description:
#                This is a tool to write circuits in Elmer format using pin-connection convention.
#
# Instructions:
#                 1) Import the circuit builder library (from circuit_builder import *)
#                 2) Set output file name as a string (e.g output_file = "string_circuit.definitions")
#                 3) Set number of circuits with number_of_circuits(n) (e.g c = number_of_circuits(1))
#                 4) Set your ground/reference node in the current circuit c[1].ref_node = pin_number
#                 5) Select and configure electrical component
#                     Resistors (R), Inductors (L), Capacitors (C), Voltage Source (V), Current Source (I)
#                     or FEM Component (ElmerComponent)
#                     Arguments needed for R, L, C, V, I is the same. ElmerComponent takes additional arguments
#                 6) Add circuit components to circuit c[n].components.append([R1, V1, ElmerFemCoil, ...etc])
#                 7) Write circuits generate_elmer_circuits(c, output_file)
#                 8) Output file must be included in .sif file
#
# ------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------
# Imported Libraries:
import sys
import elmer_circuitbuilder as cb
import re

# -----------------------------------------------------------------------------------------------------


def main(argv=None):

    # name output file
    output_file = "one_wire_circuits.definitions"

    # initialize circuits: number of circuits - do not remove
    c = cb.number_of_circuits(1)

    # ------------------ Circuit 1 (Current Source )---------------------
    # reference/ground node needed - do not remove.
    c[1].ref_node = 2

    # Components
    i1 = cb.I("I1", 1, 3, 1.0)
    wire_1 = cb.ElmerComponent("wire_1", 1, 2, 1, [1])
    # wire_2 = cb.ElmerComponent("wire_2", 3, 2, 2, [2])
    resistor = cb.R("R1", 3, 2, 1.1)
    # store components in array components = [comp1, comp2,...] - do not remove
    c[1].components.append([i1, wire_1, resistor])
    # ------------------ Circuit 2 (Current Source )---------------------

    # --------------------------------------------------

    # generate elmer circuit.definitions - do not remove / do not edit
    cb.generate_elmer_circuits(c, output_file)
    # fix the sources.
    regex = r"(Real MATC \")([A-Za-z]+\d*)(\"$)"
    subst = "\\g<1>\\g<2>*sin(omega*tx)\\g<3>"
    with open(output_file, "r") as infile, open(
        "modified_" + output_file, "w"
    ) as outfile:
        for line in infile:
            result = re.sub(regex, subst, line, 0, re.MULTILINE)
            outfile.write(result)

    return 0


if __name__ == "__main__":
    sys.exit(main())
