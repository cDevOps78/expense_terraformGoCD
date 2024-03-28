R="\e[31m"
G="\e[32m"
N="\e[0m"

env=$1
action=$2

if [[ "$#" < 2 ]]; then
  echo -e "${G}\n\t #------------How to use it -------------------#"
  echo -e "\t     bash $0 (env|prod) (plan|apply|destroy)"
  echo -e "\t #---------------------------------------------#${N}"
  exit 0
fi

if [ -z "$env" ]; then
  echo -e "${R}\$1-Input is (dev|prod) is missing ${N}"
  exit 1
fi

if [ -z "$action" ]; then
  echo -e "${R}\$2-Input is (plan|apply|destroy) missing"
  exit 1
fi



rm -rf ./.terraform/terraform.tfstate

terraform init -backend-config=env-${env}/state.tfvars

if [ "${action}" == "plan" ]; then
  terraform ${action}  -var-file=env-${env}/main.tfvars
  exit 0
fi

terraform ${action} -auto-approve -var-file=env-${env}/main.tfvars