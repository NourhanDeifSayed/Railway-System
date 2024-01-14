using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class EditModel : PageModel
    {
        public EMPInfo empInfo = new EMPInfo();

        public void OnGet()
        {
            string id = Request.Query["StaffID"];

            try
            {
                string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string selectSql = "SELECT * FROM Staff WHERE StaffID = @id;";

                    using (SqlCommand selectCommand = new SqlCommand(selectSql, connection))
                    {
                        selectCommand.Parameters.AddWithValue("@id", id);

                        using (SqlDataReader reader = selectCommand.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                empInfo.StaffID = Convert.ToInt32(reader["StaffID"]);
                                empInfo.StaffName = reader.GetString(reader.GetOrdinal("StaffName"));
                                empInfo.StaffAddress = reader.GetString(reader.GetOrdinal("StaffAddress"));
                                empInfo.StaffPhone = reader.GetString(reader.GetOrdinal("StaffPhone"));
                                empInfo.StaffRole = reader.GetString(reader.GetOrdinal("StaffRole"));

 
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public IActionResult OnPost()
        {
            empInfo.StaffID = Convert.ToInt32(Request.Query["StaffID"]);
            empInfo.StaffName = Request.Form["name"];
            empInfo.StaffAddress = Request.Form["address"];
            empInfo.StaffPhone = Request.Form["phone"];
            empInfo.StaffRole = Request.Form["role"];

            try
            {
                string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string sql = "UPDATE Staff SET StaffName = @name, StaffAddress = @address, StaffPhone = @phone, StaffRole = @role WHERE StaffID = @id;";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@name", empInfo.StaffName);
                        command.Parameters.AddWithValue("@address", empInfo.StaffAddress);
                        command.Parameters.AddWithValue("@phone", empInfo.StaffPhone);
                        command.Parameters.AddWithValue("@role", empInfo.StaffRole);
                        command.Parameters.AddWithValue("@id", empInfo.StaffID);

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return RedirectToPage("/stuff_information");
        }
    }
}
