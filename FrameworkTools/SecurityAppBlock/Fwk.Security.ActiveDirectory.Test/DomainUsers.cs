using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Fwk.Security.Common;

namespace Fwk.Security.ActiveDirectory.Test
{
    public delegate void ObjectDomainChangeHandler(ADUser user);
    public delegate void ObjectDomainDoubleClickHandler(ADUser user);
    
    [DefaultEvent("ObjectDomainChangeEvent")]
    public partial class DomainUsers : UserControl
    {

        ADWrapper _ADWrapper;
        public event ObjectDomainChangeHandler ObjectDomainChangeEvent;
        public event ObjectDomainDoubleClickHandler ObjectDomainDoubleClickEvent;
        void OnObjectDomainChange()
        {
            if (ObjectDomainChangeEvent != null)
                ObjectDomainChangeEvent(_CurrentUserName);
        }
        void OnObjectDomainDoubleClick()
        {
            if (ObjectDomainDoubleClickEvent != null)
                ObjectDomainDoubleClickEvent(_CurrentUserName);
        }
        List<ADUser> _DomainUsers;
        ADUser _CurrentUserName;
       
        

        public DomainUsers()
        {
            InitializeComponent();
           
        }


        
        public void Populate()
        {
            if (StaticAD.ADWrapper == null)
            {
                throw new Exception("El dominio no fue inicializado. ");
            }

            _DomainUsers = StaticAD.ADWrapper.Users_SearchByGroupName("");

           aDUserBindingSource.DataSource = _DomainUsers;
        }
        public void Populate(string groupName)
        {
            if (StaticAD.ADWrapper == null)
            {
                throw new Exception("El dominio no fue inicializado. ");
            }

            _DomainUsers = StaticAD.ADWrapper.Users_SearchByGroupName(groupName); ;
            txDomainUserName.Text = groupName;
            aDUserBindingSource.DataSource = _DomainUsers;
        }

        private void txDomainUserName_KeyDown(object sender, KeyEventArgs e)
        {
                if (e.KeyCode == Keys.Enter)
                {
                    using (new WaitCursorHelper(this))
                    {
                        aDUserBindingSource.DataSource = ADUser.FilterByName(txDomainUserName.Text, _DomainUsers);
                    }
                }
        }

        private void btnFilterUsers_Click(object sender, EventArgs e)
        {
            using (new WaitCursorHelper(this))
            {

                aDUserBindingSource.DataSource  = StaticAD.ADWrapper.Users_SearchByGroupName(txDomainUserName.Text);
              //= ADUser.FilterByName(, _DomainUsers);
            }
            
        }





        private void grdDomainUsers_Click(object sender, EventArgs e)
        {
            if (ObjectDomainChangeEvent == null) return;

            if (grdDomainUsers.CurrentRow == null) return;
            if (grdDomainUsers.CurrentRow.DataBoundItem == null) return;

            _CurrentUserName = (ADUser)grdDomainUsers.CurrentRow.DataBoundItem;
            OnObjectDomainChange();
        }

        private void grdDomainUsers_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (ObjectDomainChangeEvent == null) return;

            if (grdDomainUsers.CurrentRow == null) return;
            if (grdDomainUsers.CurrentRow.DataBoundItem == null) return;

            _CurrentUserName = (ADUser)grdDomainUsers.CurrentRow.DataBoundItem;
            OnObjectDomainDoubleClick();
        }

        private void txDomainUserName_TextChanged(object sender, EventArgs e)
        {

        }

      


    }
}
