<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>CPU Hog</title>
</head>
<body>
    <h1>CPU Burner Control</h1>

    <form runat="server">
        <asp:Button ID="btnStart" runat="server" Text="Start CPU Burner" OnClick="btnStart_Click" />
        <asp:Button ID="btnStop" runat="server" Text="Stop CPU Burner" OnClick="btnStop_Click" />
        <br /><br />
        <asp:Label ID="lblStatus" runat="server" Text="Status: Idle" />
    </form>

    <script runat="server">
        private static System.Threading.Thread cpuThread;
        private static bool cancel = false;

        protected void btnStart_Click(object sender, EventArgs e)
        {
            if (cpuThread == null || !cpuThread.IsAlive)
            {
                cancel = false;
                cpuThread = new System.Threading.Thread(new System.Threading.ThreadStart(CpuBurner));
                cpuThread.IsBackground = true;
                cpuThread.Start();
                lblStatus.Text = "Status: Running";
            }
            else
            {
                lblStatus.Text = "Status: Already running";
            }
        }

        protected void btnStop_Click(object sender, EventArgs e)
        {
            cancel = true;
            lblStatus.Text = "Status: Stopping...";
        }

        private void CpuBurner()
        {
            double result = 0;
            while (!cancel)
            {
                for (int i = 0; i < 1000000 && !cancel; i++)
                {
                    result += System.Math.Sqrt(i) * System.Math.Sin(i);
                }
            }
        }
    </script>
</body>
</html>