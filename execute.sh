#!/bin/bash
principal(){
descobrir
}

descobrir(){
IP=$(hostname -I | cut -d ' ' -f1 | cut -d '.' -f1-3)
echo "Aguarde um momento, procurando hosts ativos..."
NMAPsnIPs=$(nmap -sn -g 443 $IP.0/24 | grep "Nmap scan report" | cut -d ' ' -f5)
echo "$NMAPsnIPs" >> /tmp/.NMAPsnIPs
LINES=$(wc -l /tmp/.NMAPsnIPs | cut -d ' ' -f1)
for i in $(seq 1 $LINES);
do
NMAPindividual=$(cat /tmp/.NMAPsnIPs | head -n$i | tail -n1)
echo "$NMAPindividual => ONLINE"
done
rm /tmp/.NMAPsnIPs
if [ "$NMAPsnIPs" = '' ]
then
echo "Nenhum host encontrado."
fi
}
principal
