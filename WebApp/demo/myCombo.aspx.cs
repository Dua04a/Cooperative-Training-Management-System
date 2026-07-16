using maiyas10920WebApp.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp.demo
{
    public partial class myCombo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            populateDdlCountry();

        }

        protected void populateDdlCountry()
        {
            App_Code.CRUD myCrud = new CRUD();
            string mySql = @"select countryId, country from country";
            System.Data.SqlClient.SqlDataReader dr =  myCrud.getDrPassSql(mySql);
            ddlCountry.DataTextField = "country";
            ddlCountry.DataValueField = "countryId";
            ddlCountry.DataSource = dr;
            ddlCountry.DataBind();
        }
    }
}