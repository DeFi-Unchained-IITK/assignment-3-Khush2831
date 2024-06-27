// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Q2.sol";

contract TestEmployeeRegistree {
    EmployeeRegistree employeeRegistree;

    function beforeEach() public {
        employeeRegistree = new EmployeeRegistree();
    }

    function testAddEmployee() public {
        employeeRegistree.addEmployee("Alice", "Developer", 1000);

        (string memory name, string memory position, uint salary) = employeeRegistree.getEmployeeDetails(1);
        
        Assert.equal(name, "Alice", "Employee name should be 'Alice'");
        Assert.equal(position, "Developer", "Employee position should be 'Developer'");
        Assert.equal(salary, 1000, "Employee salary should be 1000");
    }

    function testUpdateEmployee() public {
        employeeRegistree.addEmployee("Alice", "Developer", 1000);
        employeeRegistree.updateEmployee(1, "Alice", "Senior Developer", 1500);

        (string memory name, string memory position, uint salary) = employeeRegistree.getEmployeeDetails(1);

        Assert.equal(name, "Alice", "Employee name should be 'Alice'");
        Assert.equal(position, "Senior Developer", "Employee position should be 'Senior Developer'");
        Assert.equal(salary, 1500, "Employee salary should be 1500");
    }

}
