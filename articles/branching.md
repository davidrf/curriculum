---
title: Branching & Conditionals
topic: control-flow
---

This article introduces conditional expressions and logical branching in Ruby. This is the building block of writing intelligent programs.

## Learning Goals

* Apply boolean logic in a Ruby context
* Analyze a provided scenario, and generate outcomes using boolean logic in Ruby
* Apply different boolean evaluations for different data types
* Utilize an `if` conditional
* Incorporate `else` behavior

## Branching

In just about every programming language, there is the concept of a **conditional expression**. Conditional expressions allow us to run some code only when a given condition is true. In Ruby (and most other programming languages), the most basic conditional expression involves `if` in the form of:

```ruby
if <condition>
  <do something here>
end
```

Here, we define the `condition` and `do something here` parts. For example, if we happened to be writing a banking application, we might use a snippet like the one below.

```ruby
# if the balance falls below the minimum, charge a fee
MINIMUM_BALANCE = 20
if balance < MINIMUM_BALANCE
  balance = balance - LOW_BALANCE_FEE
  puts "Have a nice day!"
end
```

Here we want to do something (charge a fee) _only_ if a certain condition is met (balance is too low). In the case where `balance` is greater than whatever `MINIMUM_BALANCE` is set to, then we don't charge the fee.

Sometimes we want to choose between two different actions based on one condition, and for this we can use the `else` keyword.

```ruby
#set ticket price based on age
SENIOR_AGE_LIMIT = 65
if age >= SENIOR_AGE_LIMIT
  ticket_price = 7.00
else
  ticket_price = 10.00
end
```

The condition is evaluated (is `age` greater than the `SENIOR_AGE_LIMIT`) and if it is true, the code between `if` and `else` is evaluated, otherwise the code between `else` and `end` is evaluated.

#### Conditions

In a previous example, we checked whether a given balance was less than the minimum balance which is a fairly straightforward true or false question.  If it's true, run the code in the if block, if it's false, do nothing. So what else could we use for a condition in an `if` statement? In Ruby, just about anything.

When the Ruby interpreter evaluates a boolean expression, we say that the expression **returns** true or false. That return value determines how the `if` statement will behave. `irb` is an excellent tool for understanding what various expressions will return. After evaluating an expression, `irb` will output the return value on the next line in the form of `=> return_value`. Just as everything in ruby is an object, ruby methods and expressions  typically always provide a return value.

```no-highlight
2 > 1
 => true

1 > 2
 => false

3 == 4
 => false

3 != 4
 => true
```

In the first example, we're asking `irb` whether 2 is greater than 1, and it tells us that is true on the next line. Then we ask is 1 greater than 2 (false), is 3 equal to 4 (false), and is 3 not equal to 4 (true).

But what about other expressions and their return values? For example, let's observe what happens when we make a call to `puts`. Let's try it out in IRB.

```no-highlight
puts 'i like pizza'
i like pizza
 => nil
```

In this case the `puts` expression outputs the given string, but the return value is actually `nil`. How does `nil` work with an `if` statement?

```ruby
if nil
  puts 'nil is true!'
else
  puts 'nil is false!'
end
```

The above code will output `nil is false!`. In Ruby, any expression that returns `false` or `nil` is considered false, whereas every other expression is considered true. In the example above, `if nil` is evaluated to be false, so the `else` branch is executed instead.

```ruby
if "string"
  puts "'string' is true"
else
  puts "'string' is false"
end
```

In this case the object "string" evaluates to true so the `if` branch is executed. It's important to note that in this case, the `else` block **never** runs.

```ruby
if "string"
  puts "'string' is true"
else
  this_variable_would_cause_an_error
end
```

Normally, in the else block above, we would expect `this_variable_would_cause_an_error` to cause an "Undefined local variable or method" error. Because "string" always evaluates to true, the line in the else block never gets executed so the error never gets raised.

#### Combining conditions

In all of the previous examples, we had a single condition that we were testing against but it's quite common that you want to check multiple things before making a decision. Let's look a set of conditionals that are nested.

```ruby
if age >= SENIOR_AGE_LIMIT
  ticket_price = 7.00
else
  if age <= CHILD_AGE_LIMIT
    ticket_price = 7.00
  else
    ticket_price = 10.00
  end
end
```

This starts to get convoluted and hard to read as we add more conditions. Instead we can combine multiple conditions together using `and` or `or`

```ruby
if age >= SENIOR_AGE_LIMIT or age <= CHILD_AGE_LIMIT
  ticket_price = 7.00
else
  ticket_price = 10.00
end
```

When using `or` the `if` branch will run if either of the conditions is true. When using `and` the `if` branch will only run if _both_ of the conditions are true.

#### Logical Operators

The `and` and `or` operators are known as logical operators and can also be written as `&&` and `||` which is how they appear in many other programming languages. These operators are considered more conventional as opposed to their correlating `and`  and `or` counterparts.

Ruby also supports the logical XOR operator `^` which returns true if one of the conditions is true but not both (e.g. `true ^ false == true` but `true ^ true == false`).

#### Negation

We can do a lot more than just compare numbers in our conditional expressions. Many Ruby objects offer methods that will return true or false. For example, if we had a program that processed other Ruby files, we might have a check like the one below.

```ruby
if file_name.end_with?('.rb')
  # Filename looks OK, don't issue an error...
else
  puts 'ERROR: file must end with a Ruby extension (.rb)!'
  abort
end
```

Here, we use the `.end_with?` method which returns true if the string ends with the characters `.rb` (which is the extension for a Ruby file). If the file does not end with `.rb`, the else branch will be run issuing an error and exiting the program early.

What we're really testing for is that the file doesn't end with `.rb` since we want to issue a warning and end early: our _if_ branch is empty and not doing anything. What would be useful is if we had a method similar to `.end_with?` that returns true if the string does not end with the given characters.

We can do this using Ruby's negation operator `!`. When you put `!` before an expression, it will return the opposite truth value: `true` values will become `false`, and `false` values become `true`:

```no-highlight
!true
 => false

!false
 => true
```

In our previous example, we can use the `!` operator to convert the `.end_with?` method to return true if the string does not end with `.rb`:

```ruby
if !file_name.end_with?('.rb')
  puts 'ERROR: file must end with a Ruby extension (.rb)!'
  abort
end
```

This is a little more intuitive than the previous example and we eliminated one of the branches. Less code is better!

#### unless

In the previous example, we used the negation operator `!` to reverse the `.end_with?` method's return value. Ruby also offers the `unless` statement which is very similar to an `if` statement except the code block will only run if the condition is _false_. For example, we could have written the previous example as:

```ruby
unless file_name.end_with?('.rb')
  puts 'ERROR: file must end with a Ruby extension (.rb)!'
  abort
end
```

The `unless` statement exists only to make this code look a little more like everyday language and is functionally equivalent to the previous example. Typically, you do not want to use the `unless` statement if you plan to have an `else` block. An `if` statement would be expected. We call these style decisions **ruby idioms**. We say that using an if/else combination is more **idiomatic** than using an unless/else combination.

#### Single Line Conditionals

Ruby has a shorthand syntax for conditionals with a single line code block. Consider the example below:

```ruby
if eggs == 0
  buy_eggs
end
```

We can make this a bit more concise using Ruby's single line conditional:

```ruby
buy_eggs if eggs == 0
```

Again, this is merely a shortcut in Ruby to make our code look more readable. Both examples are functionally equivalent.

### Chaining

Sometimes we have a series of tests we want to check in order, stopping at the first one that passes. Consider the example of assigning someone a letter grade based on their average score:

```ruby
if score >= 90.0
  grade = 'A'
else
  if score >= 80.0
    grade = 'B'
  else
    if score >= 70.0
      grade = 'C'
    else
      if score >= 60.0
        grade = 'D'
      else
        grade = 'F'
      end
    end
  end
end
```

The nested conditionals are a bit messy looking here. Recall that we always want our code to be more expressive and readable. We can actually chain together a bunch of `if..else` statements using the `elsif` keyword:

```ruby
grade = nil
if score >= 90.0
  grade = 'A'
elsif score >= 80.0
  grade = 'B'
elsif score >= 70.0
  grade = 'C'
elsif score >= 60.0
  grade = 'D'
else
  grade = 'F'
end
```

This is a bit easier to read, has less code, and reduces the deep nesting we had before. Win-win-win!

#### The Case Statement

Alternatively, we can incorporate a conditional that is rarely used. The `case` statement allows us to specify a similar construct:

```ruby
case
when score >= 90
  grade = 'A'
when score >= 80
  grade = 'B'
when score >= 70
  grade = 'C'
when score >= 60
  grade = 'D'
else
  grade = 'F'
end
```

This example is functionally equivalent to the one above it.

### Why This Matters

#### Flow Control Is What Makes Software Intelligent

Our ability as developers to handle different events in our software makes for more interesting programs. The use of boolean logic and conditionals allow us to bake more intelligence into the code, resulting in more efficiencies for the software's user.
