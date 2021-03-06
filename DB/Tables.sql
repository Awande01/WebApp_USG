USE [Testing]
GO
/****** Object:  Table [dbo].[ClientContactDetails]    Script Date: 2021/08/07 17:15:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientContactDetails](
	[ClientContactID] [int] IDENTITY(1,1) NOT NULL,
	[FK_ContactTypeID] [int] NOT NULL,
	[ContactInformation] [varchar](100) NOT NULL,
	[FK_ClientID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ClientContactDetails] PRIMARY KEY CLUSTERED 
(
	[ClientContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 2021/08/07 17:15:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[FK_GenderID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 2021/08/07 17:15:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactType](
	[ContactTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ContactType] [varchar](50) NULL,
 CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED 
(
	[ContactTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 2021/08/07 17:15:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ContactType] ON 
INSERT [dbo].[ContactType] ([ContactTypeID], [ContactType]) VALUES (1, N'Residential Address')
INSERT [dbo].[ContactType] ([ContactTypeID], [ContactType]) VALUES (2, N'Work Address')
INSERT [dbo].[ContactType] ([ContactTypeID], [ContactType]) VALUES (3, N'Postal Address')
INSERT [dbo].[ContactType] ([ContactTypeID], [ContactType]) VALUES (4, N'Cell Number')
INSERT [dbo].[ContactType] ([ContactTypeID], [ContactType]) VALUES (5, N'Work Number')
SET IDENTITY_INSERT [dbo].[ContactType] OFF
SET IDENTITY_INSERT [dbo].[Gender] ON 

INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (1, N'Female')
INSERT [dbo].[Gender] ([GenderID], [Name]) VALUES (2, N'Male')
SET IDENTITY_INSERT [dbo].[Gender] OFF
ALTER TABLE [dbo].[ClientContactDetails] ADD  CONSTRAINT [DF_ClientContactDetails_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [DF_Clients_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ClientContactDetails]  WITH CHECK ADD  CONSTRAINT [FK_ClientContactDetails_Clients] FOREIGN KEY([FK_ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[ClientContactDetails] CHECK CONSTRAINT [FK_ClientContactDetails_Clients]
GO
ALTER TABLE [dbo].[ClientContactDetails]  WITH CHECK ADD  CONSTRAINT [FK_ClientContactDetails_ContactType] FOREIGN KEY([FK_ContactTypeID])
REFERENCES [dbo].[ContactType] ([ContactTypeID])
GO
ALTER TABLE [dbo].[ClientContactDetails] CHECK CONSTRAINT [FK_ClientContactDetails_ContactType]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [FK_Clients_Gender] FOREIGN KEY([FK_GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [FK_Clients_Gender]
GO
