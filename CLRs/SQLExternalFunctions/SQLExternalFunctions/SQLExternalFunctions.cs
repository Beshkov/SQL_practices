using System;
using System.Collections;
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

        public static string FastSeprator(string str, string imp1, string imp2, char spr)
        {
            
            
           string[] arr1 = imp1.Split(spr);
           string[] arr2 = imp2.Split(spr);

            if (arr1.Length == arr2.Length)
            {

                int max_len = arr1.Length;



                for (int i = 0; i < max_len; i++)
                {
                    str = str.Replace(arr1[i], arr2[i]);                    
                }
                return str;
            }
            else
            {
                return str;
            }
        }
    }
}
