###
  bodies3pr.coffee

  planar restricted 3-body simulation
###
define [
   'exports'
], (b3) ->

    # acceleration in current phase space
    b3.acceleration = (unit, m1, m2) ->
        (t, x) ->
            [x1, y1, x2, y2, x3, y3] = x

            r12 = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
            r13 = Math.sqrt((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3))
            r23 = Math.sqrt((x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3))
            r21 = r12

            a12 = unit.G * m1 / r12 / r12
            a12x = a12 * (x1 - x2) / r12
            a12y = a12 * (y1 - y2) / r12

            a13 = unit.G * m1 / r13 / r13
            u31x = (x3 - x1) / r13
            u31y = (y3 - y1) / r13
            a13x = - a13 * u31x
            a13y = - a13 * u31y

            a21 = unit.G * m2 / r21 / r21
            a21x = a21 * (x2 - x1) / r21
            a21y = a21 * (y2 - y1) / r21

            a23 = unit.G * m2 / r23 / r23
            u32x = (x3 - x2) / r23
            u32y = (y3 - y2) / r23
            a23x = - a23 * u32x
            a23y = - a23 * u32y

            [
                a21x,
                a21y,
                a12x,
                a12y,
                (a13x + a23x),
                (a13y + a23y)
            ]

    # derivative in current phase space
    b3.derivative = (unit, m1, m2) ->
        (t, phase) ->
            [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3] = phase

            r12 = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
            r13 = Math.sqrt((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3))
            r23 = Math.sqrt((x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3))
            r21 = r12

            a12 = unit.G * m1 / r12 / r12
            a12x = a12 * (x1 - x2) / r12
            a12y = a12 * (y1 - y2) / r12

            a13 = unit.G * m1 / r13 / r13
            u31x = (x3 - x1) / r13
            u31y = (y3 - y1) / r13
            a13x = - a13 * u31x
            a13y = - a13 * u31y

            a21 = unit.G * m2 / r21 / r21
            a21x = a21 * (x2 - x1) / r21
            a21y = a21 * (y2 - y1) / r21

            a23 = unit.G * m2 / r23 / r23
            u32x = (x3 - x2) / r23
            u32y = (y3 - y2) / r23
            a23x = - a23 * u32x
            a23y = - a23 * u32y

            [
                vx1,
                vy1,
                a21x,
                a21y,
                vx2,
                vy2,
                a12x,
                a12y,
                vx3,
                vy3,
                (a13x + a23x),
                (a13y + a23y)
            ]

    b3