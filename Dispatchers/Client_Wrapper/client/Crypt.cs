using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Client
{
    public partial class Crypt : Form
    {
        Fwk.Caching.FwkSimpleStorageBase<settings> store = null;
        Fwk.Security.Cryptography.SymetriCypher<System.Security.Cryptography.RijndaelManaged> cypt = null;
        public Crypt()
        {
            InitializeComponent();
            store = new Fwk.Caching.FwkSimpleStorageBase<settings>();
            var semilla_k = "2XAa+2srjXVKY++8QntdkzHK7GvvpW4K/IKCkyJ22ac=$2R77t49f0DAw1EzaXY6bHg==";
            cypt = new Fwk.Security.Cryptography.SymetriCypher<System.Security.Cryptography.RijndaelManaged>(semilla_k);

            cypt.GeneratetNewK();

        }

        private void txtNombre_TextChanged(object sender, EventArgs e)
        {
            store.StorageObject.Username = txtNombre.Text;
            store.Save();

            textBox1.Text = cypt.Encrypt(store.StorageObject.Username);
        }

        private void Crypt_Leave(object sender, EventArgs e)
        {
            store.Save();
        }

        private void Crypt_Load(object sender, EventArgs e)
        {
            store.Load();

            txtNombre.Text = store.StorageObject.Username;
        }

        private void btnGenK_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(cypt.GeneratetNewK());
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
