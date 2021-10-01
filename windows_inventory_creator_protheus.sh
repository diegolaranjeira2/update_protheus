#!/bin/sh
### Descrição: Cria o arquivo de inventario com as variaveis e vms para uso pelas rotinas de update
### Autor: Renan Dias (Grilo Sueco) - renan.dsilva@totvs.com.br

### VMs Windows
cat > /root/update_protheus/inventario_update_protheus <<'EOF'
[prod]
EOF
cat > /root/update_protheus/inventario_snapshot_protheus <<'EOF'
[prod]
EOF


while read linha; do
grep $linha /opt/lista_tesp2_geral_vms_e_floatip.txt | awk '{print $2}' >> /root/update_protheus/inventario_update_protheus;
grep $linha /opt/lista_tesp2_geral_vms_e_floatip.txt | awk '{print $1}' >> /root/update_protheus/inventario_snapshot_protheus;
done < /mnt/update_windows_protheus.txt

#cp /root/inventory_creator/inventario_update_rm /root/update_rm
#cp /root/inventory_creator/inventario_snapshot_rm /root/update_rm

git -C /root/update_protheus pull

git -C /root/update_protheus add inventario_update_protheus
git -C /root/update_protheus add inventario_snapshot_protheus

git -C /root/update_protheus commit -m "Inventario Atualizado"

git -C /root/update_protheus push



