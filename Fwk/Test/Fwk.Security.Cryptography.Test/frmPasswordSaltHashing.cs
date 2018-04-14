using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Windows.Forms;

namespace Fwk.Security.Cryptography.Test
{
    public partial class frmPasswordSaltHashing : Form
    {
       
        public frmPasswordSaltHashing()
        {
            InitializeComponent();

        }

        public static void GenerateSaltedHas(string password, out string hash, out string salt)
        {
            var salt_byte = new byte[64];
            var provider = new RNGCryptoServiceProvider();
             provider.GetNonZeroBytes(salt_byte);
             salt = Convert.ToBase64String(salt_byte);
             var rfc2898DerivedBytes = new Rfc2898DeriveBytes(password, salt_byte,10000);
             hash = Convert.ToBase64String(rfc2898DerivedBytes.GetBytes(256));
        }

        public static bool Verify(string password, string storedHash, string storedSalt)
        {
            var salt_bytes = Convert.FromBase64String(storedSalt);
            var rfc2898DerivedBytes = new Rfc2898DeriveBytes(password, salt_bytes, 10000);
            
            var hash = Convert.ToBase64String(rfc2898DerivedBytes.GetBytes(256));


            return hash == storedHash;
        }


        

        private void btnGenHashedPassword_Click(object sender, EventArgs e)
        {
            string hash, salt = ""; 

           GenerateSaltedHas(txtPassword.Text, out hash, out salt);
           txtPasswordHased.Text = hash;
           txtGeneratedSalt.Text = salt;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (Verify(txtPassword.Text, txtPasswordHased.Text,txtGeneratedSalt.Text))
            {
                MessageBox.Show("Password is valid");
            }
            else
            { MessageBox.Show("Password is NOT valid"); }
        }
        static string str_salt = "";
        private void frmPasswordSaltHashing_Load(object sender, EventArgs e)
        {
             str_salt = txtGeneratedSalt.Text;
        }
       
        

        
    }
    
}
