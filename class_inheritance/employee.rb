
class Employee

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        if !@boss.nil? 
            @boss.add_employee(self)
        end
    end

    def bonus(multiplier)
        bonus = salary * multiplier
    end

    def inspect
        { 'name' => @name, 'title' => @title, 'salary' => @salary }.inspect
    end

    protected
    attr_reader :name, :title, :salary, :boss

end