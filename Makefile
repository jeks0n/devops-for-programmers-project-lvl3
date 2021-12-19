init:
	terraform -chdir=terraform init

plan:
	terraform -chdir=terraform plan

apply:
	terraform -chdir=terraform apply

destroy:
	terraform -chdir=terraform destroy

ansible-ping:
	ansible all -m ping

ansible-install:
	ansible-galaxy role install -r ansible/requirements.yml
	ansible-galaxy collection install -r ansible/requirements.yml

ansible-deploy:
	ansible-playbook -i ansible/hosts ansible/playbook.yml --vault-password-file ansible/vault-password

touch-vault-password-file:
	touch ansible/vault-password

encrypt:
	ansible-vault encrypt ansible/group_vars/webservers/vault.yml --vault-password-file ansible/vault-password

decrypt:
	ansible-vault decrypt ansible/group_vars/webservers/vault.yml --vault-password-file ansible/vault-password

encrypt-vault:
	ansible-vault encrypt $(FILE) --vault-password-file ansible/vault-password

decrypt-vault:
	ansible-vault decrypt $(FILE) --vault-password-file ansible/vault-password

view-vault:
	ansible-vault view $(FILE) --vault-password-file ansible/vault-password

edit-vault:
	ansible-vault edit $(FILE) --vault-password-file ansible/vault-password

create-vault:
	ansible-vault create $(FILE) --vault-password-file ansible/vault-password