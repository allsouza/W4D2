
class Employee

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        bonus = salary * multiplier
    end

    private
    attr_reader :name, :title, :salary, :boss

end