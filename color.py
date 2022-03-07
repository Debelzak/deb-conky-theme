# python2
# 2021-03-03 @ color.py
# Marcio "Debelzak" Russo
#
# Definition: Given a value and range as arguments, it will return a color gradient representing the given value based on that range
#             So for example, if you give the range [0-100], it will return red if the value is 0 and blue if the value is 100
#             And as the value increases/decreses, the color will interleave all the way from red to blue and vice versa.
#             The script was made to be used on temperature returns on conky, inspired by https://wttr.in/
#

import sys

givenValue = int(sys.argv[3])
givenRange = [0, 0]
givenRange[0] = int(sys.argv[1])
givenRange[1] = int(sys.argv[2])

if givenValue < givenRange[0]:
    givenValue = givenRange[0]
if givenValue > givenRange[1]:
    givenValue = givenRange[1]

def hexcolor(value, range, reverse=False):
    value = int(value)
    min = 0
    max = abs(range[1]-range[0])
    value -= range[0]

    if value <= int((min+max)/2):
        r = 255
        g = int(255*value/int((min+max)/2))
        #b = 255-int(255*value/int((min+max)/2))
        b = 255
    else:
        r = int(255*(max-value)/int((min+max)/2))
        g = 255
        b = 0

    if reverse:
        r, g = g, r

    return "#%s%s%s" % tuple([hex(c)[2:].rjust(2, "0") for c in (r, g, b)])

print("${color " + hexcolor(givenValue, givenRange, True) + "}")