﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class manageCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Boolean superuser = false;
                Boolean course_creator = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                    else if (s.Equals("course creator"))
                    {
                        course_creator = true;
                    }
                }
                if (superuser || course_creator)
                {

                }
                else
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation

            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            CourseCategory cc = new CourseCategory();
            cc.category = txtCategory.Text;
            cc.status = "active";
            int createdCourseCattID = cecDAO.createCategory(cc);

            //set audit
            User currentUser = (User)Session["currentUser"];
            Audit a = new Audit();
            AuditDAO aDAO = new AuditDAO();
            a.userID = currentUser.getUserID();
            a.functionModified = "course category";
            a.operation = "create";
            a.id_of_function = createdCourseCattID.ToString();
            a.dateModified = DateTime.Now;
            a.remarks = "category name: " + txtCategory.Text;
            aDAO.createAudit(a);
        }
    }
}