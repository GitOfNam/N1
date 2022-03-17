using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WG.Repository
{
    public class IdeaViewModel
    {
        public Ideas ideas { get; set; }
        public List<IdeaComments> ideaComments { get; set; }
    }
}
