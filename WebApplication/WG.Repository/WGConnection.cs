using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WG.Repository.Interfaces;

namespace WG.Repository
{
    public class WGConnection : IWGConnection
    {
        private readonly string _connectionString;
        public WGConnection(string ConncetionString)
        {
            _connectionString = ConncetionString;
        } 
        public SqlConnection GetConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}
