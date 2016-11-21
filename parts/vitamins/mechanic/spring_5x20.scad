/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/spring_5x20.scad
 **
 ** This file renders a spring of the size specified by the file name.
 **
 **********************************************************************************************************************/

STEPSIZE = 1/8; // original value was 1/36, but that lead to a 3.2 MB STL file...

OD     =  7.5;
ID     =  5.0;
WIRE   =  1.2;
HEIGHT = 20.0;
TWISTS =  9;

// taken from openscad example 20
module coil(r1 = 100, r2 = 10, h = 100, twists)
{
    hr = h / (twists * 2);
    module segment(i1, i2) {
        alpha1 = i1 * 360*r2/hr;
        alpha2 = i2 * 360*r2/hr;
        len1 = sin(acos(i1*2-1))*r2;
        len2 = sin(acos(i2*2-1))*r2;
        if (len1 < 0.01)
            polygon([
                [ cos(alpha1)*r1, sin(alpha1)*r1 ],
                [ cos(alpha2)*(r1-len2), sin(alpha2)*(r1-len2) ],
                [ cos(alpha2)*(r1+len2), sin(alpha2)*(r1+len2) ]
            ]);
        if (len2 < 0.01)
            polygon([
                [ cos(alpha1)*(r1+len1), sin(alpha1)*(r1+len1) ],
                [ cos(alpha1)*(r1-len1), sin(alpha1)*(r1-len1) ],
                [ cos(alpha2)*r1, sin(alpha2)*r1 ],
            ]);
        if (len1 >= 0.01 && len2 >= 0.01)
            polygon([
                [ cos(alpha1)*(r1+len1), sin(alpha1)*(r1+len1) ],
                [ cos(alpha1)*(r1-len1), sin(alpha1)*(r1-len1) ],
                [ cos(alpha2)*(r1-len2), sin(alpha2)*(r1-len2) ],
                [ cos(alpha2)*(r1+len2), sin(alpha2)*(r1+len2) ]
            ]);
    }
    linear_extrude(height = h, twist = 180*h/hr,
            $fn = (hr/r2)/STEPSIZE, convexity = 5) {
        for (i = [ STEPSIZE : STEPSIZE : 1+STEPSIZE/2 ])
            segment(i-STEPSIZE, min(i, 1));
    }
}

coil(r1 = (OD - WIRE) / 2, r2 = WIRE / 2, h = HEIGHT, twists = TWISTS);

