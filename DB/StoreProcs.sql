USE [Testing]
GO
/****** Object:  StoredProcedure [dbo].[DeleteClient]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteClient]
	-- Add the parameters for the stored procedure here
	   @ClientID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Testing].[dbo].[Clients]
	SET IsActive = 0
	WHERE ClientID=@ClientID

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteClientContactDetails]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteClientContactDetails]
	-- Add the parameters for the stored procedure here
	   @ClientContactID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Testing].[dbo].[ClientContactDetails]
	SET IsActive = 0
	WHERE [ClientContactID]=@ClientContactID

END
GO
/****** Object:  StoredProcedure [dbo].[GetAllClients]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllClients]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  [ClientID]
      ,[FirstName]
      ,[LastName]
      ,g.[Name]
  FROM [Testing].[dbo].[Clients](nolock) c 
  INNER JOIN [dbo].[Gender] g on c.[FK_GenderID]=g.[GenderID]
  WHERE c.IsActive = 1

END
GO
/****** Object:  StoredProcedure [dbo].[GetClientByClientID]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetClientByClientID]
	-- Add the parameters for the stored procedure here
	   @ClientID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  [ClientID]
      ,[FirstName]
      ,[LastName]
      ,g.[Name]
  FROM [Testing].[dbo].[Clients](nolock) c
  INNER JOIN [dbo].[Gender] g on c.[FK_GenderID]=g.[GenderID]
  WHERE  [ClientID] = @ClientID
  and c.IsActive =  1

END
GO
/****** Object:  StoredProcedure [dbo].[GetClientContactDetailsByClientID]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetClientContactDetailsByClientID]
	-- Add the parameters for the stored procedure here
	   @ClientID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [ClientContactID]
      ,ContactType
      ,[ContactInformation]
      ,[FK_ClientID]
	  ,c.FirstName
	  ,c.LastName
	  ,ccd.FK_ContactTypeID
  FROM [Testing].[dbo].[ClientContactDetails](nolock) ccd
  INNER JOIN [dbo].[Clients] C on c.[ClientID]=ccd.[FK_ClientID]
  INNER JOIN [dbo].ContactType ct on ct.[ContactTypeID]=ccd.[FK_ContactTypeID]
  WHERE  [ClientID] = @ClientID
  AND ccd.IsActive = 1

END
GO
/****** Object:  StoredProcedure [dbo].[GetContactType]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetContactType]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ContactTypeID]
      ,[ContactType]
  FROM [Testing].[dbo].[ContactType]
END
GO
/****** Object:  StoredProcedure [dbo].[GetGender]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGender]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  [GenderID]
       ,[Name]
  FROM [Testing].[dbo].[Gender](nolock) 

END
GO
/****** Object:  StoredProcedure [dbo].[GetGetAllPersonsPagination]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGetAllPersonsPagination]
	-- Add the parameters for the stored procedure here

	 @idnumber varchar(50) = null,
	 @surname varchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @TotalRows int 
	select @TotalRows = COUNT(P.[code]) 
	FROM  [Testing].[dbo].[Persons] P WITH(NOLOCK)
	WHERE (P.[surname] LIKE '%'+ @surname +'%' OR @surname IS NULL)
	AND (P.[id_number] = @idnumber OR @idnumber IS NULL)
select ceiling(@TotalRows /cast(10 as decimal(10,5))) as TotalPage

END
GO
/****** Object:  StoredProcedure [dbo].[InsertClient]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertClient]
	-- Add the parameters for the stored procedure here
       @FirstName varchar(50)
      ,@LastName varchar(50)
      ,@FK_GenderID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Testing].[dbo].[Clients](FirstName,LastName,FK_GenderID)
	--OUTPUT INSERTED.ClientID
	VALUES(@FirstName,@LastName,@FK_GenderID)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertClientContactDetails]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertClientContactDetails]
	-- Add the parameters for the stored procedure here
       @FK_ContactTypeID INT
      ,@ContactInformation varchar(50)
      ,@FK_ClientID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Testing].[dbo].[ClientContactDetails]([FK_ContactTypeID],[ContactInformation],[FK_ClientID])
	VALUES(@FK_ContactTypeID,@ContactInformation,@FK_ClientID)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateClient]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateClient]
	-- Add the parameters for the stored procedure here
	   @ClientID INT OUTPUT
      ,@FirstName varchar(50)
      ,@LastName varchar(50)
      ,@FK_GenderID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Testing].[dbo].[Clients]
	SET FirstName=@FirstName,
	LastName=@LastName,
	FK_GenderID=@FK_GenderID
	WHERE ClientID=@ClientID

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateClientContactDetails]    Script Date: 2021/08/07 17:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateClientContactDetails]
	-- Add the parameters for the stored procedure here
	   @ClientContactID INT
	   ,@FK_ClientID INT 
       ,@FK_ContactTypeID INT
       ,@ContactInformation varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Testing].[dbo].[ClientContactDetails]
	SET [FK_ContactTypeID] = @FK_ContactTypeID,
	[ContactInformation] = @ContactInformation
	WHERE FK_ClientID = @FK_ClientID
	AND ClientContactID = @ClientContactID

END
GO
