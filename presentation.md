---
theme: default
background: cover
layout: quote
---

# CI/CD, Deploy — инструменты и практики

## Николай Гагаринов, Hexlet

---
layout: two-cols
---

# Обо мне

* Занимаюсь профессиональной разработкой с 2019
* Программист, наставник и ментор
* Пропагандирую опенсорс

::right::

![](/me.jpg)

---

# Цель лекции

* Познакомиться с инструментами Vagrant и Ansible
* Узнать узнать полезные практики из Devops методологии
* Научиться строить CI/CD, хотя бы простое

---

# Что будет в этой лекции

* Пара слов про девопс (история, профиты)
* Инфраструктура как код
* Vagrant, управление конфигурацией, Ansible
* Continuous integration, деплой
* Стратегии деплоя
* Итоги, ссылки, литература, задание

# Рассматриваемые инструменты

* Vagrant
* Ansible
* Github Actions, Gitlab CI
* Heroku

Плюс нам может пригодиться Docker, bash и вообще знания Unix систем :)

---
layout: center
---
# О Devops кратко

---

# DevOps

* Это методология (принципы и способы)
* Родился примерно в 2008 году
* Про эффективные коммуникации (не только между админами и разрабами)
* Патрик Дебуа — с него всё началось
* Джон Оллспоу и Пол Хэммонд запилили доклад [10-plus deploys per day: dev and ops cooperation at Flickr](https://www.youtube.com/watch?v=LdOe18KhtT4)

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

# Почему Devops появился и широко распространился

* Раньше программисты только разрабатывали и отдавали код другим людям, которые его запускали на проде

* Отличались окружения, где код разрабатывался, тестировался, запускался

* Были избыточные коммуникации - много людей работало над проектом, нужно было договориться, кто может вносить изменения

* Между разработкой и доставкой на прод могло пройти много времени. Можно поздно узнать об обидном и простом баге

* Слабая автоматизация и хрупкие скрипты

---

# Что Devops принёс инженерам

* Полезные методологии и практики
  * Инфраструктура как код
  * Приложение 12 факторов
  * Stateless приложения (Docker)

* Устранение лишних коммуникаций и конфликтов в изменениях
  * Использование контроля версий
  * Модели ветвления, релизы, релиз-менеджеры

* Автоматизация и получение раннего фидбека
  * Мониторинг
  * Continuous Integration (CI)
  * Continuous delivery (CD)

И многое другое :)

---
layout: center
---

# Время для вопросов

В этом блоке было:

* Введение
* Devops

---
layout: center
---

# Инфраструктура как код

---

# Инфраструктура как код

> Wiki: Инфраструктура как код (англ. Infrastructure-asCode; Iac) Это подход для управления и описания инфраструктуры через конфигурационные файлы

Инфраструктура как код (IaaC) — модель в которой создание инфраструктуры пишется как код

* Окружение или инфраструктура описывается с помощью кода :)
* Нужны изменения? Пишем код
* Если мы выполним код, то получим то состояние, которое актуально
* Декларативное описание

* Пример IaaC:
  * Docker - описываем образы
  * Dotfiles - конфиги и инструменты, которые накатываются скриптом
  * Vagrant - пишем конфиг для виртуалки, кладём все, что нужно

<small>[Dotfiles example](https://github.com/fey/dotfiles)</small>

---

# Зачем нужна IaaC?

* Код можно положить в репо
* Знание о инфраструктуре без необходимости лазать по серверам (характеристики, порты)
* Видим, какие изменения вносятся. Можем поревьювить или узнать, кто внёс
* Можно откатиться назад и посмотреть, где сломалось
* Не нужны бекапы :)
* Можно поделиться с другими разработчиками
* Есть инструменты, которые позволяют масштабировать изменения
* Описываем желаемое состояние
* Можно грохнуть сервер и поднять заново такой же :)

---
layout: center
---

# Vagrant

---

# Vagrant

* Инструмент для быстрого развертывания окружения для разработки на основе систем виртуализации.
* Виртуализация - Vmware, VirtualBox, Hyper-v
* Инфраструктура как код (Vagrantfile)

По сути, vagrant - это утилита командной строки, которая сильно упрощает управление виртуальными машинами для разработки.

---

# Создание виртуалки руками

1. Скачать Virtualbox и установить
2. Скачать образ
3. Создать новую машину, указать характеристики
4. Установить ОС с помощью образа
5. Пробросить директории (с хоста на виртуалку), порты, настроить сетевой адаптер
6. Установить нужные пакеты (скриптом или руками)

---

# Проблемы ручного настраивания

* Это долго
* Как поделиться готовым окружением с другим разработчиком?
* Как увидеть историю изменений (почему сделали так, а не так)

---

# Настройка виртуальной машины через Vagrant

1. Поставили Virtualbox, vagrant
2. Сделали `vagrant init` или скачали из репо проект
3. `vagrant up` и пошли пить чай
4. Работаем :)

---

# Плюшки Vagrant

* Нужное состояние системы описано в коде
* Нужно поменять состояние на желамое - написали код и выполнили
* Простой CLI интерфейс, создание, удаление виртуалок
* Одинаковое состояние виртуалки у разных разработчиков

---

# Зачем нужен Vagrant, если есть Docker?

* Девелоперская машина с рабочим окружением (а не просто контейнер с проектом)
* Временная тестовая среда для экспериментов
* Поднять машину на другой ОС/архитектуре (Ubuntu, Centos, FreeBSD, Windows)
* Поднять инфраструктуру на несколько серверов (веб-сервера, балансеры, база)

---

# Vagrant

```shell
vagrant up # - создает виртуальную машину
vagrant halt # - останавливает виртуальную машину
vagrant destroy # - удаляет виртуальную машину
vagrant suspend # - "замораживает" виртуальную машину
vagrant global-status # - выводит список всех ранее созданных виртуальных машин в хост-системе
vagrant ssh # - подключается к виртуальной машине по SSH
```

* https://www.vagrantup.com/ - оф.сайт
* https://app.vagrantup.com/boxes/search - здесь можно искать образы (боксы)
* http://www.vagrantbox.es/ - и здесь тоже

Команд много :)

---

# Пример Vagrantfile

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

<small>[Пример Vagrant с несколькими виртуальными машинами](https://github.com/fey/infrastructure-experiments/blob/master/Vagrantfile)</small>

---
layout: center
---

# Время для вопросов

В этом блоке было:

* Инфраструктура как код
* Vagrant

---
layout: center
---

# А что насчёт удаленных серверов?

* Хорошо, мы научились создавать локальное окружение одинаковым. А как это сделать для прода или удалённых серверов?
* Нам ведь нужно всего-то запустить там наше приложение, а не разрабатывать

---
layout: center
---

# Управление конфигурацией

---

# Управление конфигурацией

<!--
https://guides.hexlet.io/configuration-management/

Новая машина содержит только основную операционную систему с небольшим набором предустановленных программ. Перед тем как запустить на ней какой-то сервис, например, обычный сайт, понадобится установить дополнительные пакеты. Набор пакетов зависит от стека технологий, на котором он написан. Если сайт “завернут” в Docker, то настройка значительно упрощается и сводится к установке самого Docker. В остальных случаях придется потратить какое-то время на донастройку и конфигурирование. Помимо пакетов, часто требуется настраивать саму систему, менять конфигурационные файлы, права на файлы и директории, создавать пользователей и так далее:
-->

Подготовка свежего окружения под запуск приложения

  ```shell
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
layout: center
---

# Слишком сложно!

---
layout: two-cols
---

## Bash-скрипты

```shell
# Копирование на сервер с помощью scp
scp mybashscript.sh root@ipaddress:~/

# Заходим на сервер и запускаем скрипт
ssh root@ipaddress
sh ~/mybashscript.sh
```

::right::

![](/bash-meets-tools-meme.jpg)

---
layout: center
---

# Но не всё так просто

---

# Почему Bash-скрипты недостаточно хороши?

* При повторном запуске некоторые команды не будут выполняться также, как в прошлый раз.
* Нужно не забывать про необходимые флаги
* Чтобы понять, что происходит - нужны комментарии.
* А если в середине скрипта, что-то пошло не так, что тогда?
* Нарушается идемпотентность

<!-- Если перенести команды в bash-скрипт “как есть”, без модификации, то, скорее всего, нам придется постоянно следить за выводом и не забывать подтверждать установку пакетов, так как это поведение по умолчанию
Другая проблема серьезнее, она связана с понятием “идемпотентность”. Что будет если выполнить команду создания директории два раза?
Команда завершится с ошибкой, она не идемпотентна. То есть последовательные вызовы одной и той же команды приводят к разному результату. Идемпотентность для настройки сервера очень важна. Иначе повторный запуск скрипта настройки завершится с ошибкой. А повторные запуски нужны, например в случае отладки самого скрипта, когда мы его только пишем и проверяем как он работает. В случае с командой mkdir идемпотентности добиться легко, достаточно добавить флаг -p:
-->

```shell
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

> Идемпотентность – это свойство какой-либо операции, например, вызова функции или выполнения HTTP-запроса. Операция считается идемпотентной, если повторные выполнения приводят к тому же результату что и первое выполнение.

Команда развертывания всегда задает целевую среду в той же конфигурации независимо от состояния запуска среды.

<!--
https://docs.microsoft.com/ru-ru/devops/deliver/what-is-infrastructure-as-code
-->

---
layout: center
---

# На помощь приходит Ansible

---

# Ansible

* Автоматизировать процесс настройки локального окружения и удаленных серверов
* Автоматизировать процесс сборки, деплоя
* Инфраструктура как код
* Обеспечивает идемпотентность
* Описывает желаемое состояние

---

# Ansible

```shell
ansible             ansible-console     ansible-inventory   ansible-pull
ansible-config      ansible-doc         ansible-lint        ansible-vault
ansible-connection  ansible-galaxy      ansible-playbook
```

Команд очень много :). Не все они постоянно используются.
А ниже *Makefile* с примером использования Ansible

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

# Что можно сделать с помощью Ansible?

Да почти всё, что можно сделать в Bash :)

* Выполнить разовую команду (пингануть сервера, обновить кеш, получить какую-то информацию, типа аптайма)
* Написать playbook - yml файлик в котором будут выполняться последовательно команды.
* Спрятать секретные данные (пароли, токены) в хранилище (vault)
* Автоматизировать разные действия (деплой, подготовка окружения, создание файлов и тд)

<small>[Репозиторий с примерами по Ansible](https://github.com/ansible/ansible-examples)</small>

<small>[Bash vs Ansible примеры](https://hvops.com/articles/ansible-vs-shell-scripts/)</small>
---

# Пример плейбука Ansible

```yaml
---
- name: Update apt cache
  hosts: all
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

- name: Deploy to webservers
  hosts: all
  tasks:
    - name: Create Redmine container
      docker_container:
        name: redmine-app
        image: redmine:4.2.1
        ports:
          - 3000:3000
        state: started

- name: Setting up Datadog agent
  hosts: all
  roles:
    - role: datadog.datadog
```

Подготовка окружения, деплой приложения в Docker, запуск мониторинга Datadog

---
layout: center
---

# Время для вопросов

В этом блоке было:

* Управление инфраструктурой
* Идемпотентность
* Ansible

---
layout: center
---

# Continuous integration

---

# Continuous integration

> Wiki: Непрерывная интеграция (CI) - это практика автоматизации интеграции изменений кода от нескольких авторов в единый программный проект.

* В основе процесса CI лежит система контроля версий исходного кода (Git)
* Без CI возникает избыточная коммуникация. Необходимость координировать действия и договариваться при внесении изменений
* С использованием CI цикл релизов может сократиться (деплой несколько раз в день)
* Улучшение цикла обратной связи

---

# CI простым языкм

* Пишем код, пушим в гит
* Запускаются тестики и линтеры где-то там на сервере
* Мержим - снова тестики и линтеры
* Даже без тестов и линтеров - просто запускаем сборку (установку)
* Сложно? Нет

Для это презентации тоже был сделан CI :)

---

# CI-сервера

* Github Actions - бесплатный для открытых проектов
* Gitlab CI - часто используется в компаниях, бесплатный self-hosted
* Jenkins - не просто для CI, бесплатный и self-hosted, но я им не пользовался :)

Это только сервера, которые запускают последовательно команды. А запускать они могут что угодно - от баш-скриптов, до docker

---
layout: two-cols
---

# Github Actions

* *.github/workflows/<workflow_name>.yml*
* Бесплатно для открытых репозиториев
* Есть Экшены - готовые скрипты
* Подходит для различных учебных и пет-проектов

<small>[Пример Github Actions для проекта на Laravel (PHP)](https://github.com/hexlet-components/php-laravel-blog/blob/master/.github/workflows/master.yml) </small>

::right::

```yaml
name: PHP CI
on:
  - push
  - pull_request
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: '7.4'
      - name: Install
        run: make install
      - name: Run linter
        run: make lint
      - name: Run test & publish code coverage
        uses: paambaati/codeclimate-action@v2.6.0
        env:
          CC_TEST_REPORTER_ID: ${{ secrets.CC_TEST_REPORTER_ID }}
        with:
          coverageCommand: make test-coverage
          coverageLocations: ${{github.workplace}}/build/logs/clover.xml:clover
          debug: true
```

<!--
https://github.com/Hexlet/hexlet-sicp
https://github.com/Hexlet/hexlet-cv/blob/master/.github/workflows/push.yml
https://github.com/hexlet-boilerplates/php-package/blob/master/.github/workflows/workflow.yml
-->

---
layout: two-cols
---

# Gitlab CI

* Конфиг для CI берется из *.gitlab-ci.yml*
* Позволяет использовать шаблоны
* Можно развернуть на своей инфраструктуре

<img src="/gitlab-ci-interface.png" />

Код справа и изображение выше не связаны между собой

::right::

```yaml
default:
  image: docker/compose:debian-1.29.1
  services:
    - docker:dind
variables:
  COMPOSE_PROJECT_NAME: xsolla-summer-school-backend-2021-ci
  COMPOSE_FILE: docker-compose.yml
stages:
  - build
  - deploy
build:
  stage: build
  script:
    - docker-compose  build
    - docker-compose run app make setup
    - docker-compose up --abort-on-container-exit
deploy:
  stage: deploy
  dependencies:
    - build
  when: on_success
  only:
    - master
  script:
    - echo "RUN DEPLOY"
```

<!--
https://gitlab.com/feycot/xsolla-summer-school-backend-2021
[](examples/ci/gitlab/ci-cd-capistrano-gitlab-ci.yml)
[](examples/ci/gitlab/ci-docker-gitlab-ci.ymll)
-->

---
layout: center
---

# Деплой

---

# Деплой

Деплой – процесс “разворачивания” веб-сервиса, например, сайта, в рабочем окружении. Рабочее окружение – место где сайт запускается и доступен для запросов.

Пример шагов:

1. Оповещение о начале деплоя
1. Код проекта скачивается на сервер (обычно через клонирование Git)
1. Ставятся все необходимые зависимости
1. Выполняется процесс сборки, например собирается фронтенд-часть
1. Выполняются миграции. Миграции — SQL-скрипты, которые изменяют структуру базы данных
1. Запускается новая версия кода
1. Оповещение о завершении деплоя (или неудача)

Опционально - обработка ошибок, откат (rollback)

<!--
https://guides.hexlet.io/deploy/
-->

---

# Деплой

## Зачем автоматизировать?

* Нужно заходить на сервер
* Перезапуск сервисов
* Иногда нужно откатывать миграции
* Можно реализовать различные стратегии деплоя
* Zero downtime deployment

**Чем больше действий выполняется вручную, тем выше риск ошибки**

---

# Средства автоматизации деплоя

Инструменты зависят от того, каким образом запускается приложение
* Capistrano, Deployer - чтобы перезапустить что-нибудь или подготовить новую директорию или помочь в роллбеке (откате) деплоя
* Ansible ([deploy_helper](https://docs.ansible.com/ansible/latest/collections/community/general/deploy_helper_module.html#examples), [ansistrano](https://github.com/ansistrano/deploy)) - Тоже, что capistrano, deployer, только больше возможностей
* Docker - Просто указываем новый тег и деплоим :)
* Kubernetes - указываем нужный тег, применяем изменения, вот и деплой =)
* CI-сервера (Gitlab CI, Github Actions, Jenkins) - теперь мы можем деплоить не руками, а по коммиту
* Bash, Make. Можем спрятать процесс деплоя за простой командой `make deploy`. С деплоем справится даже верстальщик (если у него есть нужные доступы)

<!--
https://github.com/ansistrano/deploy
-->

---

# Ansible + Capistrano = Ansistrano

* [ansistrano/deploy](https://github.com/ansistrano/deploy)

<img src="/ansistrano-flow.png" />

---

## Start deploying in 3 steps

```yaml
---
- name: Deploy
  hosts: all
  vars:
    ansistrano_deploy_from: "{{ playbook_dir }}/"
    ansistrano_deploy_to: "/var/www/app"
    ansistrano_after_update_code_tasks_file: "{{ playbook_dir }}/after-update-code.yml"
    ansistrano_after_symlink_tasks_file: "{{ playbook_dir }}/after-symlink.yml"
    ansistrano_keep_releases: 3
  roles:
  - { role: ansistrano.deploy }
```

---

# Continuous Deployment

> Wiki: Непрерывное развертывание (CD) - это процесс выпуска ПО, который использует автоматизированное тестирование для проверки правильности и стабильности изменений в кодовой базе для немедленного автономного развертывания в производственной среде.

При создании этой презентации был использован CI/CD :)

---

# CI/CD Pipeline

<img src="/hexlet-ci.jpg" />

---
layout: center
---

# А как же про модель ветвления? Gitflow, github flow вот это вот всё?

Это не так важно, потому что зависит от того какие процессы у вас в команде.

* Деплой по коммиту в мастер - самый простой и удобный способ, если вы один или вас пара человек
* Релизы, девелоп, мастер, если не можете деплоить несколько раз в день, если у вас есть релизы
* Выберите ту модель, которая вам помогает, а не заставляет испытывать боль

---
layout: center
---

# Время для вопросов

В этом блоке было:

* Continuous integration
* CI-сервера
* Деплой
* Continuous Deployment
* CI/CD Pipeline

---
layout: center
---

# Стратегии деплоя

Стратегия деплоя - условно сопособ раскатки приложения, чтобы обеспечить отсутствие прерывания сервиса (zero-downtime deployment)

---

# Стратегии деплоя - Recreate

* Recreate - просто убиваем старую версию, запускаем новую
* Самый дешевый способ
* Подходит, если есть некая сессия и приложение в 1 экземпляре (например сервер игры)

<img src="/deploy-strategies/recreate.gif" class="w-120">

---

# Стратегии деплоя - Ramped

* Ramped (rolling-update or incremental) - Старая версия постепенно заменяется новой
* Требуется наличие балансера и минимум 2 сервера
* База данных должна уметь работать с новой и старой версией приложения

<img src="/deploy-strategies/ramped.gif" class="w-120">

---

# Стратегии деплоя - Blue/Green

* Blue/Green - новая версия живет вместе старой. Потом старая отключается
* Можно провести эксперименты с новой версией и боевой базой.

<img src="/deploy-strategies/blue-green.gif" class="w-120">

---

# Стратегии деплоя - Canary

* Canary - часть трафика уходит на новую версию
* Может подойти для экспериментов (тестировании фич)

<img src="/deploy-strategies/canary.gif" class="w-120">

---

# Стратегии деплоя - A/B testing

* A/B testing - деление трафика по определенному признаку

<img src="/deploy-strategies/a-b.gif" class="w-120">

---

# Стратегии деплоя - Shadow

* Shadow - дублирование трафика на новую версию без влияния на основное приложение
* Могут возникнуть сложности - например задвоение платежных запросов

<img src="/deploy-strategies/shadow.gif" class="w-120">

<!--
https://thenewstack.io/deployment-strategies/
-->

---

# Стратегии деплоя

<img src="/k8s-deployment-strategies.png" class="w-180">

---

# А куда деплоить?

* Shared hosting - хостинги с веб-панелькой с предустановленным софтом
* Clouds - облачные провайдеры и выделенные сервера
* Github Pages - подойдет для статики и документации.
* Surge.sh и тд - для документации и статики. Эта презентация заделпоена на surge.sh :)
* Remote server - железный сервер, который находится где-то удаленно или под столом админа
* PaaS, serverless - типа Heroku. Максимально далеко уходим от администрирования.

---
layout: two-cols
---

# Heroku

* Бесплатно для для маленьких проектов
* Можно подключить домен
* Можно подключить базу, редис и тд
* CLI для управления приложением

* Можно автоматизировать деплой, добавив в CI-скрипт шаг с деплоем на хероку.
* Heroku может интегрироваться с Github, тогда будет автодеплой по коммиту в нужной ветке (коммит должен быть в Github)

::right::

![](/heroku-deploy.gif)

---

# Digital Ocean

* Создание чистых или преднастроенных машин (С докером, приложениями)
* Создание базы данных, кластеров Kubernetes
* Парковка домена
* При регистрации по [ссылке](https://m.do.co/c/e702f9a99145) выдают 100$ на 60 дней
* Достаточно простой интерфейс и тарификация. Можно создать приложение по типу как в Heroku (но стоит это дороже), вместо ручной конфигурации сервера

Альтернативы DO: Amazom Web Services, Linode и другие облачные провайдеры

---
layout: center
---

# Время для вопросов

В этом блоке было:

* Стратегии деплоя
* Хостинги

---

# Литература

* "Цель. Процесс непрерывного совершенствования" Элияху Голдратт
* "Проект «Феникс». Роман о том, как DevOps меняет бизнес к лучшему" Джин Ким, Джордж Спаффорд, Кевин Бер
* "Kubernetes в действии" Лукша Марко

![bg right fit](/books/goal.jpg)
![bg right fit](/books/project-phoenix.jpg)
![bg right fit](/books/kubernetes-in-action.jpg)

---

# Итоги

* Немного коснулись, что такое Devops, подходы и практики
* Познакомились с новыми полезными инструментами (Vagrant, Ansible)
* Из каких инструментов собрать пайплайн CI/CD и автоматизировать деплой


---

# Домашнее задание

Применить полученные знания на практике. Добавить CI/CD, автоматизировать деплой на вашем тестовом проекте

---
layout: two-cols
---

# Ссылки

## Гайды

* [Что такое деплой?](https://guides.hexlet.io/deploy/)
* [Что такое "управление конфигурацией"?](https://guides.hexlet.io/configuration-management/)
* [Что такое хостинг и домен сайта простыми словами?](https://guides.hexlet.io/hosting/)
* [Что такое Makefile и как начать его использовать](https://guides.hexlet.io/makefile-as-task-runner/)
* [Чек-лист хороших инженерных практик в компаниях](https://guides.hexlet.io/check-list-of-engineering-practices/)

## Инструменты

* [Ansible](https://www.ansible.com/)
* [GitHub Actions Documentation](https://docs.github.com/en/actions)
* [GitLab CI/CD Examples](https://docs.gitlab.com/ce/ci/examples/README.html#contributed-examples)

::right::

## Видео

* [Инфраструктура как код](https://www.youtube.com/watch?v=m_5sos7i1Qk)
* [Вебинар: Stateful vs. Stateless ](https://www.youtube.com/watch?v=WPCz_U7D8PI)
* [Интервью с Алексеем Шараповым: о микросервисах](https://www.youtube.com/watch?v=OeUzjV6wPlc)
* [Никита Соболев — Автоматизируем все с Github Actions](https://www.youtube.com/watch?v=QoCSvwkP_lQ)

Помимо этого в репо презентации есть примеры кода и комментарии

---

# Контакты

* feycot@gmail.com
* https://github.com/fey
* https://gitlab.com/feycot
* https://www.linkedin.com/in/feycot/
* https://t.me/time2run

Задавайте вопросы, если что-то осталось непонятным, неуточненным, есть любопытство.
Тегайте меня, если хотите ревью ДЗ - с удовольствием помогу чем смогу

---
layout: end
---
