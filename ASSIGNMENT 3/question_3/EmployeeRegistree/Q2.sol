// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeRegistree {
    struct Employee {
        uint ID;
        string name;
        string position;
        uint salary;
    }

    mapping(uint => Employee) private employees;
    uint private nextId = 1;

    event EmployeeAdded(uint indexed ID, string name, string position, uint salary);
    event EmployeeUpdated(uint indexed ID, string name, string position, uint salary);
    event EmployeeDeleted(uint indexed ID, string name, string position, uint salary);

    function addEmployee(string memory _name, string memory _position, uint _salary) public {
        employees[nextId] = Employee(nextId, _name, _position, _salary);
        emit EmployeeAdded(nextId, _name, _position, _salary);
        nextId++;
    }

    function updateEmployee(uint _id, string memory _name, string memory _position, uint _salary) public {
        require(employees[_id].ID != 0, "Employee ID does not exist");
        employees[_id] = Employee(_id, _name, _position, _salary);
        emit EmployeeUpdated(_id, _name, _position, _salary);
    }

    function getEmployeeDetails(uint _id) public view returns (string memory, string memory, uint) {
        require(employees[_id].ID != 0, "Employee ID does not exist");
        Employee memory emp = employees[_id];
        return (emp.name, emp.position, emp.salary);
    }

    function deleteEmployee(uint _id) public {
        require(employees[_id].ID != 0, "Employee ID does not exist");
        Employee memory emp = employees[_id];
        emit EmployeeDeleted(_id, emp.name, emp.position, emp.salary);
        delete employees[_id];
    }
}
