require_relative 'employee'
require 'byebug'

class Manager < Employee

    def initialize(name, title, salary, boss)
        super
        @employees = []
    end

    def bonus(multiplier)
        salary_sum = 0
        queue = employees.map {|employee| employee}

        while !queue.empty?
            if queue.first.is_a?(Manager)
                queue += queue.first.employees.map{|employee| employee}
            end
            salary_sum += queue.shift.salary
        end
        salary_sum * multiplier
    end

    def add_employee(some_employee)
        employees << some_employee
    end

    protected
    attr_reader :employees
end

p ned = Manager.new("Ned", "Founder", 1000000, nil)
p darren = Manager.new("Darren", "TA Manager", 78000, ned)
p shawna = Employee.new("Shawna", "TA", 12000, darren)
p david = Employee.new("David", "TA", 10000, darren)

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
