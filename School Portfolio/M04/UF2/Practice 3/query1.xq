for $x in doc("parc.xml")/parc/atraccions/zona/atraccio
where $x/edatMinima <= 10
order by $x/@nom
return fn:concat("Nom atraccio: ", $x/@nom)