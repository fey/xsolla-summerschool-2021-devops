---
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
