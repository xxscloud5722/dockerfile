#!/usr/bin/env bash
set -e

echo -e "\e[32m================================================================\e[0m"
echo -e "\e[32mVersion: 1.0.0\e[0m"
echo -e "\e[32mAuthor: LX\e[0m"
echo -e "\e[32mArgs\e[0m"
echo -e "\e[32m  - 1 (Optional): Path Config\e[0m"
echo -e "\e[32m  - 2 (Optional): Namespace Name\e[0m"
echo -e "\e[32m  - 3 (Optional): Scale Number\e[0m"
echo -e "\e[33;1m Only supports Deployments service !\e[0m"
echo -e "\e[32m================================================================\e[0m"


if [ -z "${1}" ]; then
  echo "输入配置文件地址 (~/.kube/config)";
  # shellcheck disable=SC2162
  read configPath
else
  configPath="${1}"
fi
if [ -z "${configPath}" ]; then
  configPath="$HOME/.kube/config"
  echo -e "\e[34mPath: $configPath\e[0m"
else
  echo -e "\e[34mPath: $configPath\e[0m"
fi

function scale() {
  resources=$(./kubectl --kubeconfig="${configPath}" get deployment -n "${1}" -o jsonpath='{.items[*].metadata.name}')
  for resource in $resources; do
    echo "[Scale] Deployment: ${1} / ${resource} <== $2"
    ./kubectl --kubeconfig="${configPath}" scale deployment "$resource" -n "$1" --replicas="$2"
  done
}


# 获取所有命名空间
namespaces=$(./kubectl --kubeconfig="${configPath}" get namespaces -o jsonpath='{.items[*].metadata.name}')

# 打印命名空间
echo -e "\e[32;1mScan Namespace ....\e[0m"
for namespace in $namespaces; do
  echo -e "\e[32m > $namespace\e[0m"
done

if [ -z "${2}" ]; then
  echo "请输入命名空间名称";
  # shellcheck disable=SC2162
  read scaleNamespace
else
  scaleNamespace="${2}"
fi

if [ -z "${3}" ]; then
  echo "请输入伸缩数量";
  # shellcheck disable=SC2162
  read scaleNumber
else
  scaleNumber="${3}"
fi
scale "${scaleNamespace}" "${scaleNumber}"