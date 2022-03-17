using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WG.Repository
{
    public class Ideas
    {
        public string IID { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string Crt_User { get; set; }
        public DateTime Crt_Date { get; set; }
        public bool IsActive { get; set; } = false;
        public bool IsOnline { get; set; } = false;
        public int View_numb { get; set; }
        public DateTime Date_Online { get; set; }
        public string Date_Onlinefrm { get; set; }
        public DateTime StartDate { get; set; }
        public string StartDatefrm { get; set; }
        public DateTime EndDate { get; set; }
        public string EndDatefrm { get; set; }
        public int LikeNumb { get; set; }
        public int DisLikeNumb { get; set; }
        public string FileName { get; set; }
        public string FilePath { get; set; }
        public bool isOption { get; set; } = false;
        public string msg { get; set; }
        public string TagName { get; set; }
        public string Tag { get; set; }
        public string UserLike { get; set; }
        public string UserDisLike { get; set; }
        public string CrtName { get; set; }

    }
}
