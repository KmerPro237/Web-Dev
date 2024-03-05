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

    var xmlDoc = loadXML("fbwm-dtd.xml");

    if (xmlDoc === null) {
        return;
    }
  
    var list = "";
    var land = xmlDoc.getElementsByTagName("land");
    for (var i = 0; i < land.length; i++) {
        var name = land[i].getAttribute("name");
        /* Aus Gründen der Aufgabenstellung wird hier der Name übergeben und nicht das
         Element. Das führt dazu, dass in der Funktion wieder eine Schleife über die
         Länder gebraucht wird. */
        var info = ermitteleLaufleistung(xmlDoc, name);
        list += "<tr><td>" + name + "</td><td>" + info.total + "</td><td>" + info.max +
                "</td><td>" + info.durchschnitt + "</td></tr>";
    }
    var table = "<thead><tr><th>Land</th><th>Total</th><th>Max</th><th>Durchschnitt</th></tr></thead>";
    table += "<tbody>" + list + "</tbody>";
    document.getElementById("laufleistung").innerHTML = table;
}

// In der Klausur ist nur die folgende Funktion erforderlich.

function ermitteleLaufleistung(xmlDoc, nameLand) {
    var info = { total: 0, max: 0, durchschnitt: 0 };

    var land = xmlDoc.getElementsByTagName("land");
    for (var i = 0; i < land.length; i++) {
        if (land[i].getAttribute("name") === nameLand) {
            var laufleistungen = land[i].getElementsByTagName("laufleistung");
            for (var j = 0; j < laufleistungen.length; j++) {
                var laufleistung = laufleistungen[j];
                var strecke = Number(laufleistung.textContent);
                if (laufleistung.getAttribute("einheit") === "km") {
                    strecke *= 1000;
                }
                info.total += strecke;
                if (strecke > info.max) {
                    info.max = strecke;
                }
            }
            if (laufleistungen.length > 0) {
                info.durchschnitt = info.total / laufleistungen.length;
            }
            return info;
        }
    }
}