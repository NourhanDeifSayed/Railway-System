using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data.SqlClient;
namespace Railway.Pages
{
    public class AddStuffModel : PageModel
    {
        public EMPInfo empInfo { get; set; }
        public string Message { get; set; }

        public AddStuffModel()
        {
            empInfo = new EMPInfo();
            Message = "Error Occurred";
        }
        public void OnGet()
        {
             
        }
        public IActionResult OnPost()
        {
            empInfo.StaffName = Request.Form["name"];
            empInfo.StaffAddress = Request.Form["address"];
            empInfo.StaffPhone = Request.Form["phone"];
            empInfo.StaffRole = Request.Form["role"];

            //if (!int.TryParse(Request.Form["id"], out int idValue))
            //{
            //    Message = "Invalid ID format";
            //    return Page();
            //}

            //empInfo.StaffID = idValue;

            try
            {
                string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string sql = "INSERT INTO Staff (StaffName, StaffAddress, StaffPhone, StaffRole) VALUES ( @name, @address, @phone, @role);";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        //command.Parameters.AddWithValue("@id", empInfo.StaffID);
                        command.Parameters.AddWithValue("@name", empInfo.StaffName);
                        command.Parameters.AddWithValue("@address", empInfo.StaffAddress);
                        command.Parameters.AddWithValue("@phone", empInfo.StaffPhone);
                        command.Parameters.AddWithValue("@role", empInfo.StaffRole);

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Message = ex.Message;
                return Page();
            }

            return RedirectToPage("/stuff_information"); // Redirect to Clients page after successful submission
        }
    }
}
