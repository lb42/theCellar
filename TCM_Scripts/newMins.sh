curl -L https://tei-c.org/activities/council/meetings/tei-technical-council-f2f-meeting-in-guelph-7-9-may-2023/ > tmp/2023-05.html
#first extract the useful bits from html
perl articulate.prl tmp/2023-05.html
#then retag in xml
saxon tmp/2023-05_31620.xml retagfromwp.xsl >../tcMins/2023-05_31620.xml
perl -pi -e's/ xmlns=""//' ../tcMins/2023-05_31620.xml
#wf errors have to be fixed by hand, so take care not to overwrite the
#file in tmp