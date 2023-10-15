#!/bin/bash
scanDate=$(date +%Y%m%d)
htmlTemplateLoc=/usr/local/share/trivy/templates/html.tpl ##after installation trivy this html.tpl deafualt available  
declare -a arr=("busybox" "nginx")

for image in "${arr[@]}"; do
trivy image --format template --template "@${htmlTemplateLoc}" ${image} > /var/tmp/result_${image}_${scanDate}.html
done
