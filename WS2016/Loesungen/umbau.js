window.onload = showXML;

function loadXML(filename) {
    var status = document.getElementById("status");

    var xhttp = new XMLHttpRequest();

    try {
        xhttp.open("GET", filename, false);
        xhttp.send();
    }
    catch (e) {
        status.innerHTML = e + "Achtung: Die HTML-Seite muss durch einen Server ausgeliefert werden.";
        return null;
    }

    var type = xhttp.getResponseHeader("Content-Type");

    if (type.indexOf("xml") === -1) {
        return null;
    }

    if (xhttp.status !== 200) {
        status.innerHTML = xhttp.responseText;
        return null;
    } else {
        var now = new Date();
        status.innerHTML = now.toLocaleString() + " " + filename + " erfolgreich gelesen.";
        return xhttp.responseXML;
    }
}

function showXML() {

    var xmlDoc = loadXML("projekt.xml");

    if (xmlDoc === null) {
        return;
    }

    umbau(xmlDoc);

    // Serialisiere das XML-Dokument zu einem String
    var s = new XMLSerializer();
    xml = s.serializeToString(xmlDoc);
    document.getElementById("out").textContent = xml;
}

// In der Klausur ist nur die folgende Funktion erforderlich.

function umbau(xmlDoc) {
    var tops = xmlDoc.getElementsByTagName("top");
    for (var i = 0; i < tops.length; i++) {
        var top = tops[i];
        var fragment = document.createDocumentFragment();
        var aufgaben = top.getElementsByTagName("aufgabe");
        while (aufgaben.length != 0) {
            fragment.appendChild(aufgaben[0]);
        }
        top.insertBefore(fragment, top.firstChild);
    }
}
