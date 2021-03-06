# fonte dos dados (source): https://prefeitura.pbh.gov.br/saude/coronavirus
# > BOLETIM EPIDEMIOLÓGICO E ASSISTENCIAL

for f in *.pdf; do 
    pdftotext $f; 
    txt=$( echo "${f%pdf}txt" );
    date=$( echo $txt | awk 'BEGIN{ FS="_" }{print $6}' | sed 's/\.txt//g' | awk 'BEGIN{ FS="-" }{print $3 "-" $2 "-" $1}');
    data=$( head -30 $txt | grep -P '^[0-9]+' | sed 's/\.//g' | tr '\n' , );
    echo $date,$data | sed 's/,$//g' | sed 's/\*//g' | sed 's/\-\([0-9]\),/-0\1,/g' | sed 's/\-\([0-9]\)-/-0\1-/g';
    rm $txt;
    rm $f;
done >> covid-bh.csv
