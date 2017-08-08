﻿using System;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Emma.DAO;
using Emma.Entity;

namespace LearnHub
{
    public partial class askEmmaInitializeMsg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] != null)
            {
                User currentUser = (User)Session["currentUser"];

                if (!currentUser.getDepartment().Equals("hr"))
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    if(!IsPostBack)
                    {
                        gvMessages.DataBind();
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validations
            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            cbimDAO.insertMessage(txtMsgInput.Text);
            Response.Redirect("/askEmmaInitializeMsg.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            int counter = 0;
            int[] messageIDs = (from p in Request.Form["messageID"].Split(',')
                                 select int.Parse(p)).ToArray();
            foreach (int messageID in messageIDs)
            {
                cbimDAO.updateInitializationLevel(messageID, counter);
                counter++;
            }
            Response.Redirect("/askEmmaInitializeMsg.aspx");
        }
    }
}