﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaAddAns.aspx.cs" Inherits="LearnHub.askEmmaAddAns" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="Emma.DAO" %>
<%@ Import Namespace="Emma.Entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>
        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "enabled": true,
                    "position": "left"
                }
            });
        });

        function checkForm_Clicked(source, args) {

            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = false;
            }
            return false;
        }
    </script>
    <style>
        .form-group.required .control-label:after {
            content: "*";
            color: red;
            margin-left: 4px;
        }

        .pagination li > a,
        .pagination li > span,
        .pagination li > a:focus, .pagination .disabled > a,
        .pagination .disabled > a:hover,
        .pagination .disabled > a:focus,
        .pagination .disabled > span {
            background-color: white;
            color: black;
        }

            .pagination li > a:hover {
                background-color: #96a8ba;
            }

        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            background-color: #576777;
        }
            
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
  <li><a href="home.aspx">Home</a></li>
  <li><a href="emmaConfiguration.aspx">Emma Configuration</a></li>
  <li class="active">Manage Answers</li>
  </ul>

    <div class="container">
        <h1>Manage Emma's Answers
                        <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;New </button>
        </h1>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <div id="addForm" class="collapse">
                <fieldset>
                    <br />
                    <div class="form-group required">

                        <%--Intent--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="bottom" title="" data-original-title="Category of the Answer. For example, 'greeting', 'course enquiry'"></span>&nbsp; Choose a Category</label>

                        <div class="col-lg-10">
                            <%--Mandatory Choose 1--%>
                            <asp:DropDownList ID="ddlIntent" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="intent" DataValueField="intentID" AppendDataBoundItems="True">
                                <asp:ListItem Text="--Select--" Selected="true" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [intent], [intentID] FROM [ChatBotIntent] ORDER BY [intent]"></asp:SqlDataSource>
                            <asp:RequiredFieldValidator ID="rfv_ddlIntent" runat="server" ControlToValidate="ddlIntent" ErrorMessage="Please select a Category" InitialValue="0" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <strong>
                            <%--Entity--%>
                            <label for="txtEntity" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="bottom" title="" data-original-title="Keyword related to the Answer. For example, 'probation', 'chronic disease' "></span>&nbsp;Enter Keyword </label>
                        </strong>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtEntity" runat="server" CssClass="form-control" placeholder="eg. Chronic Disease"></asp:TextBox>
                            <br>
                        </div>
                    </div>
                    <div class="form-group required">
                        <strong>
                            <%--Answers--%>
                            <asp:Label ID="lblAnswers" CssClass="col-lg-2 control-label" runat="server" Text="Answer"></asp:Label>
                        </strong>
                        <div class="col-lg-10">
                            <%--Mandatory text field--%>
                            <asp:TextBox ID="txtAnswers" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="e.g Chronic Disease is a module about understanding the different types of chronic diseases."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_txtAnswers" runat="server" ErrorMessage="Please enter an Answer" ControlToValidate="txtAnswers" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <%--Buttons--%>
                    <br />
                    <div class="wrapper">
                        <div class="form-group">

                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return checkForm_Clicked();" CausesValidation="True" UseSubmitBehavior="False"/>
                            <%--Make success message appear after user click submit button IN MODAL, stay at this page so that user can continue submitting answers--%>
                        </div>
                        <%--<strong>
                                    <asp:Label ID="lblSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                                <strong>
                                    <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                                --%>

                    </div>



                </fieldset>
                <div class="verticalLine"></div><br />
            </div>           
        </div>
        <div class="container">
            <table class="table table-striped table-hover" id="ansTable" data-paging="true" data-sorting="true">
                <thead>
                    <tr>
                        <th id="answers" width="70%">Answers</th>
                        <th id="intent" data-breakpoints="xs sm" width="10%">Category</th>
                        <th id="entity" data-breakpoints="xs sm" width="10%">Keyword</th>
                        <th data-filterable="false" data-sortable="false" width="10%"></th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
                        List<ChatBotAnswer> allAnswers = cbaDAO.getAllChatBotAnswers();
                        foreach (ChatBotAnswer cba in allAnswers)
                        {
                            Response.Write("<tr>");
                            Response.Write($"<td id=\"answers\">{cba.answer}</td>");
                            Response.Write($"<td id=\"intent\">{cba.intent}</td>");
                            if (cba.entityName == null || cba.entityName.Equals(""))
                            {
                                Response.Write($"<td id=\"entity\">-</td>");
                            }
                            else
                            {
                                Response.Write($"<td id=\"entity\">{cba.entityName}</td>");
                            }
                            Response.Write("<td>");
                            //Response.Write($"<a href=\"#deleteModal\" data-toggle=\"modal\" class=\"btn btn-danger btn-sm pull-right\"> <span class=\"glyphicon glyphicon-trash\"></span></a>");
                            Response.Write($"<a href=\"askEmmaEditAns.aspx?id={cba.answerID}\" class=\"btn btn-info btn-sm pull-right\"><span class=\"glyphicon glyphicon-pencil\"></span></a>");
                            Response.Write("</td>");
                            Response.Write("</tr>");
                        }%>
                </tbody>
            </table>
        </div>


        <%--Modal for Submission Confirmation--%>
        <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Submit Answers</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to submit?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <br />
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click" />
                            <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <%--Modal for Deletion Confirmation--%>
        <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Answer</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                            <br />
                            <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClick="cfmDelete_Click"/>
                            <asp:Button ID="cfmCancel" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
