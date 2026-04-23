<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddTestimonial.aspx.cs" Inherits="AddTestimonial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="container mt-5">
        <h2>Pending Testimonials</h2>
        <asp:GridView ID="gvTestimonials" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
            OnRowCommand="gvTestimonials_RowCommand" DataKeyNames="TestimonialID">
            <Columns>
                <asp:BoundField HeaderText="ID" DataField="TestimonialID" ReadOnly="True" />
                <asp:BoundField HeaderText="Name" DataField="Name" />
                <asp:BoundField HeaderText="Comment" DataField="Comment" />
                <asp:BoundField HeaderText="Rating" DataField="Rating" />
                <asp:BoundField HeaderText="Created At" DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="Approve"
                            CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-success btn-sm" />
                        <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="Reject"
                            CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-danger btn-sm ms-2" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </section>

</asp:Content>
