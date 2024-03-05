window.onload = createSVG

function createSVG() {
    var svg = document.querySelector('svg')
    var grid = createGrid(300, 200, 100, 20)
    svg.appendChild(grid)
}

// In der Klausur sind nur die beiden folgenden Funktionen erforderlich.

function createSVGElement(name, attributes) {
    var element = document.createElementNS('http://www.w3.org/2000/svg', name)
    for (const attName in attributes) {
        element.setAttribute(attName, String(attributes[attName]))
    }
    return element
}

function createLines(g, width, height, step, showText, className) {
    var text
    for (let x = 0; x <= width; x += step) {
        g.appendChild(createSVGElement('line', {
            class: `grid ${className}`,
            x1: x, x2: x,
            y1: 0, y2: height
        }))
        if (showText) {
            text = createSVGElement('text', {
                x,
                y: -5,
                'text-anchor': 'middle'
            })
            text.innerHTML = x
            g.appendChild(text)
        }
    }
    for (let y = 0; y <= height; y += step) {
        g.appendChild(createSVGElement('line', {
            class: `grid ${className}`,
            x1: 0, x2: width,
            y1: y, y2: y
        }))
        if (showText && y > 0) {
            text = createSVGElement('text', {
                x: -30,
                y: y + 5
            })
            text.innerHTML = y
            g.appendChild(text)
        }
    }
}

function createGrid(width, height, major, minor) {
    var g = createSVGElement('g', { transform: 'translate(30,30)' })
    createLines(g, width, height, minor, false, 'gray')
    createLines(g, width, height, major, true, 'black')
    return g
}
