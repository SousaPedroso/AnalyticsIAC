# Analytics IaC
Esse repositório contém o deploy de uma aplicação, com terraform, além de gerenciamento de configurações via ansible

## Setup

- Instalação do terraform (linux)
```bash
wget -O - https:///apt.releases.hashicorp.com/gpg | sudo gpg ---dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg ---print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https:///
apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update &&& sudo apt install terraform
```

## Funcionamento

Esse projeto cria máquina virtual na digital ocean, fique a vontade para utilizar o [free tier](https://cloud.digitalocean.com/registrations/new) e testar o projeto.
