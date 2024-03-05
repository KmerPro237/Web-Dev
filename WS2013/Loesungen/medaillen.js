window.onload = showXML;

function loadXML(filename) {
    var status = document.getElementById("status");

    var xhttp = new XMLHttpRequest();

    try {
        xhttp.open("GET", filename, false);
        xhttp.send();
    }
    catch (e) {
        status.innerHTML = e + "Achtung: Die HTML-Seite muss durch einen Server ausgeliefert werden."
        return null;
    }

    var type = xhttp.getResponseHeader("Content-Type");

    if (type.indexOf("xml") == -1) {
        return null;
    }


    if (xhttp.status != 200) {
        status.innerHTML = xhttp.responseText;
        return null;
    }
    else {
        var now = new Date();
        status.innerHTML = now.toLocaleString() + " " + filename + " erfolgreich gelesen."
        return xhttp.responseXML;
    }
}

function showXML() {

    xmlDoc = loadXML("olympia-dtd.xml");

    if (xmlDoc == null) {
        return;
    }

    var list = "";
    var sportler = xmlDoc.getElementsByTagName("sportler");
    var mspiegel = {}
    for (var s = 0; s < sportler.length; s++) {
        var land = sportler[s].getAttribute("land");
        if (mspiegel[land] == null) {
            var medaillen = ermitteleMedaillen(xmlDoc, land);
            mspiegel[land] = medaillen;
            list += "<tr><td>" + land + "</td><td>" + medaillen.gold + "</td><td>" + medaillen.silber +
                "</td><td>" + medaillen.bronze + "</td></tr>";
        }
    }

    var table = "<table><thead><tr><th>Land</th><th>Gold</th><th>Silber</th><th>Bronze</th></tr></thead>"
    table +=  "<tbody>" + list + "</tbody>";
    document.getElementById("medaillen").innerHTML = table;
}

function getSportlerById(xlmDoc, sid) {
    var sportler = xmlDoc.getElementsByTagName("sportler");
    for (var s = 0; s < sportler.length; s++) {
        if (sportler[s].getAttribute("sid") == sid) {
            return sportler[s];
        }
    }
    return null;
}

// In der Klausur ist nur die folgende Funktion erforderlich.

function ermitteleMedaillen(xmlDoc, land) {
    var medaillen = { gold: 0, silber: 0, bronze: 0};

    var wettkampf = xmlDoc.getElementsByTagName("wettkampf");
    for (var w = 0; w < wettkampf.length; w++) {
        var ergebnis = wettkampf[w].getElementsByTagName("ergebnis");
        for (var e = 0; e < 3; e++) {
            // funktioniert nur mit Firefox richtig
            var sportler = xmlDoc.getElementById(ergebnis[e].getAttribute("sid"));
            // für Chrome und IE:
            // var sportler = getSportlerById(xmlDoc, ergebnis[e].getAttribute("sid"));
            if (sportler.getAttribute("land") == land) {
                switch (e) {
                    case 0: medaillen.gold++; break;
                    case 1: medaillen.silber++; break;
                    case 2: medaillen.bronze++; break;
                }
                
            }
        }
    }

    return medaillen;
}