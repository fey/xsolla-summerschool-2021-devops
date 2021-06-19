---
marp: true
paginate: true
footer: >
  ![width:64px height64px](https://raw.githubusercontent.com/Hexlet/assets/master/images/hexlet_logo128.png)
---

<style>
  section {
  width: 100%;
  height: 100vh;
  position: relative;
  background-color: #f6faff;
  color: black;
  font-family: Arial, Helvetica, sans-serif;
  font-size: 30px;
  padding: 40px;
}

footer {
  position: absolute;
  bottom: 40px;
}

h1,
h2 {
  text-align: center;
  margin: 0;
}
</style>

# Цель лекции

* Узнать, что такое Devops, CI/CD, Deploy
* Познакомиться с новыми полезными инструментами (Vagrant, Ansible)
* Научиться использовать новые инструменты и практики

---

# Новые инструменты

* Vagrant
* Ansible
* Github Actions, Gitlab CI
* Heroku

---

# Зачем нужно знать

* Код выполняется в разных средах - прод, тестовая, разработка (предсказуемость)
* Разработка ведется коллективо (эффективность)
* Важно получать фидбек как можно раньше (безопасность)

---

# Немного истории

* Патрик Дебуа
* Джон Оллспоу и Пол Хэммонд
* [10-plus deploys per day: dev and ops cooperation at Flickr](https://www.youtube.com/watch?v=LdOe18KhtT4)

<!--
История начинается в Бельгии 2007-ого с парня по имени
Патрик Дебуа. У Патрика была интересная цель: он хотел
изучить IT со всех сторон. Патрик был консультантом, но
выбирал вакансии так, чтобы поработать в каждой IT отрасли
Перейдём к 2009 году, когда Джон Оллспоу и Пол Хэммонд
вместе работали во Flickr. 23 июня на O'reilly’s Velocity
Сonference в Сан-Хосе они представили свой ныне знаменитый
доклад «10-plus deploys per day: dev and ops cooperation at Flickr»
-->

---

# Vagrant

* Инструмент для быстрого развертывания окружения для разработки на основе систем виртуализации.
* Виртуализация - Vmware, VirtualBox, Hyper-v
* Инфраструктура как код (Vagrantfile)

<!--
Инфраструктура как код (англ. Infrastructure-asCode; Iac) Это подход для управления и описания инфраструктуры
через конфигурационные файлы
 -->

---

# Vagrant

```sh
vagrant up # - создает виртуальную машину
vagrant halt # - останавливает виртуальную машину
vagrant destroy # - удаляет виртуальную машину
vagrant suspend # - "замораживает" виртуальную машину
vagrant global-status # - выводит список всех ранее созданных виртуальных машин в хост-системе
vagrant ssh # - подключается к виртуальной машине по SSH
```

---

# Vagrantfile

```ruby
Vagrant.configure("2") do |config|

  config.vm.box = "base"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y apache2
  SHELL
end
```

---

# Vagrant

## Зачем нужен, если есть Docker?

* Девелоперская машина с рабочим окружением
* Временная тестовая среда для экспериментов
* Поднять машину на другой ОС/архитектуре (Ubuntu, Centos, FreeBSD, Windows)
* Поднять инфраструктуру (веб-сервера, балансеры, база)

<!--
https://github.com/fey/dotfiles
https://github.com/fey/infrastructure-experiments

http://www.vagrantbox.es/
https://app.vagrantup.com/boxes/search
-->

---

# Управление конфигурацией

<!--
https://guides.hexlet.io/configuration-management/

Новая машина содержит только основную операционную систему с небольшим набором предустановленных программ. Перед тем как запустить на ней какой-то сервис, например, обычный сайт, понадобится установить дополнительные пакеты. Набор пакетов зависит от стека технологий, на котором он написан. Если сайт “завернут” в Docker, то настройка значительно упрощается и сводится к установке самого Docker. В остальных случаях придется потратить какое-то время на донастройку и конфигурирование. Помимо пакетов, часто требуется настраивать саму систему, менять конфигурационные файлы, права на файлы и директории, создавать пользователей и так далее:
-->

  ```sh
  # Заходим на удаленную машину (Сервер на Ubuntu)
  ssh root@ipaddress

  # Создание пользователя для деплоя. Где-то здесь копируются ssh ключи
  sudo adduser deploy

  sudo apt install curl
  # установка Node.js
  curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt install nodejs
  # установка и настройка Nginx
  sudo apt install nginx
  vim /etc/nginx/default.conf

  # Формирование структуры директорий для сервиса
  mkdir -p /opt/hexlet/versions/
  ```

---

# Автоматизация настройки сервера

## Bash-скрипты

```sh
# Копирование на сервер с помощью scp
scp mybashscript.sh root@ipaddress:~/

# Заходим на сервер и запускаем скрипт
ssh root@ipaddress
sh ~/mybashscript.sh
```

---

# Автоматизация настройки сервера

## Bash-скрипты

<!-- Если перенести команды в bash-скрипт “как есть”, без модификации, то, скорее всего, нам придется постоянно следить за выводом и не забывать подтверждать установку пакетов, так как это поведение по умолчанию
Другая проблема серьезнее, она связана с понятием “идемпотентность”. Что будет если выполнить команду создания директории два раза?
Команда завершится с ошибкой, она не идемпотентна. То есть последовательные вызовы одной и той же команды приводят к разному результату. Идемпотентность для настройки сервера очень важна. Иначе повторный запуск скрипта настройки завершится с ошибкой. А повторные запуски нужны, например в случае отладки самого скрипта, когда мы его только пишем и проверяем как он работает. В случае с командой mkdir идемпотентности добиться легко, достаточно добавить флаг -p:
-->

```sh
# # Скрипт останавливается и ждет ответа
➜  ~ apt install golang
The following additional packages will be installed:
  golang-1.13 ...
After this operation, 329 MB of additional disk space will be used.
Do you want to continue? [Y/n]
apt install -y golang
# будет ошибка
mkdir /hexlet
mkdir /hexlet # ?
# ошибки не будет
mkdir -p /hexlet
mkdir -p /hexlet
```

---

# Идемпотентность

Идемпотентность — это свойство, которое команда развертывания всегда задает целевую среду в той же конфигурации независимо от состояния запуска среды.

<!--
https://docs.microsoft.com/ru-ru/devops/deliver/what-is-infrastructure-as-code
 -->

---

# Ansible

* Автоматизировать процесс настройки локального окружения и удаленных серверов
* Автоматизировать процесс сборки, деплоя
* Инфраструктура как код
* Обеспечивает идемпотентность


---

# Ansible

```sh
ansible             ansible-console     ansible-inventory   ansible-pull
ansible-config      ansible-doc         ansible-lint        ansible-vault
ansible-connection  ansible-galaxy      ansible-playbook
```

```makefile
install:
	ansible-galaxy install -r requirements.yml

ping:
	ansible -i inventory.yml all -m ping

deploy:
	ansible-playbook playbook.yml -i inventory.ini --vault-password-file vault-password
```

<!--
https://github.com/fey/dotfiles
https://github.com/fey/devops-for-programmers-project-lvl2
https://galaxy.ansible.com/
-->

---

# Continious integration

![ci example](assets/hexlet-ci.jpg)

<!--
https://www.atlassian.com/ru/continuous-delivery/continuous-integration
-->

---

# Continious integration

Непрерывная интеграция (CI) - это практика автоматизации интеграции изменений кода от нескольких авторов в единый программный проект.

Отсутвие CI приводит к :

* Необходимости самостоятельно координировать действия и общаться при внесении изменений. кода в конечный продукт

* Github Actions
* Gitlab CI
* Jenkins

---

# Continious integration

## Github Actions

* Бесплатно для открытых репозиториев
* Тарифы для закрытых репозиториев
* Есть Экшены - готовые скрипты
* Подходит для различных учебных и пет-проектов

<!--
https://github.com/Hexlet/hexlet-sicp
https://github.com/Hexlet/hexlet-cv/blob/master/.github/workflows/push.yml
https://github.com/hexlet-boilerplates/php-package/blob/master/.github/workflows/workflow.yml
-->

---


# Continious integration

## Gitlab CI

* Часто используется
<!--
https://gitlab.com/feycot/xsolla-summer-school-backend-2021
-->
