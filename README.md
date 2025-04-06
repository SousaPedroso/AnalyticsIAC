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
no *inventory.ini*. Para o Telegram, envie uma mensagem para [@BotFather](https://t.me/botfather) para registrar o bot e receber o token de autenticação, para depois colocar essa credencial no *inventory.ini*. Também crie uma conta em [Amplitude](https://amplitude.com/get-started), vá em [configurações](http://analytics.amplitude.com/amp-dev-docs/settings/projects) e copie a chave para seu projeto e coloque essa credencial no *inventory.ini*.
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
ansible-playbook -i inventory.ini setup_spotify_analytics.yaml
ansible-playbook -i inventory.ini run_spotify_analytics.yaml
ansible-playbook -i inventory.ini run_telegram_bot.yaml
```

## Funcionamento

Esse projeto cria máquina virtual na digital ocean, fique a vontade para utilizar o [free tier](https://cloud.digitalocean.com/registrations/new) e testar o projeto.

A ideia principal do projeto é integrar o template do telegram com os dados do spotify para poder enviar mensagens a respeito de músicas, playlists, entre outras informações através do bot. Os principais pontos que não permitiram finalizar esta integração no tempo planejado para o final do projeto estão na geração do token do spotify de forma automatizada (não foi possível a implementação feita [aqui](https://github.com/SousaPedroso/dbt-spotify-analytics)) que exige um [mais complexidade](https://stackoverflow.com/questions/54720587/how-to-change-the-network-of-a-running-docker-container) e; mesmo prosseguindo de forma manual, há o erro para obtenção de algumas informações da [API do spotify](https://community.spotify.com/t5/Spotify-for-Developers/v1-me-following-getting-403s-all-of-a-sudden/td-p/6252827).

No entanto, fique à vontade para continuar esse projeto e integrar os dois repositórios base desse projeto: [dbt-spotify](https://github.com/ftupas/dbt-spotify-analytics) e [telegram-bot](https://github.com/donBarbos/telegram-bot-template).
