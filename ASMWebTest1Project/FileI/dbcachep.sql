USE [ASMWebTest1]
GO
/****** Object:  Table [dbo].[Ideas]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ideas](
	[ideaID] [int] IDENTITY(1,1) NOT NULL,
	[ideaTitle] [nvarchar](255) NOT NULL,
	[creatAt] [datetime] NOT NULL,
	[fileI] [varbinary](max) NULL,
	[urlFile] [varchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[categoryID] [int] NULL,
	[likes] [int] NOT NULL,
	[dislikes] [int] NOT NULL,
	[Iname] [nchar](255) NULL,
	[incognito] [nvarchar](50) NULL,
	[CountViews] [int] NOT NULL,
 CONSTRAINT [PK__Ideas__C34BE8A1FEB8CA9B] PRIMARY KEY CLUSTERED 
(
	[ideaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[departmentID] [int] IDENTITY(1,1) NOT NULL,
	[departmenName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[departmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[departmentID] [int] NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_a]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_a] AS
SELECT B.UserName, MAX(C.departmenName) as Department
FROM Ideas as A
	INNER JOIN [AspNetUsers] AS B
		ON A.Iname = B.UserName
    INNER JOIN [Departments] AS C
		ON B.departmentID = C.departmentID
	WHERE YEAR(A.creatAt) = '2022'
GROUP BY UserName
GO
/****** Object:  Table [dbo].[Interactive]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interactive](
	[interactiveID] [int] IDENTITY(1,1) NOT NULL,
	[createOn] [datetime] NULL,
	[comment] [nvarchar](max) NULL,
	[ideaID] [int] NULL,
	[Cname] [nvarchar](255) NULL,
	[incognito] [nvarchar](50) NULL,
 CONSTRAINT [PK__Interact__B5A4925AA9EF25FA] PRIMARY KEY CLUSTERED 
(
	[interactiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_b]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_b] as 
select A.ideaID, MAX(A.ideaTitle) as Title, MAX(A.likes) as TotalLikes, COUNT(B.interactiveID) as TotalComments
from Ideas AS A
Inner Join Interactive AS B
	on A.ideaID = B.ideaID
GROUP BY A.ideaID
GO
/****** Object:  View [dbo].[view_c]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[view_c] as
select ideaID, Title, TotalLikes, TotalComments, (TotalLikes + TotalComments) as TotalInteract
from view_b
GO
/****** Object:  View [dbo].[view_d]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_d] as
select * from view_c
where TotalInteract=(select max(TotalInteract) from view_c)
GO
/****** Object:  View [dbo].[view_e]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_e] as
select * from Ideas
where CountViews=(select max(CountViews) from Ideas)
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[categoryID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [varchar](255) NOT NULL,
	[closureDate] [datetime] NOT NULL,
	[finalDate] [datetime] NOT NULL,
	[Cstatus] [varchar](255) NULL,
 CONSTRAINT [PK__Categori__23CAF1F8D529CB99] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Information]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Information](
	[informationID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[DOB] [date] NOT NULL,
	[Irole] [nvarchar](255) NOT NULL,
	[phoneNumber] [int] NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[address] [nvarchar](255) NULL,
	[departmentID] [int] NULL,
 CONSTRAINT [PK__Informat__E86E97751CFD0CC1] PRIMARY KEY CLUSTERED 
(
	[informationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LikeDislike]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikeDislike](
	[likeDislikeID] [int] IDENTITY(1,1) NOT NULL,
	[IsAction] [nvarchar](50) NULL,
	[UserAction] [nvarchar](50) NULL,
	[ideaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[likeDislikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Replies]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Replies](
	[repliesID] [int] IDENTITY(1,1) NOT NULL,
	[createOn] [datetime] NULL,
	[comment] [nvarchar](255) NULL,
	[Rname] [nvarchar](255) NULL,
	[interactiveID] [int] NULL,
	[ideaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[repliesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [DF__Categorie__Cstat__7849DB76]  DEFAULT ('true') FOR [Cstatus]
GO
ALTER TABLE [dbo].[Ideas] ADD  CONSTRAINT [DF__Ideas__creatAt__5629CD9C]  DEFAULT (getdate()) FOR [creatAt]
GO
ALTER TABLE [dbo].[Ideas] ADD  CONSTRAINT [DF_Ideas_likes]  DEFAULT ((0)) FOR [likes]
GO
ALTER TABLE [dbo].[Ideas] ADD  CONSTRAINT [DF_Ideas_dislikes]  DEFAULT ((0)) FOR [dislikes]
GO
ALTER TABLE [dbo].[Ideas] ADD  DEFAULT ((0)) FOR [CountViews]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD FOREIGN KEY([departmentID])
REFERENCES [dbo].[Departments] ([departmentID])
GO
ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD FOREIGN KEY([departmentID])
REFERENCES [dbo].[Departments] ([departmentID])
GO
ALTER TABLE [dbo].[Ideas]  WITH CHECK ADD  CONSTRAINT [FK__Ideas__categoryI__282DF8C2] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Categories] ([categoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ideas] CHECK CONSTRAINT [FK__Ideas__categoryI__282DF8C2]
GO
ALTER TABLE [dbo].[Information]  WITH CHECK ADD FOREIGN KEY([departmentID])
REFERENCES [dbo].[Departments] ([departmentID])
GO
ALTER TABLE [dbo].[Interactive]  WITH CHECK ADD  CONSTRAINT [FK__Interacti__ideaI__5BE2A6F2] FOREIGN KEY([ideaID])
REFERENCES [dbo].[Ideas] ([ideaID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Interactive] CHECK CONSTRAINT [FK__Interacti__ideaI__5BE2A6F2]
GO
ALTER TABLE [dbo].[LikeDislike]  WITH CHECK ADD  CONSTRAINT [FK__LikeDisli__ideaI__5224328E] FOREIGN KEY([ideaID])
REFERENCES [dbo].[Ideas] ([ideaID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LikeDislike] CHECK CONSTRAINT [FK__LikeDisli__ideaI__5224328E]
GO
/****** Object:  StoredProcedure [dbo].[P_TotalContributors]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_TotalContributors]
AS
BEGIN
select count(UserName) as TotalContributors, Department
from view_a
group by Department
END
GO
/****** Object:  StoredProcedure [dbo].[P_TotalIdeas]    Script Date: 03/04/2022 9:49:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_TotalIdeas]
	@Year int
AS
BEGIN
SELECT COUNT(A.ideaID) as TotalIdeas, C.departmenName 
FROM Ideas as A
	INNER JOIN [AspNetUsers] AS B
		ON A.Iname = B.UserName
    INNER JOIN [Departments] AS C
		ON B.departmentID = C.departmentID
	WHERE YEAR(A.creatAt) = @Year
GROUP BY departmenName
END
GO
