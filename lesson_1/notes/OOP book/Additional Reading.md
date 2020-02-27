# Additional Reading

- Any class you define should have a to_s instance method to return a string representation of the object.

  - This is particularly useful when calling calling the `#puts` method and passing it the object as an argument. The `puts` method calls `to_s` on the object and outputs it to the console.

- There are two ways to make an instance method *private*, *public*, or *protected*.

  - Methods can be declared as private by writing them below a `private` method call in the class.

    - ```ruby
      class Box
        attr_accessor :width, :height
          
        def initialize(width, height)
          @width = width
          @height = height
        end
        
        def output_area
          get_area
        end
          
        # private instance methods
        private
         
        def get_area
          height * width 
        end
      end
      ```

  - Methods can be declared as private by passing their name as a *symbol* into the `private` method call as an argument.

    - ```ruby
      class Box
        attr_accessor :width, :height
          
        def initialize(width, height)
          @width = width
          @height = height
        end
        
        def output_area
          get_area
        end
      
        def get_area
          height * width 
        end
        
        private :get_area
      end
      ```

- **superclass** and **subclass** can also be referred to as **base class** and **derived class**, respectively.

- Because *operators* are typically actually *methods* in Ruby, we can override these the same way we would override a method.

  - Writing `height * width` is equivalent to writing `height.*(width)`.

  - If we wanted, for whatever reason, to use the `*` operator as an exponential operator on integers, we could write the following code:

  - ```ruby
    class Integer
    	def *(int)
        self ** int
      end
    end
    ```

- To access class **constants** outside the class definition, we can use `::`.

  - `Class::CONSTANT`

- The `::` is called the **scope resolution operator**.

  - It's purpose is to tell Ruby *where* you're looking for a specific bit of code.

- Whereas `include` mixes a module's methods in at the instance level (allowing instances of a particular class to use the methods), the `extend` keyword methods at the *class* level. This means that the *class itself* can use the methods, as opposed to *instances* of the class.

- The basic programming concepts in OOP are:

  - **Abstraction**
    - Simplifying complex reality by modeling classes appropriate to the problem
  - **Polymorphism**
    - The process of using an operator or function in different ways for different data input.
  - **Encapsulation**
    - Hides the implementation details of a class from other objects.
  - **Inheritance**
    - A way to form new classes using behaviors from classes that have already been defined.