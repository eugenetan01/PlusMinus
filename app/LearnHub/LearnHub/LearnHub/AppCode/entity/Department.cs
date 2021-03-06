﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Department
    {
        private string dept_name;
        private double projectedBudget;
        private double actualBudget;
        private User dept_head;

        public Department() { }
        public Department (string dept_name, double projectedBudget, double actualBudget, User dept_head)
        {
            this.dept_name = dept_name;
            this.projectedBudget = projectedBudget;
            this.actualBudget = actualBudget;
            this.dept_head = dept_head;
        }
        public string getDeptName()
        {
            return dept_name;
        }
        public void setDeptName(string dept_name)
        {
            this.dept_name = dept_name;
        }
        public double getProjectedBudget()
        {
            return projectedBudget;
        }
        public void setProjectedBudget(double projectedBudget)
        {
            this.projectedBudget = projectedBudget;
        }
        public double getActualBudget()
        {
            return actualBudget;
        }
        public void setActualBudget(double actualBudget)
        {
            this.actualBudget = actualBudget;
        }
        public User getDeptHead()
        {
            return dept_head;
        }
        public void setDeptHead(User dept_head)
        {
            this.dept_head = dept_head;
        }
    }
}