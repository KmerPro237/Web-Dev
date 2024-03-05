window.onload = processXMLFile

function processXMLFile() {
    loadXML('praxis.xml')
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

    var all = ["AOK", "DAK", "Privat"].map(insurance => insurance + ': ' + sumInsurance(xmlDoc, insurance)).join('\n')

    document.getElementById('out').textContent +=
        '\n\n Rechnungsbeträge\n' + all
}

// In der Klausur ist nur die folgende Funktion erforderlich.

function sumInsurance(xmlDoc, insurance) {
    var sum = 0
    var preise = new Map()
    for (var leistung of xmlDoc.getElementsByTagName('leistung')) {
        for (var preis of leistung.getElementsByTagName('preis')) {
            preise.set(leistung.getAttribute('lkz') + preis.getAttribute('kk'), Number(preis.textContent))
        }
    }
    for (var patient of xmlDoc.getElementsByTagName('patient')) {
        var kk = patient.querySelector('kasse').textContent
        if (kk === insurance) {
            for (var behandlung of patient.getElementsByTagName('behandlung')) {
                var lkz = behandlung.getAttribute('art')
                var abgesagt = behandlung.getAttribute('abgesagt')
                if (abgesagt !== 'ja') {
                    sum += preise.get(lkz + kk)
                }
            }
        }
    }
    return sum
}