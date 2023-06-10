curl -L https://tei-c.org/activities/council/meetings/tei-technical-council-f2f-meeting-in-guelph-7-9-may-2023/ > tmp/2023-05.html
#first extract the useful bits from html
perl articulate.prl tmp/2023-05.html
# update ../tcMins/tcm-catalogue.xml with meeting details
#
#    <bibl xml:id="TCM165" n="2023-04_31583.xml"> <meeting n="2023-04" when="2023-04-14">TEI
#     Technical Council online meeting : <date>14 April 2023</date></meeting> <listRef>
#     <ref target="2023-04_31583.html">TEI P5 </ref>
#     <ref target="https://raw.githubusercontent.com/lb42/theCellar/main/w023-04_31583.xml">Raw TEI
#      P5</ref>
#     <ref
#     target="https://tei-c.org/activities/council/meetings/tei-technical-council-teleconference-2023-04-14"
#     >[on TEI-C website]</ref>
#     </listRef> </bibl>


# check for wellformedness problems (mostly linebreaks inside td)
#then retag in xml
saxon tmp/2023-05_31620.xml retagfromwp.xsl >../tcMins/2023-05_31620.xml
perl -pi -e's/ xmlns=""//' ../tcMins/2023-05_31620.xml
#wf errors have to be fixed by hand, so take care not to overwrite the
#file in tmp