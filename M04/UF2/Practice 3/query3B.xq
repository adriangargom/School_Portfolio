let $val := count(doc("parc.xml")/parc/espectacles/zona/espectacle/horari/passi[horaInici = "12:30"])
return fn:concat("Total passis que comencen a les 12:30 : ", $val)