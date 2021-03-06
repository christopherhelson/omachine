define (require) ->

    CameraComponent = require('cs!./camera')

    return ->

        dispatch = d3.dispatch('cameraChange')

        size = 700

        scene  = (d) ->

            svg = d3.select(this)

            svg.style('width', size).style('height', size)

            x = d3.scale.linear().domain([-14, 14]).range([0, size])
            y = d3.scale.linear().domain([-14, 14]).range([size, 0])

            # draw the surfaces
            svg.selectAll('line.surface')
                .data(d.surfaces)
                .enter()
                .append('line')
                .attr('class','surface')
                .attr('x1', (s) -> x(s.p1[0]))
                .attr('x2', (s) -> x(s.p2[0]))
                .attr('y1', (s) -> y(s.p1[1]))
                .attr('y2', (s) -> y(s.p2[1]))
                .on('click', (s) -> console.log(s))

            camera = CameraComponent().x(x).y(y)

            # draw the cameras
            svg.selectAll('g.camera')
                .data(d.cameras)
                .enter()
                .append('g')
                .attr('class','camera')
                .each(camera)

            camera.on('change', dispatch.cameraChange)


        scene.on = (type, handler) ->
            dispatch.on(type, handler)
            return scene


        scene.size = (_size) ->
            if not arguments.length then return size
            size = _size
            return scene


        return scene




