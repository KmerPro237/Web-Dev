window.onload = processXMLFile

function processXMLFile() {
    loadXML('seminar.xml')
}

function loadXML(filename) {
    var status = document.getElementById('status')
    var xhr = new XMLHttpRequest()
    xhr.open('GET', filename, true)
    xhr.onload = handler
    xhr.onerror = e => {
        status.innerHTML =
            'Fehler: ' + e + ' Achtung: Die HTML-Seite muss durch einen Server ausgeliefert werden.'
    }
    xhr.send(null)
}

function handler() {
    var xhr = this
    var status = document.getElementById('status')

    var type = xhr.getResponseHeader('Content-Type')
    if (type.indexOf('xml') === -1) {
        return null
    }

    if (xhr.status !== 200) {
        status.innerHTML = xhr.responseText
        return null
    }
    else {
        var now = new Date()
        status.innerHTML = now.toLocaleString() + ' ' /* + filename */ + ' erfolgreich gelesen.'
        showXML(xhr.responseXML)
    }
}

function showXML(xmlDoc) {
    if (xmlDoc === null) {
        return
    }

    // Serialisiere das XML-Dokument zu einem String
    var s = new XMLSerializer()
    var xml = s.serializeToString(xmlDoc)
    document.getElementById('out').textContent = xml

    var ap = averagePriority(xmlDoc)
    var apm = averagePriorityMap(xmlDoc)
    document.getElementById('out').textContent +=
        '\n\n durchschnittliche Priorität: ' + ap + ' ' + apm
}

// In der Klausur ist nur die folgende Funktion erforderlich.

function averagePriority(xmlDoc) {
    var wuensche = {}
    for (var stud of xmlDoc.getElementsByTagName('stud')) {
        for (var wunsch of stud.getElementsByTagName('wunsch')) {
            wuensche[
                stud.getAttribute('matrikel') + wunsch.getAttribute('thema')
            ] = wunsch.getAttribute('prio')
        }
    }

    var vortraege = xmlDoc.getElementsByTagName('vortrag')
    var sumPrio = 0
    for (var i = 0; i < vortraege.length; i++) {
        var vortrag = vortraege[i]
        sumPrio += Number(
            wuensche[vortrag.getAttribute('matrikel') + vortrag.getAttribute('thema')]
        )
    }
    return sumPrio / vortraege.length
}

// Alternative mit Map()

function averagePriorityMap(xmlDoc) {
    var wuensche = new Map()
    for (var stud of xmlDoc.getElementsByTagName('stud')) {
        for (var wunsch of stud.getElementsByTagName('wunsch')) {
            wuensche.set(
                stud.getAttribute('matrikel') + wunsch.getAttribute('thema'),
                wunsch.getAttribute('prio')
            )
        }
    }

    var vortraege = xmlDoc.getElementsByTagName('vortrag')
    var sumPrio = 0
    for (var i = 0; i < vortraege.length; i++) {
        var vortrag = vortraege[i]
        sumPrio += Number(
            wuensche.get(vortrag.getAttribute('matrikel') + vortrag.getAttribute('thema'))
        )
    }
    return sumPrio / vortraege.length
}
