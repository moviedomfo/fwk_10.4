using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Health.BE
{
    public class AndreaBE :Fwk.Bases.Entity
    {
        public string param1 { get; set; }
        public string param2 { get; set; }
      
    }
    public class Andrea2BE : AndreaBE
    {
      
        public Int32 param3 { get; set; }
    }
}
