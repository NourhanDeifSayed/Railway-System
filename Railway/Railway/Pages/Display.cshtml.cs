using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class DisplayModel : PageModel
    {
        public EMPInfo empInfo { get; set; } = new EMPInfo();

        public void OnGet()
        {
            string id = Request.Query["StaffID"];
            Console.WriteLine($"Received ID: {id}"); // Output the received ID for debugging purposes

            string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT StaffID, StaffName, StaffAddress, StaffPhone, StaffRole FROM Staff WHERE StaffID = @id"; // Change 'id' to 'StaffID' in the query
                Console.WriteLine($"SQL Query: {query}, ID: {id}"); // Output the SQL query and ID for debugging purposes

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", id); // Ensure the parameter is added as '@id'

                try
                {
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        empInfo.StaffID = (int)reader["StaffID"];
                        empInfo.StaffName = reader.GetString(1);
                        empInfo.StaffAddress = reader.GetString(2);
                        empInfo.StaffPhone = reader.GetString(3);
                        empInfo.StaffRole = reader.GetString(4);
                    }
                    else
                    {
                        // Handle case where the record with the provided ID is not found
                        Console.WriteLine("No data found for the provided ID.");
                    }
                }
                catch (Exception ex)
                {
                    // Log or handle exceptions
                    Console.WriteLine(ex.Message);
                }
            }
        }

    }


}
