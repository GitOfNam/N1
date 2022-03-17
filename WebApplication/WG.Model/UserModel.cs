using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Model
{
    public class UserModel
    {
        public string UserCode { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string NumberPhone { get; set; }
        public DateTime Crt_Date { get; set; }
        public string KeyEnCrypt { get; set; }
        public bool isAdmin { get; set; } = false;
        public bool isQA { get; set; } = false;
        public bool isStaffIT { get; set; } = false;
        public bool isStaffBusiness { get; set; } = false;
        public bool isStaffComputerScience { get; set; } = false;
        public string msg { get; set; }
        public string Tag { get; set; }
        public string Position { get; set; }
    }
}
