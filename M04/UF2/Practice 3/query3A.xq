for $x in doc("parc.xml")/parc/espectacles/zona/espectacle
where ($x/horari/passi/horaInici = "12:30")
return fn:concat("Total passis que comencen a les 12:30 : ",$x/@nom)