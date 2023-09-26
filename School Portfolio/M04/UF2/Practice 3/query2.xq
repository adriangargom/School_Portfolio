for $x in doc("parc.xml")/parc/atraccions/zona/atraccio
where ($x/edatMinima > 12) and ($x/intensitat = "Forta") and ($x/edatMinima/@adult = "no")
order by $x/@nom
return fn:concat("Nom atraccio: ", $x/@nom)