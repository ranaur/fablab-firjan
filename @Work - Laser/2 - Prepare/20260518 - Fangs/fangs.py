from openscad import *

from pylaser import *

b=cube([30,30,20])

f=b.faces()

lc = LaserCutter(b.faces())

#lc.preview()

lc.finalize()

