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
# Коллекции в Ruby

## Базовые объекты
* Array
* Set
* SortedSet
* Range
* Hash

<!-- test -->

---
# Enumerable

```ruby
> [Array, Set, SortedSet, Range, Hash].map(&:ancestors).reduce(:&)
=> [Enumerable, Object, Kernel, BasicObject]
```

---
<!-- header: "Array" -->

# Array
*
  ```ruby
    array_by_literal_constructor = [0, 'one', 2.0]
  ```

*
  ```ruby
    array_by_default_constructor = Array.new([0, 'one', 2.0])
  ```

*
  ```ruby
    array_by_wrap_constructor = Array.wrap([0, 'one', [2.0]])
  ```

---
<!-- header: "Set" -->

# Set
*
  ```ruby
    set_by_literal_constructor = Set[0, 'one', 2.0]
  ```

*
  ```ruby
    set_by_default_constructor = Set.new([0, 'one', 2.0])
  ```

---
<!-- header: "SortedSet" -->

# SortedSet
*
  ```ruby
    sorted_set_by_literal_constructor = SortedSet[0, 'one', 2.0]
  ```

*
  ```ruby
    sorted_set_by_default_constructor = SortedSet.new([0, 'one', 2.0])
  ```

*
  ```ruby
    # <=> - spaceship operator
    > 1 <=> 2
      => -1
    > 2 <=> 2
      => 0
    > 3 <=> 2
      => 1
    > 'a' <=> 2
      => nil
  ```

---
<!-- header: "Range" -->
# Range
*
  ```ruby
    range_with_excluded_end = 0...2
    range_with_excluded_end.cover?(2) # => false
  ```

*
  ```ruby
    range_with_included_end = 0..2
    range_with_included_end.cover?(2) # => true
  ```

*
  ```ruby
    range_by_default_constructor = Range.new(0,2)
    range_by_default_constructor.cover?(2) # => true
  ```

---
<!-- header: "Hash" -->
*
  ```ruby
    hash_by_literal_constructor = { foo: 0, bar: 1, baz: 2 }
  ```

*
  ```ruby
    hash_by_default_constructor = Hash.new
  ```

*
  ```ruby
    hash_by_array_constructor = Hash['foo', 0, 'bar', 1, 'baz', 2]
  ```
