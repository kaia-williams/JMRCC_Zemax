JRCC zemax pseudocode

# theory of how this might work:
# because ZPL macros are restricted to 6 inputs
# it may be neccesary to treat the "line" as 
# one pupil ray, referenced using:
#   1. surface of exit
#   2. field of view
#   3. codeV "ray number"
# and one point of intersection, 
# calculated by providing the ray data as above but instead 
# referencing the point at the surface.

# the wavelength and config would be provided by placing 
# CFIG and PRIM commands before the macro operand

# atlernatively, it may be possible to refernece external
# REAY operands? not sure.

# trace the ray to be treated as a line 
RAYTRACE hx, hy, px, py, wavenum

RAGL(x) # global X-direction cosine 
RAGM(x) # global X-direction cosine
RAGN(x) # global Z-direction cosine
 
RAGX(x) # The global x coordinate of the ray intercept. 
RAGY(x) # The global y coordinate of the ray intercept. 
RAGZ(x) # The global z coordinate of the ray intercept.

# after collecting all data, use the equations outlined 
# in the original JMRCC macro
# or sourced from Algebra 2 (distance from a line)
# to calculate the dist

#get 