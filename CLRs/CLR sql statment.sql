use Test_DB;
go

EXEC sp_configure 'show advanced options' , 1;
RECONFIGURE;
go

EXEC sp_configure 'clr enable' ,1;
RECONFIGURE;
go

EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;
GO

alter ASSEMBLY SQLCLRDemo
FROM 'D:\tsql quries\Some SQL code practice\SQL_practices\CLRs\SQLExternalFunctions\SQLExternalFunctions\bin\Debug\SQLExternalFunctions.dll';
GO
/*
CREATE FUNCTION GetFirstCharacterOccurence(<input parameters>) RETURNS <output data type>
    EXTERNAL NAME <clr assembly>.<class name>.<Function name>;
GO
*/

CREATE FUNCTION GetFirstCharacterOccurence(@str nvarchar(255)) RETURNS INT
EXTERNAL NAME SQLCLRDemo.[SQLExternalFunctions.SQLExternalFunctions].FirstCaracterOccurence;
GO
 
CREATE FUNCTION GetCharacterOccurence(@str nvarchar(255), @chr nchar(1)) RETURNS INT
EXTERNAL NAME SQLCLRDemo.[SQLExternalFunctions.SQLExternalFunctions].GetCharacterOccurence;
GO
 
CREATE FUNCTION GetIsoDate() RETURNS nvarchar(255)
EXTERNAL NAME SQLCLRDemo.[SQLExternalFunctions.SQLExternalFunctions].GetCurrentDateISO;
GO


CREATE or alter FUNCTION FastSeprator(@str nvarchar(max), @spr nvarchar(max), @val nvarchar(max), @del nchar(1)) RETURNS nvarchar(max)
EXTERNAL NAME SQLCLRDemo.[SQLExternalFunctions.SQLExternalFunctions].FastSeprator;
GO