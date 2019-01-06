using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CanteenManagement
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if(txbUserName.Text == "" || txbPassWord.Text == "")
            {
                MessageBox.Show("Đăng nhập thất bại !!!", "Thông báo");
            }
            else
            {
                MessageBox.Show("Đăng nhập thành công !!!", "Thông báo");
                CanteenManagement f = new CanteenManagement();
                this.Hide();
                f.ShowDialog();
                this.Show();
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Login_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(MessageBox.Show("Bạn có thật sự muốn thoát chương trình ?","Thông báo",MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void fLogin_Load(object sender, EventArgs e)
        {

        }
        private void fLogin_Load1(object sender, EventArgs e)
        {

        }
    }
}
