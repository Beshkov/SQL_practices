using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;

namespace SQLExternalFunctions
{
    public static class SQLExternalFunctions
    {
        [Microsoft.SqlServer.Server.SqlFunction]
        public static int FirstCaracterOccurence(string str) 
        {
            if (string.IsNullOrWhiteSpace(str))
                return 0;
            
            char ch = str[0];
            return str.Where(f=>f == ch).Count();
        }

        public static int GetCharacterOccurence(string str, char chr)
        {
            if (string.IsNullOrWhiteSpace(str)) 
                return 0;

            return str.Where((f)=>f == chr).Count();
        }

        public static string GetCurrentDateISO()
        {
            return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }

    }
}
