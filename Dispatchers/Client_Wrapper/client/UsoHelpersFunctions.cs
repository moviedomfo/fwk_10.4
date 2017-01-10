using Fwk.HelperFunctions;
using Health.ISVC;
using Health.SVC;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Security.Cryptography;
namespace Client
{
    public partial class UsoHelpersFunctions : Form
    {
        internal static Fwk.Caching.FwkSimpleStorageBase<settings> store = null;
        
        public UsoHelpersFunctions()
        {
            InitializeComponent();
           
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var fecha1 = new DateTime(1999,4,23);
            txtResult.Text = Fwk.HelperFunctions.DateFunctions.Get_Year_Mont_Day_Hour_Min_Sec_String(fecha1,'-');
            txtResult.Text = Fwk.HelperFunctions.DateFunctions.Get_Year_Mont_Day_String(fecha1, '-') + "_Auditorias.txt";
            
            AuditoriaBE audit = new AuditoriaBE();
            audit.AuditDate = fecha1;


        }

        private void button2_Click(object sender, EventArgs e)
        {
            AuditoriaBEList lista = new AuditoriaBEList();
            AuditoriaBE be = new AuditoriaBE();

            be.AuditDate = DateFunctions.GetEndDateTime( System.DateTime.Now);
            be.Message ="Error en algun svc";
            be.SysId = 3000;
            lista.Add(be);

            be = new AuditoriaBE();

            be.AuditDate = System.DateTime.Now;
            be.Message = "Error en OTRO svc";
            be.SysId = 5434;
            lista.Add(be);
            var fileName = Fwk.HelperFunctions.DateFunctions.Get_Year_Mont_Day_String(be.AuditDate, '-') + "Facturas.xml";
            Fwk.HelperFunctions.FileFunctions.SaveTextFile(fileName, lista.GetXml());

            var json_AuditoriaBEList = Fwk.HelperFunctions.SerializationFunctions.SerializeObjectToJson_JavaScriptSerializer(typeof(AuditoriaBEList), lista);
            //Helpers

            //Fwk.HelperFunctions.


            string txt = Fwk.HelperFunctions.FileFunctions.OpenTextFile("audits.txt");

            Fwk.HelperFunctions.FileFunctions.SaveTextFile("fileName","comntent");


            

            







            

            

        }

        private void button3_Click(object sender, EventArgs e)
        {
            
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string key = "7gp6CZ+Y8BZULbjOOkT86vi8HnrtyaIQ6WiLhdY48jY=$PbUiRifcU1q8Egl96hC7tw==";
            Fwk.Security.Cryptography.SymetriCypher<RijndaelManaged> encriptador = new Fwk.Security.Cryptography.SymetriCypher<RijndaelManaged>(key);

            string k = encriptador.Encrypt("Hola mundo");

           var errorMsg = Fwk.Configuration.ConfigurationManager.GetProperty("ExceptionMessages", "fecha_desde_igual_hasta_error");

           throw new Fwk.Exceptions.FunctionalException(errorMsg);
                                                       //string configProviderName, int? errorId, string keyExceptionName, string groupExceptionName, params string[] pparams

           string[] str = new string[] { "Feercha1", "Feercha2" };
            throw new Fwk.Exceptions.FunctionalException("", 8587, "fecha_desde_igual_hasta_error", "ExceptionMessages", str);

        }



    }
   
    public class AuditoriaBEList : Fwk.Bases.Entities<AuditoriaBE>
    {
 
    }

    public class AuditoriaBE :Fwk.Bases.Entity
    {
        public String Message { get; set; }
        public DateTime AuditDate { get; set; }
        public Int32 SysId { get; set; }

    }
}

