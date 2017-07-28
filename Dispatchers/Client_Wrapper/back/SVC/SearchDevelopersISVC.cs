using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Fwk.Bases;
namespace Health.ISVC
{
    public class SearchDevelopersREQ : Fwk.Bases.Request<ParametrosDelReq>
    {
        public SearchDevelopersREQ()
        {
            this.ServiceName = "SearchDevelopersSVC";
        }
    }

    public class ParametrosDelReq: Entity{

        public DateTime FechaDesde {get;set;}
   
    }
    public class SearchDevelopersRES : Response<DevBEList>
    {
        
    }

    public class DevBEList : Entities<DevBE>
    { }

    public class DevBE : Entity
    {
        public string Nombre { get; set; }
        public int Id { get; set; }
    }



   // Mercurio.SA.Back
    // Mercurio.SA.Back.Common
    // Mercurio.SA.Back.SVC.Cliente
    // Mercurio.SA.Back.ISVC.Cliente
                    //CrearClienteISVC.cs
                        //-- CrearClienteREQ
                        // --  CrearClienteRES
    // Mercurio.SA.Back.BE.Cliente

    // Mercurio.SA.Back.SVC.ContratosComerciales
    // Mercurio.SA.Back.SVC.Avisos

    // Mercurio.SA.Common
    // Mercurio.SA.Front
}

