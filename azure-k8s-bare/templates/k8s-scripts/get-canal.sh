echo "*** $(date) *** Get canal"
curl https://docs.projectcalico.org/v3.7/manifests/canal.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in canal.yaml"
sed -i -e "s?10.244.0.0/16?192.168.0.0/16?g" canal.yaml
sleep 2

echo "*** $(date) *** Apply canal.yaml"
kubectl apply -f canal.yaml
sleep 2