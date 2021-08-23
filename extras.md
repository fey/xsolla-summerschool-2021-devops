
## Github Actions

* *.github/workflows/<workflow_name>.yml*
* Бесплатно для открытых репозиториев
* Есть Экшены - готовые скрипты
* Подходит для различных учебных и пет-проектов

<small>[Пример Github Actions для проекта на Laravel (PHP)](https://github.com/hexlet-components/php-laravel-blog/blob/master/.github/workflows/master.yml) </small>

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

https://github.com/Hexlet/hexlet-sicp
https://github.com/Hexlet/hexlet-cv/blob/master/.github/workflows/push.yml
https://github.com/hexlet-boilerplates/php-package/blob/master/.github/workflows/workflow.yml

## Gitlab CI

* Конфиг для CI берется из *.gitlab-ci.yml*
* Позволяет использовать шаблоны
* Можно развернуть на своей инфраструктуре

<img src="/gitlab-ci-interface.png" />

Код справа и изображение выше не связаны между собой

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

https://gitlab.com/feycot/xsolla-summer-school-backend-2021
[](examples/ci/gitlab/ci-cd-capistrano-gitlab-ci.yml)
[](examples/ci/gitlab/ci-docker-gitlab-ci.ymll)

# Стратегии деплоя - A/B testing

* A/B testing - деление трафика по определенному признаку

<img src="/deploy-strategies/a-b.gif" class="w-120">

# Стратегии деплоя - Shadow

* Shadow - дублирование трафика на новую версию без влияния на основное приложение
* Могут возникнуть сложности - например задвоение платежных запросов

<img src="/deploy-strategies/shadow.gif" class="w-120">

<!--
https://thenewstack.io/deployment-strategies/
-->

## А куда деплоить?

* Shared hosting - хостинги с веб-панелькой с предустановленным софтом
* Clouds - облачные провайдеры и выделенные сервера
* Github Pages - подойдет для статики и документации.
* Surge.sh и тд - для документации и статики. Эта презентация задеплоена на surge.sh :)
* Remote server - железный сервер, который находится где-то удаленно или под столом админа
* PaaS, serverless - типа Heroku. Максимально далеко уходим от администрирования.

# Heroku

* Бесплатно для маленьких проектов
* Можно подключить домен
* Можно подключить базу, редис и тд
* CLI для управления приложением

* Можно автоматизировать деплой, добавив в CI-скрипт шаг с деплоем на хероку.
* Heroku может интегрироваться с Github, тогда будет автодеплой по коммиту в нужной ветке (коммит должен быть в Github)

![](/heroku-deploy.gif)

## Digital Ocean

* Создание чистых или преднастроенных машин (С докером, приложениями)
* Создание базы данных, кластеров Kubernetes
* Парковка домена
* При регистрации по [ссылке](https://m.do.co/c/e702f9a99145) выдают 100$ на 60 дней
* Достаточно простой интерфейс и тарификация. Можно создать приложение по типу как в Heroku (но стоит это дороже), вместо ручной конфигурации сервера

Альтернативы DO: Amazom Web Services, Linode и другие облачные провайдеры
