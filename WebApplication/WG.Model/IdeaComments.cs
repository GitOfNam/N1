using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WG.Repository
{
    public class IdeaComments
    {
        public string IID { get; set; }
        public string Comment { get; set; }
        public string Crt_User { get; set; }
        public string Crt_Name { get; set; }
        public DateTime Crt_Date { get; set; }
        public string Crt_Datefrm { get; set; }
    }
}
