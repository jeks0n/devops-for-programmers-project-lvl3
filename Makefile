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
	ansible-galaxy role install -r requirements.yml
	ansible-galaxy collection install -r requirements.yml

ansible-deploy:
	ansible-playbook -i ansible/hosts ansible/playbook.yml --ask-vault-pass