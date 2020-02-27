# Classes and Objects - Part 1

- When defining a class, we focus on two things: *states* and *behaviors*.

  - States track attributes for individual objects. 	(**instance variables**).
  - Behaviors are what objects are capable of doing.(**instance methods**).

- Instance variables are scoped at the object (or instance) level, and are how objects keep track of their states.

- We refer to the `initialize` method as a *constructor*, because it gets triggered whenever we create a new object.

- Instance variables are prefixed with `@`. (`@variable`)

- **Accessor methods** are *instance methods* defined to access *instance variables*.

- **Getter methods** return the value of an instance variable, and are defined as follows:

  - ```ruby
    def name
      @name
    end
    ```

- **Setter methods** assign/reassign the value of an instance variable, and are defined as follows:

  - ```ruby
    def name=(name)
      @name = name
    end
    ```

  - The `=` is included at the end so that the method can look as follows when called:
    - `sparky.set_name = "Spartacus"`

- The `attr_accessor` method will set these *getter* and *setter* methods for us. The `attr_accessor` method takes a **symbol** as an argument, which it uses to create the method name for the `getter` and `setter` methods.

  - The syntax looks like: `attr_accessor :name, :height, :weight`

- `attr_reader` and `attr_writer` methods also exist if you want instance variables that can only be read or written.

- **IMPORTANT**

  - It is generally a good idea to call the *getter* method inside *instance methods* instead of using the *instance variable* itself. (Explained by the SSN example in the book).

  - ```ruby
    def speak
      "#{@name} says arf!"
    end
    ```

  - ```ruby
    def speak
      "#{name} says arf!"
    end
    ```

  - Both of these return the same value. The second is better.

- Use `self.name = name` for assignment rather than `@name = name`. This calls the *setter method* `name=(name)`.

  