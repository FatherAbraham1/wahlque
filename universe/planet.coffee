###
  planet.coffee

  The basic paramters for the planet
###
define [
   'exports'
], (p) ->

    p.radius = 7e+6

    # polar unit vector
    p.polar = [0.423, 0, 0.906]

    # base zenith unit vector for lng = 0, lat = 0
    base = [0, 1, 0] # initial base zenith unit vector, change over localtime
    zenithBase = (localtime) ->
        time = localtime - Math.floor(localtime)
        phi = - 2 * Math.PI * time
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        v3.add(v3.expand(base, cos), v3.expand(v3.cross(polar, base), sin));

    # the normal unit zenith vector for any point on the planet surface
    p.zenith = (lng, lat, localtime) ->
        zb = zenithBase(localtime)
        temp = v3.add(v3.expand(zb, Math.cos(lng)), v3.expand(v3.cross(polar, zb), Math.sin(lng)))
        axis = v3.cross(polar, temp)
        v3.add(v3.expand(temp, Math.cos(lat)), v3.expand(v3.cross(axis, temp), Math.sin(lat)))

    p