using System;
using System.Data;
using System.Data.SqlClient;

namespace Railway.Models
{
    public class DB
    {
        public SqlConnection con { get; set; }

        public DB()
        {
            string conStr = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";
            con = new SqlConnection(conStr);
        }

        // Function to read data from a table
        public DataTable ReadTable(string tableName)
        {
            DataTable dt = new DataTable();
            string q = $"SELECT * FROM {tableName};";

            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    dt.Load(cmd.ExecuteReader());
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions, log, or throw as needed
                Console.WriteLine(ex.Message);
            }
            finally
            {
                con.Close();
            }

            return dt;
        }
    }



}