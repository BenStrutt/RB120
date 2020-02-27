# Inheritance

- **Inheritance** is when a class **inherits** behavior from another class.

  - The class that is inheriting behavior is called the *subclass* and the class that it inherits the behavior from is called the *superclass*.

  - **Inheritance** is used to extract common behaviors from classes that share behaviors to one *superclass*.

    - An example is an `Animal` class that has behaviors inherited by multiple animal *subclasses* (`Dog`, `Cat`, `Horse`).

  - Inheritance is signified with the `<` operator.

    - `subclass < superclass`

  - ```ruby
    class Animal
      def speak
        "Hello!"
      end
    end
    
    class Dog < Animal
    end
    
    sparky = Dog.new
    puts sparky.speak   # => Hello!
    ```

  - Ruby checks the object's class for a called method first before looking in the superclass for the method. This allows us to override methods inherited by a superclass

- **The super function:**

  - When you call `super` from within a method, it will search the inheritance hierarchy for a method by the same name and then invoke it.

    - ```ruby
      class Animal
        def speak
          "Hello!"
        end
      end
      
      class GoodDog < Animal
        def speak
          super + " from GoodDog class"
        end
      end
      
      sparky = GoodDog.new
      sparky.speak        # => "Hello! from GoodDog class"
      ```

  - `super` is commonly used in the `initialize` instance method.

    - ```ruby
      class Animal
        attr_accessor :name
      
        def initialize(name)
          @name = name
        end
      end
      
      class BadDog < Animal
        def initialize(age, name)
          super(name)
          @age = age
        end
      end
      
      BadDog.new(2, "bear")        # => #<BadDog:0x007fb40b2beb68 @age=2, @name="bear">
      ```

- **Mixing in Modules**

  - Use *modules* to *mix in* common behaviors across different classes.

    - Hierarchy example:

    - ```ruby
      module Swimmable
        def swim
          "I'm swimming!"
        end
      end
      
      class Animal; end
      
      class Fish < Animal
        include Swimmable         # mixing in Swimmable module
      end
      
      class Mammal < Animal
      end
      
      class Cat < Mammal
      end
      
      class Dog < Mammal
        include Swimmable         # mixing in Swimmable module
      end
      ```

  - *A common naming convention for Ruby is to use the "able" suffix on whatever verb describes the behavior that the module is modeling.*

- **Inheritance vs Modules**

  - Inheritance from a module (`include Module`) is sometimes called **interface inheritance**.
  - Things to consider when deciding whether to use *class inheritance* vs *mixin module*:
    - You can only sublass (*class inheritance*) from one class. You can mix in (*include*) as many modules as you like (*interface inheritance*).
    - "is-a" relationships are normally *class inheritance*. "has-a" relationships are normally *interface inheritance* (*mixin modules*).
      - e.g. a dog "is a" animal and "has a" ability to swim.
    - You cannot instantiate modules. Modules are used only for grouping common methods together to keep code DRY.

- **Method Lookup Path**

  - The order in which we include modules is important for method lookups.
    - If two included (mixed - in) modules have the same method name, Ruby will find it in the module included *last*.
    - Ruby lookup path looks as follows:
      - Calling class
      - Included modules
      - Inherited classes (superclasses)
      - Modules included by inherited superclasses

- **More Modules**

  - We can use modules to group related classes.

  - **Namespacing**, in this context, refers to organizing similar classes under a module.

  - This is done by defining classes *inside a module definition*.

    - ```ruby
      module Mammal
        class Dog
          def speak(sound)
            p "#{sound}"
          end
        end
      
        class Cat
          def say_name(name)
            p "#{name}"
          end
        end
      end
      ```

  - Classes in a module are called by appending the class name to the module name with two colons `::`.

    - `buddy = Mammal::Dog.new`
    - `kitty = Mammal::Cat.new`

  - A second use case for modules is using them as a **container** for methods, called *module methods*.

  - Methods defined in this manner are defined as follows:

    - ```ruby
      module Mammal
        ...
      
        def self.square_a_number(num)
          num ** 2
        end
      end
      ```

  - Module methods are called as follows:

    - `Mammal.square_a_number(4)`

- **Private, Protected, and Public**

  - A **public** method is an instance method that is available to be called in the rest of the program.

    - ```ruby
      class Dog
        attr_accessor :years
        def initialize(years)
          self.years = years 
        end
        
        def say_years
          puts "I am #{years} years!"
        end
      end
      
      rissa = Dog.new(8)
      rissa.say_years   # => I am 8 years!
      ```

    - `say_years` is a *public method* because it can be called on the `Dog` object in our program.

  - A **private** method is a method that does work inside a class but doesn't need to be available to the rest of the program.

    - ```ruby
      class Dog
        attr_accessor :years
        def initialize(years)
          self.years = years 
        end
        
        def say_years
          puts "I am #{dog_years} years!"
        end
          
        private
          
        def dog_years
          years * 7
        end
      end
      
      rissa = Dog.new(8)
      rissa.say_years   # => I am 56 years!
      ```

    - `dog_years` is a *private method* because it can not be called by the rest of our program, and is only used for calculation inside the class.

    - *Private methods* are any methods that are defined below the `private` method call in a class.

  - *Public* methods and *private* methods are the most common.

  - **Protected** methods are far less common and the knowledge of them isn't transferrable to other languages.

    - *Protected* methods behave like *private* methods outside the class definition, and like *public* methods inside the class definition.

- **Accidental Method Overriding**

  - Every class that is created in Ruby inherently subclasses from class 'Object'. The `Object` class is built into Ruby and comes with many critical methods.
    - This means that methods defined in the `Object` class are available in *all classes*.
  - It is important to remember that a *subclass* can override a *superclass's* method.
    - If you accidentally define a method that was originally defined in the `Object` class, it could have far-reaching effects on your code.