# Analytics IaC
Esse repositório contém o deploy de uma aplicação, com terraform, além de gerenciamento de configurações via ansible

## Setup

- Instalação do terraform (linux)
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

- Caso esteja no linux mint, substitua o trecho `$(lsb_release -cs)` pelo valor de `UBUNTU_CODENAME` na saída de `cat /etc/os-release`, como mostrado [aqui](https://stackoverflow.com/questions/78592832/cannot-install-hashicorp-vault-in-linuxmint-21-3-the-repository-does-not-have), ou referencie-se ao trecho abaixo.

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(sed 's/UBUNTU_CODENAME=//;t;d' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

- Obtenção de um [token pessoal de acesso da digital ocean](https://docs.digitalocean.com/reference/api/create-personal-access-token/).
- Criação de uma chave ssh para acesso via ansible e adicionar na [Digital Ocean](https://cloud.digitalocean.com/account/security).
```
ssh-keygen
cat ~/.ssh/digital_oceans.pub
```

- Instalação do ansible
```
python3 -m venv ./.venv
source ./.venv/bin/activate
pip install ansible
```

- Criação dos arquivos prod.auto.tfvars e inventory.ini como os exemplos em [example.tfvars](/infra/example.tfvars) e [example.ini](/infra/example.ini).


## Deploy

Aqui vai ser separado em duas etapas em vista de ser necessário pegar o IP público do [Droplet](https://cloud.digitalocean.com/droplets). Além disso, crie um app no [spotify](https://developer.spotify.com/dashboard/login), e coloque suas credenciais
no *inventory.ini*.
```bash
cd infra
terraform init
terraform apply
cd ..
source ./.venv/bin/activate
cd infra
# destruir os serviços caso não seja mais necessário
# terraform destroy
```

```
ansible-playbook -i inventory.ini install_requirements.yaml
```

## Funcionamento

Esse projeto cria máquina virtual na digital ocean, fique a vontade para utilizar o [free tier](https://cloud.digitalocean.com/registrations/new) e testar o projeto.
