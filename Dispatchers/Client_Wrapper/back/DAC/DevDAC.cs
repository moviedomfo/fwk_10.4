using Health.ISVC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Health.DAC
{
   internal class DevDAC
    {
       public static List<DevBE> SearchAll()
       {
           List<DevBE> list = new List<DevBE>();
           list.Add(new DevBE { Nombre = "pepe", Id = 123 });
           list.Add(new DevBE { Nombre = "jose", Id = 34 });
           return list;
       }

       internal static List<DevBE> Search(DateTime dateTime)
       {
           List<DevBE> list = new List<DevBE>();
           list.Add(new DevBE { Nombre = "pepe", Id = 123 });
           list.Add(new DevBE { Nombre = "jose", Id = 34 });
           return list;
       }

       internal static List<DevBE> Search(DateTime dateTime, string cnnStringName)
       {
           List<DevBE> list = new List<DevBE>();
           list.Add(new DevBE { Nombre = "pepe", Id = 123 });
           list.Add(new DevBE { Nombre = "jose", Id = 34 });
           return list;
       }
    }
}
