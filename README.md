# Analytics IaC
Esse repositório contém o deploy de uma aplicação, com terraform, além de gerenciamento de configurações via ansible

## Setup

- Instalação do terraform (linux)
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

- Caso esteja no linux mint, substitua o trecho `$(lsb_release -cs)` pelo valor de `UBUNTU_CODENAME` na saída de `cat /etc/os-release`, como mostrado [aqui](https://stackoverflow.com/questions/78592832/cannot-install-hashicorp-vault-in-linuxmint-21-3-the-repository-does-not-have), resultando no comando abaixo.

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(sed 's/UBUNTU_CODENAME=//;t;d' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```


## Funcionamento

Esse projeto cria máquina virtual na digital ocean, fique a vontade para utilizar o [free tier](https://cloud.digitalocean.com/registrations/new) e testar o projeto.
