# fonte dos dados (source): https://prefeitura.pbh.gov.br/saude/coronavirus
# > BOLETIM EPIDEMIOLÓGICO E ASSISTENCIAL

for f in *.pdf; do 
    pdftotext $f; 
    txt=$( echo "${f%pdf}txt" );
    time=$( echo $txt | awk 'BEGIN{ FS="_" }{print $6}' | sed 's/\.txt//g' | awk 'BEGIN{ FS="-" }{print $3 "-" $2 "-" $1}');
    data=$( head -30 $txt | grep -P '^[0-9]+' | sed 's/\.//g' | tr '\n' , );
    echo $time,$data | sed 's/,$//g';
    rm $txt;
done >> covid-bh.csv
