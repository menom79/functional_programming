defmodule Employee do
  defmodule Job do
    @jobs [:none, :coder, :designer, :manager, :ceo]

    def next_job(:none), do: :coder
    def next_job(:coder), do: :designer
    def next_job(:designer), do: :manager
    def next_job(:manager), do: :ceo
    def next_job(:ceo), do: :ceo
  end

  defstruct first_name: "",
            last_name: "",
            id_number: nil,
            salary: 0,
            job: :none

  def new_employee(attrs \\ %{}) do
    id_number = attrs[:id_number] || generate_id()
    %Employee{attrs | id_number: id_number}
  end

  defp generate_id do
    Enum.max(@employees, fn emp -> emp.id_number end, 0) + 1
  end

  def promote(%Employee{job: :none} = employee) do
    %Employee{employee | job: Job.next_job(:none), salary: 0}
  end

  def promote(%Employee{job: current_job} = employee) do
    next_job = Job.next_job(current_job)
    %Employee{employee | job: next_job, salary: (next_job - :none) * 2000}
  end

  def demote(%Employee{job: :none} = employee) do
    %Employee{employee | salary: 0}
  end

  def demote(%Employee{job: current_job} = employee) do
    %Employee{employee | job: Job.next_job(current_job), salary: (current_job - :none - 1) * 2000}
  end
end

# Example Usage:

# Create new employees
employee1 = Employee.new_employee(first_name: "Mamun", last_name: "Iqbal")
employee2 = Employee.new_employee(first_name: "Asif", last_name: "Ahmed", id_number: 1)

IO.puts("Original Employees:")
IO.inspect(employee1)
IO.inspect(employee2)

# Promote and demote employees
promoted_employee = Employee.promote(employee1)
demoted_employee = Employee.demote(promoted_employee)

IO.puts("Promoted Employee:")
IO.inspect(promoted_employee)

IO.puts("Demoted Employee:")
IO.inspect(demoted_employee)
