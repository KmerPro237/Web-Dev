window.onload = createSVG

function createSVG() {
    var svg = document.querySelector('svg')
    var stair = createStair(50, 25, 4, 'black', 5)
    svg.appendChild(stair)
}

// In der Klausur sind nur die beiden folgenden Funktionen erforderlich.

function createSVGElement(name, attributes) {
    var element = document.createElementNS('http://www.w3.org/2000/svg', name)
    for (const attName in attributes) {
        element.setAttribute(attName, String(attributes[attName]))
    }
    return element
}

function createStair(xdist, ydist, count, color, width) {
    var d = `M 0 ${ydist * count} `
    for (step = 0; step < count; step++) {
        d += `h ${xdist} `
        d += `v ${-ydist} `
    }
    return createSVGElement('path',
        { stroke: color, 'stroke-width': width, d: d, fill: 'transparent' }
    )
}
