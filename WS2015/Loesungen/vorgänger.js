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

    var xmlDoc = loadXML("todo-dtd.xml");

    if (xmlDoc === null) {
        return;
    }
  
    var list = "";
    var aufgabe = xmlDoc.getElementsByTagName("aufgabe");
    for (var i = 0; i < aufgabe.length; i++) {
        var id = aufgabe[i].getAttribute("id");
        var name = aufgabe[i].getAttribute("name");
        
        var vorgänger = ermitteleVorgänger(xmlDoc, id);
        list += "<tr><td>" + id + "</td><td>" + name + "</td><td>" + vorgänger.join("+") + "</td></tr>";
    }
    var table = "<thead><tr><th>Aufgabe (id)</th><th>Aufgabe (name)</th><th>Vorgänger</th></tr></thead>";
    table += "<tbody>" + list + "</tbody>";
    document.getElementById("vorgänger").innerHTML = table;
}

// In der Klausur ist nur die folgende Funktion erforderlich.

function ermitteleVorgänger(xmlDoc, idAufgabe) {
    var aufgabe = xmlDoc.getElementById(idAufgabe);
    if (aufgabe === null || !aufgabe.hasAttribute("vorher"))
    {
        return [];
    }
    return aufgabe.getAttribute("vorher")
        .split(" ")
        .map(function (v) {
            return xmlDoc.getElementById(v).getAttribute("name")
        });
}