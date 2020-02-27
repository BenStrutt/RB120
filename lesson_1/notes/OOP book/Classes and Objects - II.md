# Classes and Objects - Part II

- **Class methods** are methods that we can call directly on the class itself, without having to instantiate any objects.

  - Sort of like `'hello'.upcase => "HELLO"`.

- When defining a **class method**, we prepend the method name with the reserved word `.self`, as follows:

  - ```ruby
    def self.what_am_i
      "I'm a GoodDog class!"
    end
    ```

  - `GoodDog.what_am_i  # => I'm a GoodDog class!`

- Class methods are where we put functionality that does not pertain to individual objects.

  - Objects contain *state*, and if we have a method that does not need to deal with states, then we can just use a class method.

- **Class variables** are variables used to capture information for the *entire class*, instead of *specific instances of that class*.

  - Class variables are created using `@@`. e.g. `@@number_of_instances`.

- ```ruby
  class GoodDog
    @@number_of_dogs = 0
  
    def initialize
      @@number_of_dogs += 1
    end
  
    def self.total_number_of_dogs
      @@number_of_dogs
    end
  end
  ```

- **Using 'self'**

  - `self` is used when calling setter methods from within the class.

  - ```ruby
    def change_info(n, h, w)
      self.name = n
      self.height = h
      self.weight = w
    end
    ```

  - `self` is used for class method definitions (*not* instance method definitions).

  - ```ruby
    def self.total_number_of_instances
      @@number_of_instances
    end
    ```

  - `self` references the *calling object*, or *instance*, when used inside an *instance method*
  - `self` references the *class itself* when used inside the *class definition* but outside an *instance method*.
    - Therefore, a method definition prefixed with `self` is the same as defining the method on the class.