R="\e[31m"
G="\e[32m"
N="\e[0m"

env=$1
action=$2

if [ -z "$env" ]; then
  echo -e "${R}\$1-Input is (env|prod) is missing ${N}"
  echo -e "${G}\t #------------How to use it -------------------#"
  echo -e "\n bash $0 (env|prod) (plan|apply|destroy)"
  echo -e "\t #---------------------------------------------#{N}"
  exit 1
fi


if [ -z "$action" ]; then
  echo -e "${R}\$2-Input is (plan|apply|destroy) missing"
  echo -e "${G}\t #------------How to use it -------------------#"
  echo -e "\n bash $0 (env|prod) (plan|apply|destroy)"
  echo -e "\t #---------------------------------------------#{N}"
  exit 1
fi

#rm -rf ./.terraform/terraform.tfstate
#
#terraform init -backend-config=env-${env}/state.tfvars
#terraform ${action} -auto-approve  -var-file=env-${env}/main.tfvars