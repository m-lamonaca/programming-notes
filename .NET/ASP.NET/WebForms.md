# WebForms

## `Page.aspx`

The fist loaded page is `Default.aspx` and its undelying code.

```html
<!-- directive -->
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Project.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">  <!-- XML Namespace -->
<head runat="server">  <!-- runat: handle as ASP code -->
    <title></title>
</head>
<body>
    <!-- web forms require a form tag to be the whole body -->
    <form id="form1" runat="server">  <!-- runat: handle as ASP code -->
        <div>
        </div>
    </form>
</body>
</html>
```

### Page Directive

```cs
<%@ Page Language="C#"  // define language used (can be C# or VB)
    AutoEventWireup="true"  // automatically create and setup event handlers
    CodeBehind="Default.aspx.cs"  // define the underlying code file
    Inherits="EmptyWebForm.Default" %>
```

### Web Controls

```xml
<asp:Control ID="" runat="server" ...></asp:Control>

<!-- Label: empty text will diplay ID, use empty space as text for empty label -->
<asp:Label ID="lbl_" runat="server" Text=" "></asp:Label>
<!-- TextBox -->
<asp:TextBox ID="txt_" runat="server"></asp:TextBox>
<!-- Button -->
<asp:Button ID="btn_" runat="server" Text="ButtonText" OnClick="btn_Click" />
<!-- HyperLink -->
<asp:HyperLink ID="lnk_" runat="server" NavigateUrl="~/Page.aspx">LINK TEXT</asp:HyperLink>
<!-- LinkButton: POstBackEvent reloads the page -->
<asp:LinkButton ID="lbtHome" runat="server" PostBackUrl="~/Page.aspx" OnClick="lbt_Click">BUTTON TEXT</asp:LinkButton>
<!-- Image -->
<asp:Image ID="img_" runat="server" ImageUrl="~/Images/image.png"/>
<!-- ImageButton -->
<asp:ImageButton ID="imb_" runat="server" ImageUrl="~/Images/image.png" PostBackUrl="~/Page.aspx"/>

<!-- SqlSataSource; connection string specified in Web.config -->
<asp:SqlDataSource ID="sds_" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SQL Query"></asp:SqlDataSource>
```

## `Page.aspx.cs`

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Control_Event(object sender, EventAtgs e)
        {
            // actions on event trigger
        }
    }
}
```
