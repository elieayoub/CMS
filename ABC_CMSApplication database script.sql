USE [master]
GO
/****** Object:  Database [ABC_CMSApplication]    Script Date: 8/6/2014 3:24:27 PM ******/
CREATE DATABASE [ABC_CMSApplication]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ABC_CMSApplication', FILENAME = N'E:\Databases\ABC_CMSApplication\ABC_CMSApplication.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ABC_CMSApplication_log', FILENAME = N'E:\Databases\ABC_CMSApplication\ABC_CMSApplication_log.ldf' , SIZE = 7616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ABC_CMSApplication] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ABC_CMSApplication].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ABC_CMSApplication] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET ARITHABORT OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ABC_CMSApplication] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ABC_CMSApplication] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ABC_CMSApplication] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ABC_CMSApplication] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ABC_CMSApplication] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET RECOVERY FULL 
GO
ALTER DATABASE [ABC_CMSApplication] SET  MULTI_USER 
GO
ALTER DATABASE [ABC_CMSApplication] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ABC_CMSApplication] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ABC_CMSApplication] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ABC_CMSApplication] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ABC_CMSApplication', N'ON'
GO
USE [ABC_CMSApplication]
GO
/****** Object:  User [moudir]    Script Date: 8/6/2014 3:24:27 PM ******/
CREATE USER [moudir] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AppABCCMSApplication]    Script Date: 8/6/2014 3:24:27 PM ******/
CREATE USER [AppABCCMSApplication] FOR LOGIN [AppABCCMSApplication] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ABC\comvault]    Script Date: 8/6/2014 3:24:27 PM ******/
CREATE USER [ABC\comvault] FOR LOGIN [ABC\comvault] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [moudir]
GO
ALTER ROLE [db_owner] ADD MEMBER [AppABCCMSApplication]
GO
ALTER ROLE [db_owner] ADD MEMBER [ABC\comvault]
GO
/****** Object:  Schema [cms]    Script Date: 8/6/2014 3:24:27 PM ******/
CREATE SCHEMA [cms]
GO
/****** Object:  Table [cms].[ActionLogs]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[ActionLogs](
	[ActionLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[PagePermissionId] [bigint] NULL,
	[ActionLogControlId] [bigint] NULL,
	[ActionLogDate] [datetime] NULL,
	[ActionLogDateMMS] [numeric](6, 0) NULL,
	[UserActionId] [bigint] NULL,
 CONSTRAINT [PK_ActionLogs] PRIMARY KEY CLUSTERED 
(
	[ActionLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[Entities]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Entities](
	[EntityId] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[CreationDate] [datetime] NULL,
	[CreationDateMMS] [numeric](6, 0) NULL,
	[ModificationDate] [datetime] NULL,
	[ModificationDateMMS] [numeric](6, 0) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Entities] PRIMARY KEY CLUSTERED 
(
	[EntityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[ErrorLogs]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[ErrorLogs](
	[ErrorLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[ErrorLogDate] [datetime] NULL,
	[ErrorLogDateMMS] [numeric](6, 0) NULL,
	[Message] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[InnerException] [nvarchar](max) NULL,
	[Source] [nvarchar](250) NULL,
	[ErrorLogControlId] [bigint] NULL,
	[UserActionId] [bigint] NULL,
 CONSTRAINT [PK_ErrorLogs] PRIMARY KEY CLUSTERED 
(
	[ErrorLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [cms].[Menus]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Menus](
	[MenuId] [bigint] IDENTITY(1,1) NOT NULL,
	[MenuPermissionTypeId] [bigint] NULL,
	[MenuOrder] [int] NULL,
	[MenuParentId] [int] NULL,
	[MenuName] [nvarchar](50) NULL,
	[MenuDescription] [nvarchar](250) NULL,
	[MenuPath] [nvarchar](100) NULL,
	[MenuPageId] [bigint] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Menus] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[Pages]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Pages](
	[PageId] [bigint] IDENTITY(1,1) NOT NULL,
	[PageName] [nvarchar](50) NULL,
	[PageDescription] [nvarchar](250) NULL,
	[PagePermissionTypeId] [bigint] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[PagesPermissions]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[PagesPermissions](
	[PagePermissionId] [bigint] IDENTITY(1,1) NOT NULL,
	[PagePermissionName] [nvarchar](50) NULL,
	[PagePermissionDescription] [nvarchar](250) NULL,
	[PagePermissionPageId] [nvarchar](50) NULL,
	[PagePermissionTypeId] [bigint] NULL,
	[IsEnabled] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[PagePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[PermissionControlsTypes]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[PermissionControlsTypes](
	[PermissionControlsTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionControlTypeName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PermissionControlsTypes] PRIMARY KEY CLUSTERED 
(
	[PermissionControlsTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[PermissionsActions]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[PermissionsActions](
	[PermissionActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionActionPagePermissionId] [bigint] NULL,
	[PermissionActionPermissionControlId] [bigint] NULL,
	[PermissionActionRoleId] [bigint] NULL,
	[Create] [bit] NULL,
	[Read] [bit] NULL,
	[Update] [bit] NULL,
	[Delete] [bit] NULL,
 CONSTRAINT [PK_PermissionAction] PRIMARY KEY CLUSTERED 
(
	[PermissionActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[PermissionsControls]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[PermissionsControls](
	[PermissionControlId] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionControlName] [nvarchar](50) NULL,
	[PermissionControlTypeId] [bigint] NULL,
	[PermissionControlPageId] [bigint] NULL,
	[PermissionControlPagePermissionId] [bigint] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PermissionsControls] PRIMARY KEY CLUSTERED 
(
	[PermissionControlId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[PermissionsTypes]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[PermissionsTypes](
	[PermissionTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_PermissionsTypes] PRIMARY KEY CLUSTERED 
(
	[PermissionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[Roles]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Roles](
	[RoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[RoleDescription] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[RolesPermissions]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[RolesPermissions](
	[RolePermissionId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [bigint] NULL,
	[PagePermissionId] [bigint] NULL,
 CONSTRAINT [PK_RolesPermissions] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[Users]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Users](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[EntityId] [bigint] NULL,
	[IsActive] [bit] NULL,
	[ModificationDate] [datetime] NULL,
	[ModificationDateMMS] [numeric](6, 0) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[UsersActions]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[UsersActions](
	[UserActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserActionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UsersActions] PRIMARY KEY CLUSTERED 
(
	[UserActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cms].[UsersRoles]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[UsersRoles](
	[UserRoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [bigint] NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_UsersRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [cms].[v_GetActionLogsInformation]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [cms].[v_GetActionLogsInformation] AS
Select A.[ActionLogId],A.[UserId],A.[PagePermissionId],A.[ActionLogControlId],A.[ActionLogDate]
,A.[ActionLogDateMMS],A.[UserActionId], IsNull(U.Username, '') Username,
IsNull(P.PagePermissionName, '') PagePermissionName,
IsNull(C.PermissionControlName, '') PermissionControlName,
IsNull(UA.UserActionName, '') UserActionName,
IsNull(G.PageName, '') PageName,
G.PageId
From ActionLogs A 
Left Join Users U on U.UserId = A.UserId
Left Join PagesPermissions P on P.PagePermissionId = A.PagePermissionId
Left Join PermissionsControls C on C.PermissionControlId = A.ActionLogControlId
Left Join UsersActions UA on UA.UserActionId = A.UserActionId
Left Join Pages G On G.PageId = P.PagePermissionPageId

GO
/****** Object:  View [cms].[v_GetErrorLogsInformation]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



  
CREATE View [cms].[v_GetErrorLogsInformation] AS
Select E.[ErrorLogId],E.[ErrorLogDate],E.[ErrorLogDateMMS],E.[Message],E.[StackTrace]
,E.[InnerException],E.[Source], IsNull(U.Username, '') Username, 
IsNull(C.PermissionControlName, '') PermissionControlName, 
IsNull(A.UserActionName, '') UserActionName, E.UserId
From ErrorLogs E
Left Join Users U on U.UserId = E.[UserId]
Left Join PermissionsControls C on C.PermissionControlId = E.[ErrorLogControlId]
Left Join UsersActions A on A.UserActionId = E.[UserActionId]



GO
/****** Object:  View [cms].[v_GetMenuByUser]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [cms].[v_GetMenuByUser] as 

WITH temp AS
(
   Select *,
         ROW_NUMBER() OVER (PARTITION BY PermissionActionPagePermissionId ORDER BY PermissionActionPagePermissionId DESC) AS [Index]
   FROM PermissionsActions
)

Select m.[MenuId]
      ,m.[MenuPermissionTypeId]
      ,m.[MenuOrder]
      ,m.[MenuParentId]
      ,m.[MenuName]
      ,m.[MenuDescription]
      ,m.[MenuPath]
      ,m.[MenuPageId]
      ,m.[IsActive] 
      ,u.UserId
From Menus M
Left Join PagesPermissions P on P.PagePermissionPageId = M.MenuPageId
Left Join RolesPermissions R on R.PagePermissionId = P.PagePermissionId
Left Join UsersRoles U on U.RoleId = R.RoleId
where (P.IsEnabled = 1 Or P.IsEnabled is null)
And (P.IsActive = 1 Or P.IsActive is null)
And (M.IsActive = 1 Or M.IsActive is null)

And (P.PagePermissionId not in (
Select PermissionActionPagePermissionId From temp
Where [Index] = 1
And ([Create] = 0 And [Read] = 0 And [UPDATE] = 0 And [Delete] = 0)
) Or P.PagePermissionId Is Null)

GO
/****** Object:  View [cms].[v_GetUsersInformations]    Script Date: 8/6/2014 3:24:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [cms].[v_GetUsersInformations] As
Select U.Username, U.Password, U.Email, E.FirstName, E.LastName, U.IsActive, U.UserId, E.EntityId,
E.CreationDate, E.CreationDateMMS,E.ModificationDate, E.ModificationDateMMS
From Users U
Inner Join Entities E On E.EntityId = U.EntityId



GO
SET IDENTITY_INSERT [cms].[ActionLogs] ON 

INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (1, 1, 1, 1, CAST(0x0000A34600A313B2 AS DateTime), CAST(140610 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (2, 1, 1, 1, CAST(0x0000A34600A31A05 AS DateTime), CAST(140610 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (3, 1, 1, 1, CAST(0x0000A3460114488E AS DateTime), CAST(140610 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (4, 1, 1, 1, CAST(0x0000A346011479F6 AS DateTime), CAST(140610 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (5, 1, 1, 1, CAST(0x0000A3460114BB7E AS DateTime), CAST(140610 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (6, 1, 1, 1, CAST(0x0000A34700C1A009 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (7, 1, 1, 1, CAST(0x0000A34700C1CDD4 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (8, 1, 1, 1, CAST(0x0000A34700CBA2E1 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (9, 1, 1, 1, CAST(0x0000A34700CC103B AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (10, 1, 1, 1, CAST(0x0000A34700CC76CA AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (11, 1, 1, 1, CAST(0x0000A34700CE24F8 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (12, 1, 1, 1, CAST(0x0000A34700D0C4CE AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (13, 1, 1, 1, CAST(0x0000A34700D11CD5 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (14, 1, 1, 1, CAST(0x0000A34700D15BB9 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (15, 1, 1, 1, CAST(0x0000A34700D335E6 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (16, 1, 1, 1, CAST(0x0000A34700D35A83 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (17, 1, 1, 1, CAST(0x0000A34700D9AEC5 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (18, 1, 1, 1, CAST(0x0000A34700D9B8B7 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (19, 1, 1, 1, CAST(0x0000A34700D9CA10 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (20, 1, 1, 1, CAST(0x0000A34700D9D2C7 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (21, 1, 1, 1, CAST(0x0000A34700D9D610 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (22, 1, 1, 1, CAST(0x0000A34700DA1B07 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (23, 1, 1, 1, CAST(0x0000A34700DA2383 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (24, 1, 1, 1, CAST(0x0000A34700DA6A3E AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (25, 1, 1, 1, CAST(0x0000A34700DA9928 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (26, 1, 1, 1, CAST(0x0000A34700DAAE74 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (27, 1, 1, 1, CAST(0x0000A34700DABAAB AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (28, 1, 1, 1, CAST(0x0000A34700FDF1BF AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (29, 1, 1, 1, CAST(0x0000A34700FDF93E AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (30, 1, 1, 1, CAST(0x0000A34700FE05BF AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (31, 1, 1, 1, CAST(0x0000A34700FE70CC AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (32, 1, 1, 1, CAST(0x0000A34700FEC918 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (33, 1, 1, 1, CAST(0x0000A34700FEDC25 AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (34, 1, 1, 1, CAST(0x0000A34700FF5743 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (35, 1, 1, 1, CAST(0x0000A34700FF7339 AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (36, 1, 1, 1, CAST(0x0000A3470106F00C AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (37, 1, 1, 1, CAST(0x0000A34701076291 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (38, 1, 1, 1, CAST(0x0000A347010792EA AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (39, 1, 1, 1, CAST(0x0000A3470107B2D2 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (40, 1, 1, 1, CAST(0x0000A3470107DB5D AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (41, 1, 1, 1, CAST(0x0000A3470107F3C5 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (42, 1, 1, 1, CAST(0x0000A347010815EC AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (43, 1, 1, 1, CAST(0x0000A34701081D78 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (44, 1, 1, 1, CAST(0x0000A34701081F82 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (45, 1, 1, 1, CAST(0x0000A347010822CC AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (46, 1, 1, 1, CAST(0x0000A3470108EC36 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (47, 1, 1, 1, CAST(0x0000A34701090A94 AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (48, 1, 1, 1, CAST(0x0000A34701090EE0 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (49, 1, 1, 1, CAST(0x0000A347010A1B1C AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (50, 1, 1, 1, CAST(0x0000A347010FBB75 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (51, 1, 1, 1, CAST(0x0000A347010FC89C AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (52, 1, 1, 1, CAST(0x0000A347010FC9D0 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (53, 1, 1, 1, CAST(0x0000A347010FCC23 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (54, 1, 1, 1, CAST(0x0000A347010FCD2D AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (55, 1, 1, 1, CAST(0x0000A347010FCEB8 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (56, 1, 1, 1, CAST(0x0000A347010FD022 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (57, 1, 1, 1, CAST(0x0000A347010FD1D2 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (58, 1, 1, 1, CAST(0x0000A347010FD2A1 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (59, 1, 1, 1, CAST(0x0000A347010FD38D AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (60, 1, 1, 1, CAST(0x0000A347010FD4E0 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (61, 1, 1, 1, CAST(0x0000A347010FD5AC AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (62, 1, 1, 1, CAST(0x0000A347010FFB12 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (63, 1, 1, 1, CAST(0x0000A347010FFDA8 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (64, 1, 1, 1, CAST(0x0000A347010FFF64 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (65, 1, 1, 1, CAST(0x0000A347011000DA AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (66, 1, 1, 1, CAST(0x0000A347011002EE AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (67, 1, 1, 1, CAST(0x0000A34701100523 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (68, 1, 1, 1, CAST(0x0000A347011006E3 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (69, 1, 1, 1, CAST(0x0000A3470110080F AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (70, 1, 1, 1, CAST(0x0000A34701100A53 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (71, 1, 1, 1, CAST(0x0000A34701100BE9 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (72, 1, 1, 1, CAST(0x0000A34701100E1A AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (73, 1, 1, 1, CAST(0x0000A3470110137B AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (74, 1, 1, 1, CAST(0x0000A34701101537 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (75, 1, 1, 1, CAST(0x0000A34701101811 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (76, 1, 1, 1, CAST(0x0000A34701101970 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (77, 1, 1, 1, CAST(0x0000A3470110AD03 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (78, 1, 1, 1, CAST(0x0000A3470111CB67 AS DateTime), CAST(140611 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (79, 1, 1, 1, CAST(0x0000A3470111CF5D AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (80, 1, 1, 1, CAST(0x0000A347011223D2 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (81, 1, 1, 1, CAST(0x0000A34701123B80 AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (82, 1, 1, 1, CAST(0x0000A347011242A1 AS DateTime), CAST(140611 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (83, 1, 1, 1, CAST(0x0000A3470112F01F AS DateTime), CAST(140611 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (84, 1, 1, 1, CAST(0x0000A348009851DB AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (85, 1, 1, 1, CAST(0x0000A34800995EB4 AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (86, 1, 1, 1, CAST(0x0000A348009A5BC8 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (87, 1, 1, 1, CAST(0x0000A348009A667E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (88, 1, 1, 1, CAST(0x0000A348009A7013 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (89, 1, 1, 1, CAST(0x0000A348009A739B AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (90, 1, 1, 1, CAST(0x0000A348009AB211 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (91, 1, 1, 1, CAST(0x0000A348009AE406 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (92, 1, 1, 1, CAST(0x0000A348009B2DFE AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (93, 1, 1, 1, CAST(0x0000A348009B4C07 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (94, 1, 1, 1, CAST(0x0000A348009BB490 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (95, 1, 1, 1, CAST(0x0000A348009BBCFF AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (96, 1, 1, 1, CAST(0x0000A348009BC429 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (97, 1, 1, 1, CAST(0x0000A348009BD22B AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (98, 1, 1, 1, CAST(0x0000A348009BD5D7 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (99, 1, 1, 1, CAST(0x0000A348009C49B2 AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
GO
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (100, 1, 1, 1, CAST(0x0000A348009C6294 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (101, 1, 1, 1, CAST(0x0000A348009CB1D5 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (102, 1, 1, 1, CAST(0x0000A348009CB38D AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (103, 1, 1, 1, CAST(0x0000A348009D1621 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (104, 1, 1, 1, CAST(0x0000A348009D1C58 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (105, 1, 1, 1, CAST(0x0000A348009E619E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (106, 1, 1, 1, CAST(0x0000A348009EFFB0 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (107, 1, 1, 1, CAST(0x0000A348009F0FEC AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (108, 1, 1, 1, CAST(0x0000A348009F4614 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (109, 1, 1, 1, CAST(0x0000A348009F5BDA AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (110, 1, 1, 1, CAST(0x0000A34800A1C199 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (111, 1, 1, 1, CAST(0x0000A34800A1CEB5 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (112, 1, 1, 1, CAST(0x0000A34800A1D511 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (113, 1, 1, 1, CAST(0x0000A34800A7395C AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (114, 1, 1, 1, CAST(0x0000A34800A7CF94 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (115, 1, 1, 1, CAST(0x0000A34800AB4D79 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (116, 1, 1, 1, CAST(0x0000A34800AB5648 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (117, 1, 1, 1, CAST(0x0000A34800ABFC6B AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (118, 1, 1, 1, CAST(0x0000A34800AC2724 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (119, 1, 1, 1, CAST(0x0000A34800AC9D79 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (120, 1, 1, 1, CAST(0x0000A34800ACA553 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (121, 1, 1, 1, CAST(0x0000A34800ACACF3 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (122, 1, 1, 1, CAST(0x0000A34800ACAFB5 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (123, 1, 1, 1, CAST(0x0000A34800ACB73D AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (124, 1, 1, 1, CAST(0x0000A34800ACB968 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (125, 1, 1, 1, CAST(0x0000A34800AF40EF AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (126, 1, 1, 1, CAST(0x0000A34800AF48A0 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (127, 1, 1, 1, CAST(0x0000A34800AF8285 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (128, 1, 1, 1, CAST(0x0000A34800AF8517 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (129, 1, 1, 1, CAST(0x0000A34800AF96C0 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (130, 1, 1, 1, CAST(0x0000A34800D1C908 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (131, 1, 1, 1, CAST(0x0000A34800D24E5F AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (132, 1, 1, 1, CAST(0x0000A34800D5B2E1 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (133, 1, 1, 1, CAST(0x0000A34800DBF4D9 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (134, 1, 1, 1, CAST(0x0000A34800DC22EA AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (135, 1, 1, 1, CAST(0x0000A34800DC2DCB AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (136, 1, 1, 1, CAST(0x0000A34800DC3772 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (137, 1, 1, 1, CAST(0x0000A34800DC3DB7 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (138, 1, 1, 1, CAST(0x0000A34800DC4D7E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (139, 1, 1, 1, CAST(0x0000A34800EDA871 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (140, 1, 1, 1, CAST(0x0000A34800EDAC56 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (141, 1, 1, 1, CAST(0x0000A34800EDB099 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (142, 1, 1, 1, CAST(0x0000A34800EDB644 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (143, 1, 1, 1, CAST(0x0000A34800EE324E AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (144, 1, 1, 1, CAST(0x0000A34800EF9711 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (145, 1, 1, 1, CAST(0x0000A34800EF9800 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (146, 1, 1, 1, CAST(0x0000A34800F3DDF3 AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (147, 1, 1, 1, CAST(0x0000A34800F42657 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (148, 1, 1, 1, CAST(0x0000A34800F441C3 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (149, 1, 1, 1, CAST(0x0000A34800F45096 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (150, 1, 1, 1, CAST(0x0000A34800F49AFC AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (151, 1, 1, 1, CAST(0x0000A34800F4A62A AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (152, 1, 1, 1, CAST(0x0000A34800F50248 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (153, 1, 1, 1, CAST(0x0000A34800F505E7 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (154, 1, 1, 1, CAST(0x0000A34800F50F55 AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (155, 1, 1, 1, CAST(0x0000A34800F513E7 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (156, 1, 1, 1, CAST(0x0000A34800F94967 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (157, 1, 1, 1, CAST(0x0000A34800F985EE AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (158, 1, 1, 1, CAST(0x0000A34800F9C578 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (159, 1, 1, 1, CAST(0x0000A34800F9C788 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (160, 1, 1, 1, CAST(0x0000A34800F9CF4E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (161, 1, 1, 1, CAST(0x0000A34800F9D036 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (162, 1, 1, 1, CAST(0x0000A34800F9D487 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (163, 1, 1, 1, CAST(0x0000A34800F9D588 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (164, 1, 1, 1, CAST(0x0000A34800F9DF0A AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (165, 1, 1, 1, CAST(0x0000A34800FA2BDB AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (166, 1, 1, 1, CAST(0x0000A34800FA2FB6 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (167, 1, 1, 1, CAST(0x0000A34800FA467E AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (168, 1, 1, 1, CAST(0x0000A34800FA4C86 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (169, 1, 1, 1, CAST(0x0000A34800FA5219 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (170, 1, 1, 1, CAST(0x0000A34800FA548C AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (171, 1, 1, 1, CAST(0x0000A34800FA595B AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (172, 1, 1, 1, CAST(0x0000A34800FA661E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (173, 1, 1, 1, CAST(0x0000A34800FB93F9 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (174, 1, 1, 1, CAST(0x0000A34800FB9537 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (175, 1, 1, 1, CAST(0x0000A34800FBB011 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (176, 1, 1, 1, CAST(0x0000A34800FBB315 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (177, 1, 1, 1, CAST(0x0000A34800FBBA1B AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (178, 1, 1, 1, CAST(0x0000A34800FBBD5C AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (179, 1, 1, 1, CAST(0x0000A34800FC2CE0 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (180, 1, 1, 1, CAST(0x0000A34800FC453A AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (181, 1, 1, 1, CAST(0x0000A34800FE76D5 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (182, 1, 1, 1, CAST(0x0000A34800FE77CD AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (183, 1, 1, 1, CAST(0x0000A34800FE7CEC AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (184, 1, 1, 1, CAST(0x0000A34800FE7DE8 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (185, 1, 1, 1, CAST(0x0000A34800FE81B1 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (186, 1, 1, 1, CAST(0x0000A34800FE82AE AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (187, 1, 1, 1, CAST(0x0000A34800FE83D5 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (188, 1, 1, 1, CAST(0x0000A34800FE84A2 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (189, 1, 1, 1, CAST(0x0000A34800FE860B AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (190, 1, 1, 1, CAST(0x0000A34800FE86C6 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (191, 1, 1, 1, CAST(0x0000A34800FE8794 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (192, 1, 1, 1, CAST(0x0000A34800FE8859 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (193, 1, 1, 1, CAST(0x0000A34800FE899C AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (194, 1, 1, 1, CAST(0x0000A34800FE8A81 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (195, 1, 1, 1, CAST(0x0000A34800FE8C92 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (196, 1, 1, 1, CAST(0x0000A34800FE8D72 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (197, 1, 1, 1, CAST(0x0000A34800FEA64F AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (198, 1, 1, 1, CAST(0x0000A34800FEB598 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (199, 1, 1, 1, CAST(0x0000A34800FEB6F7 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
GO
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (200, 1, 1, 1, CAST(0x0000A34800FEB9CC AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (201, 1, 1, 1, CAST(0x0000A34800FED3A9 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (202, 1, 1, 1, CAST(0x0000A34800FEE71C AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (203, 1, 1, 1, CAST(0x0000A34800FEEF06 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (204, 1, 1, 1, CAST(0x0000A34800FF05BB AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (205, 1, 1, 1, CAST(0x0000A34800FF1226 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (206, 1, 1, 1, CAST(0x0000A34800FF19F0 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (207, 1, 1, 1, CAST(0x0000A34800FF248F AS DateTime), CAST(140612 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (208, 1, 1, 1, CAST(0x0000A34800FF282E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (209, 1, 1, 1, CAST(0x0000A3480102CB90 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (210, 1, 1, 1, CAST(0x0000A3480102CFF3 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (211, 1, 1, 1, CAST(0x0000A3480102D9CE AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (212, 1, 1, 1, CAST(0x0000A3480102DF16 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (213, 1, 1, 1, CAST(0x0000A3480102F079 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (214, 1, 1, 1, CAST(0x0000A3480102F4D8 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (215, 1, 1, 1, CAST(0x0000A34801032233 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (216, 1, 1, 1, CAST(0x0000A34801032618 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (217, 1, 1, 1, CAST(0x0000A34801032DF9 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (218, 1, 1, 1, CAST(0x0000A34801034155 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (219, 1, 1, 1, CAST(0x0000A348010344E1 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (220, 1, 1, 1, CAST(0x0000A34801035235 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (221, 1, 1, 1, CAST(0x0000A348010356B4 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (222, 1, 1, 1, CAST(0x0000A34801035EBA AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (223, 1, 1, 1, CAST(0x0000A34801036453 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (224, 1, 1, 1, CAST(0x0000A34801036D4D AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (225, 1, 1, 1, CAST(0x0000A3480103763D AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (226, 1, 1, 1, CAST(0x0000A34801037C2E AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (227, 1, 1, 1, CAST(0x0000A348010380D3 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (228, 1, 1, 1, CAST(0x0000A3480103859D AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (229, 1, 1, 1, CAST(0x0000A348010388EB AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (230, 1, 1, 1, CAST(0x0000A3480103AC0D AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (231, 1, 1, 1, CAST(0x0000A3480103B1AE AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (232, 1, 1, 1, CAST(0x0000A3480104A502 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (233, 1, 1, 1, CAST(0x0000A3480104C0ED AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (234, 1, 1, 1, CAST(0x0000A3480104C546 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (235, 1, 1, 1, CAST(0x0000A3480104CC96 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (236, 1, 1, 1, CAST(0x0000A3480104D3C5 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (237, 1, 1, 1, CAST(0x0000A3480104D77D AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (238, 1, 1, 1, CAST(0x0000A3480104E267 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (239, 1, 1, 1, CAST(0x0000A3480104ED02 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (240, 1, 1, 1, CAST(0x0000A3480104F410 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (241, 1, 1, 1, CAST(0x0000A3480104FB6E AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (242, 1, 1, 1, CAST(0x0000A3480105A945 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (243, 1, 1, 1, CAST(0x0000A3480105B981 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (244, 1, 1, 1, CAST(0x0000A3480105C55E AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (245, 1, 1, 1, CAST(0x0000A3480105CD15 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (246, 1, 1, 1, CAST(0x0000A3480106EE5B AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (247, 1, 1, 1, CAST(0x0000A3480106FB1E AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (248, 1, 1, 1, CAST(0x0000A3480108D1FC AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (249, 1, 1, 1, CAST(0x0000A34801095E65 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (250, 1, 1, 1, CAST(0x0000A348010AEEDD AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (251, 1, 1, 1, CAST(0x0000A348010AF17F AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (252, 1, 1, 1, CAST(0x0000A348010AF433 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (253, 1, 1, 1, CAST(0x0000A348010AFA58 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (254, 1, 1, 1, CAST(0x0000A348010B173F AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (255, 1, 1, 1, CAST(0x0000A348010B1C6B AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (256, 1, 1, 1, CAST(0x0000A348010B2290 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (257, 1, 1, 1, CAST(0x0000A348010D4DB0 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (258, 1, 1, 1, CAST(0x0000A348010E1E14 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (259, 1, 1, 1, CAST(0x0000A348010E241C AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (260, 1, 1, 1, CAST(0x0000A3480111E4E3 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (261, 1, 1, 1, CAST(0x0000A34801160C74 AS DateTime), CAST(140612 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (262, 1, 1, 1, CAST(0x0000A3480119C1EF AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (263, 1, 1, 1, CAST(0x0000A348011AF147 AS DateTime), CAST(140612 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (264, 1, 1, 1, CAST(0x0000A349009BFDD5 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (265, 1, 1, 1, CAST(0x0000A349009C0E45 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (266, 1, 1, 1, CAST(0x0000A349009C1895 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (267, 1, 1, 1, CAST(0x0000A349009C2177 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (268, 1, 1, 1, CAST(0x0000A349009CA14B AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (269, 1, 1, 1, CAST(0x0000A349009CBA8A AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (270, 1, 1, 1, CAST(0x0000A349009CC13B AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (271, 1, 1, 1, CAST(0x0000A349009CC60E AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (272, 1, 1, 1, CAST(0x0000A349009CCC1C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (273, 1, 1, 1, CAST(0x0000A349009CDA2A AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (274, 1, 1, 1, CAST(0x0000A349009CE4FD AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (275, 1, 1, 1, CAST(0x0000A349009CEB01 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (276, 1, 1, 1, CAST(0x0000A349009CEEAE AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (277, 1, 1, 1, CAST(0x0000A349009CF5D4 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (278, 1, 1, 1, CAST(0x0000A349009D007C AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (279, 1, 1, 1, CAST(0x0000A349009D0A28 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (280, 1, 1, 1, CAST(0x0000A349009DB5F7 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (281, 1, 1, 1, CAST(0x0000A349009DBAB4 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (282, 1, 1, 1, CAST(0x0000A349009DBE3F AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (283, 1, 1, 1, CAST(0x0000A349009DC497 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (284, 1, 1, 1, CAST(0x0000A349009DCD26 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (285, 1, 1, 1, CAST(0x0000A349009DCFD6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (286, 1, 1, 1, CAST(0x0000A349009DD9F6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (287, 1, 1, 1, CAST(0x0000A349009E016F AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (288, 1, 1, 1, CAST(0x0000A349009E04A6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (289, 1, 1, 1, CAST(0x0000A349009E0764 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (290, 1, 1, 1, CAST(0x0000A349009E0894 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (291, 1, 1, 1, CAST(0x0000A349009E0A22 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (292, 1, 1, 1, CAST(0x0000A349009E0B4E AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (293, 1, 1, 1, CAST(0x0000A349009E0C87 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (294, 1, 1, 1, CAST(0x0000A349009E11E3 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (295, 1, 1, 1, CAST(0x0000A349009E1326 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (296, 1, 1, 1, CAST(0x0000A349009E14F0 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (297, 1, 1, 1, CAST(0x0000A349009E2889 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (298, 1, 1, 1, CAST(0x0000A349009E2F3F AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (299, 1, 1, 1, CAST(0x0000A349009E35B3 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
GO
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (300, 1, 1, 1, CAST(0x0000A349009E36AB AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (301, 1, 1, 1, CAST(0x0000A349009E433A AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (302, 1, 1, 1, CAST(0x0000A349009E4728 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (303, 1, 1, 1, CAST(0x0000A349009ECBF5 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (304, 1, 1, 1, CAST(0x0000A349009F292D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (305, 1, 1, 1, CAST(0x0000A349009F2B18 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (306, 1, 1, 1, CAST(0x0000A349009F2C81 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (307, 1, 1, 1, CAST(0x0000A349009F505F AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (308, 1, 1, 1, CAST(0x0000A34900A4D101 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (309, 1, 1, 1, CAST(0x0000A34900A4E0B9 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (310, 1, 1, 1, CAST(0x0000A34900A4E790 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (311, 1, 1, 1, CAST(0x0000A34900A4EAC7 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (312, 1, 1, 1, CAST(0x0000A34900A4EDF6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (313, 1, 1, 1, CAST(0x0000A34900A53916 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (314, 1, 1, 1, CAST(0x0000A34900A53FCB AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (315, 1, 1, 1, CAST(0x0000A34900A55153 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (316, 1, 1, 1, CAST(0x0000A34900A557AB AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (317, 1, 1, 1, CAST(0x0000A34900A571AA AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (318, 1, 1, 1, CAST(0x0000A34900A57734 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (319, 1, 1, 1, CAST(0x0000A34900A5C6BF AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (320, 1, 1, 1, CAST(0x0000A34900A5CCC3 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (321, 1, 1, 1, CAST(0x0000A34900A5DB1D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (322, 1, 1, 1, CAST(0x0000A34900A5E243 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (323, 1, 1, 1, CAST(0x0000A34900A5E809 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (324, 1, 1, 1, CAST(0x0000A34900A5F8D2 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (325, 1, 1, 1, CAST(0x0000A34900A60E9C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (326, 1, 1, 1, CAST(0x0000A34900A612FF AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (327, 1, 1, 1, CAST(0x0000A34900A615E3 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (328, 1, 1, 1, CAST(0x0000A34900A62EA4 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (329, 1, 1, 1, CAST(0x0000A34900B95A61 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (330, 1, 1, 1, CAST(0x0000A34900B96A2C AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (331, 1, 1, 1, CAST(0x0000A34900B96FCC AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (332, 1, 1, 1, CAST(0x0000A34900B97232 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (333, 1, 1, 1, CAST(0x0000A34900B97632 AS DateTime), CAST(140613 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (334, 1, 1, 1, CAST(0x0000A34900B992B5 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (335, 1, 1, 1, CAST(0x0000A34900B99CD2 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (336, 1, 1, 1, CAST(0x0000A34900B9CF57 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (337, 1, 1, 1, CAST(0x0000A34900BAB291 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (338, 1, 1, 1, CAST(0x0000A34900BB1D95 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (339, 1, 1, 1, CAST(0x0000A34900C2D070 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (340, 1, 1, 1, CAST(0x0000A34900C2D620 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (341, 1, 1, 1, CAST(0x0000A34900C30760 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (342, 1, 1, 1, CAST(0x0000A34900C30BF6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (343, 1, 1, 1, CAST(0x0000A34900C31469 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (344, 1, 1, 1, CAST(0x0000A34900C31CC4 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (345, 1, 1, 1, CAST(0x0000A34900C40CB6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (346, 1, 1, 1, CAST(0x0000A34900C436BD AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (347, 1, 1, 1, CAST(0x0000A34900C4538D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (348, 1, 1, 1, CAST(0x0000A34900C45663 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (349, 1, 1, 1, CAST(0x0000A34900C46784 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (350, 1, 1, 1, CAST(0x0000A34900C47965 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (351, 1, 1, 1, CAST(0x0000A34900C47C9D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (352, 1, 1, 1, CAST(0x0000A34900C48DDA AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (353, 1, 1, 1, CAST(0x0000A34900C490A2 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (354, 1, 1, 1, CAST(0x0000A34900C4E9AF AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (355, 1, 1, 1, CAST(0x0000A34900C6C2CA AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (356, 1, 1, 1, CAST(0x0000A34900CA8E52 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (357, 1, 1, 1, CAST(0x0000A34900CADCB0 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (358, 1, 1, 1, CAST(0x0000A34900CAE39C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (359, 1, 1, 1, CAST(0x0000A34900CB6BBA AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (360, 1, 1, 1, CAST(0x0000A34900CBF95D AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (361, 1, 1, 1, CAST(0x0000A34900CC6C84 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (362, 1, 1, 1, CAST(0x0000A34900CC71B1 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (363, 1, 1, 1, CAST(0x0000A34900CC756E AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (364, 1, 1, 1, CAST(0x0000A34900CED0DA AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (365, 1, 1, 1, CAST(0x0000A34900CEE5CA AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (366, 1, 1, 1, CAST(0x0000A34900CEE9B4 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (367, 1, 1, 1, CAST(0x0000A34900CEF044 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (368, 1, 1, 1, CAST(0x0000A34900CEF3E3 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (369, 1, 1, 1, CAST(0x0000A34900CFBC2C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (370, 1, 1, 1, CAST(0x0000A34900CFC2C6 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (371, 1, 1, 1, CAST(0x0000A34900CFC834 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (372, 1, 1, 1, CAST(0x0000A34900D00E7E AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (373, 1, 1, 1, CAST(0x0000A34900D015CE AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (374, 1, 1, 1, CAST(0x0000A34900D01CDA AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (375, 1, 1, 1, CAST(0x0000A34900D02329 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (376, 1, 1, 1, CAST(0x0000A34900F0CA2D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (377, 1, 1, 1, CAST(0x0000A34900F1EE27 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (378, 1, 1, 1, CAST(0x0000A34900F1F775 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (379, 1, 1, 1, CAST(0x0000A34900F1FCD5 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (380, 1, 1, 1, CAST(0x0000A34900F20BD1 AS DateTime), CAST(140613 AS Numeric(6, 0)), 1)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (381, 1, 1, 1, CAST(0x0000A34900F20F12 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (382, 1, 1, 1, CAST(0x0000A34900F21363 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (383, 1, 1, 1, CAST(0x0000A34900F241EF AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (384, 1, 2, 3, CAST(0x0000A34900FE9B60 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (385, 1, 2, 3, CAST(0x0000A34900FF8FA2 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (386, 1, 1, 1, CAST(0x0000A34900FF9864 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (387, 1, 2, 3, CAST(0x0000A34900FF9CDA AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (388, 1, 2, 3, CAST(0x0000A34900FFA732 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (389, 1, 2, 3, CAST(0x0000A34901006E17 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (390, 1, 2, 3, CAST(0x0000A349010071D2 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (391, 1, 2, 3, CAST(0x0000A349010075A9 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (392, 1, 2, 3, CAST(0x0000A34901007D85 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (393, 1, 2, 3, CAST(0x0000A3490100834C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (394, 1, 2, 3, CAST(0x0000A34901008A97 AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (395, 1, 2, 3, CAST(0x0000A3490100926F AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (396, 1, 2, 3, CAST(0x0000A3490100982C AS DateTime), CAST(140613 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (397, 1, 2, 3, CAST(0x0000A34901023A30 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (398, 1, 1, 1, CAST(0x0000A34901024192 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (399, 1, 2, 3, CAST(0x0000A34901024D82 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
GO
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (400, 1, 1, 1, CAST(0x0000A349010257A3 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (401, 1, 2, 3, CAST(0x0000A34901026C0E AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (402, 1, 1, 1, CAST(0x0000A3490102771E AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (403, 1, 1, 1, CAST(0x0000A3490102D95C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (404, 1, 2, 3, CAST(0x0000A3490102DE6C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (405, 1, 2, 3, CAST(0x0000A3490102F141 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (406, 1, 1, 1, CAST(0x0000A3490102F83C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (407, 1, 2, 3, CAST(0x0000A349010F7979 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (408, 1, 2, 3, CAST(0x0000A349010FAC51 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (409, 1, 1, 1, CAST(0x0000A349010FB37B AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (410, 1, 1, 1, CAST(0x0000A349010FB618 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (411, 1, 1, 1, CAST(0x0000A349010FB9C5 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (412, 1, 1, 1, CAST(0x0000A349010FBB3B AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (413, 1, 2, 3, CAST(0x0000A3490110D899 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (414, 1, 2, 3, CAST(0x0000A3490110DC17 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (415, 1, 2, 3, CAST(0x0000A3490110DEE7 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (416, 1, 2, 3, CAST(0x0000A3490111043C AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (417, 1, 2, 3, CAST(0x0000A34901110584 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (418, 1, 2, 3, CAST(0x0000A3490111083D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (419, 1, 2, 3, CAST(0x0000A34901110A73 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (420, 1, 2, 3, CAST(0x0000A34901112F8F AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (421, 1, 2, 3, CAST(0x0000A34901114094 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (422, 1, 1, 1, CAST(0x0000A34901138EBE AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (423, 1, 2, 3, CAST(0x0000A3490113A38D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (424, 1, 1, 1, CAST(0x0000A34901150252 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (425, 1, 2, 3, CAST(0x0000A34901150F6D AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (426, 1, 2, 3, CAST(0x0000A34901156221 AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (427, 1, 1, 1, CAST(0x0000A3490115684F AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (428, 1, 2, 3, CAST(0x0000A34901156E3B AS DateTime), CAST(140613 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (429, 1, 4, 5, CAST(0x0000A34C00CB9E13 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (430, 1, 4, 5, CAST(0x0000A34C00CBAD84 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (431, 1, 4, 5, CAST(0x0000A34C00CBAEE1 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (432, 1, 4, 5, CAST(0x0000A34C00CBB02E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (433, 1, 4, 5, CAST(0x0000A34C00CBB0F1 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (434, 1, 4, 5, CAST(0x0000A34C00CBB367 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (435, 1, 4, 5, CAST(0x0000A34C00CBB431 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (436, 1, 4, 5, CAST(0x0000A34C00CBB5BF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (437, 1, 4, 5, CAST(0x0000A34C00CC5D40 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (438, 1, 4, 5, CAST(0x0000A34C00CC62CB AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (439, 1, 4, 5, CAST(0x0000A34C00CC64B7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (440, 1, 4, 5, CAST(0x0000A34C00CC6695 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (441, 1, 4, 5, CAST(0x0000A34C00CC682C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (442, 1, 4, 5, CAST(0x0000A34C00CC69D7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (443, 1, 4, 5, CAST(0x0000A34C00CC6E3F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (444, 1, 4, 5, CAST(0x0000A34C00CC6FC5 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (445, 1, 4, 5, CAST(0x0000A34C00CC7357 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (446, 1, 4, 5, CAST(0x0000A34C00CC752E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (447, 1, 4, 5, CAST(0x0000A34C00CC7773 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (448, 1, 4, 5, CAST(0x0000A34C00CC78C9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (449, 1, 4, 5, CAST(0x0000A34C00CC7D01 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (450, 1, 4, 5, CAST(0x0000A34C00CC7ED9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (451, 1, 4, 5, CAST(0x0000A34C00CC7F91 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (452, 1, 4, 5, CAST(0x0000A34C00CC804F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (453, 1, 4, 5, CAST(0x0000A34C00CC8110 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (454, 1, 4, 5, CAST(0x0000A34C00CC81E7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (455, 1, 4, 5, CAST(0x0000A34C00CC84AC AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (456, 1, 4, 5, CAST(0x0000A34C00CC8586 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (457, 1, 4, 5, CAST(0x0000A34C00CC8623 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (458, 1, 4, 5, CAST(0x0000A34C00CC86ED AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (459, 1, 4, 5, CAST(0x0000A34C00CC8847 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (460, 1, 4, 5, CAST(0x0000A34C00CC8934 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (461, 1, 4, 5, CAST(0x0000A34C00CC8A9E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (462, 1, 4, 5, CAST(0x0000A34C00CC8B97 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (463, 1, 4, 5, CAST(0x0000A34C00CC8C8C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (464, 1, 4, 5, CAST(0x0000A34C00CC8F56 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (465, 1, 4, 5, CAST(0x0000A34C00CC904D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (466, 1, 4, 5, CAST(0x0000A34C00CC9139 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (467, 1, 4, 5, CAST(0x0000A34C00CC92B6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (468, 1, 4, 5, CAST(0x0000A34C00CC936F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (469, 1, 4, 5, CAST(0x0000A34C00CC945C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (470, 1, 4, 5, CAST(0x0000A34C00CC95C5 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (471, 1, 4, 5, CAST(0x0000A34C00CC96A8 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (472, 1, 4, 5, CAST(0x0000A34C00CC9782 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (473, 1, 4, 5, CAST(0x0000A34C00CC9863 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (474, 1, 4, 5, CAST(0x0000A34C00CC9B41 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (475, 1, 4, 5, CAST(0x0000A34C00CC9C24 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (476, 1, 4, 5, CAST(0x0000A34C00CC9D7F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (477, 1, 4, 5, CAST(0x0000A34C00CC9E90 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (478, 1, 4, 5, CAST(0x0000A34C00CC9F5E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (479, 1, 4, 5, CAST(0x0000A34C00CCA01D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (480, 1, 4, 5, CAST(0x0000A34C00CCA0E4 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (481, 1, 4, 5, CAST(0x0000A34C00CCA1B9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (482, 1, 4, 5, CAST(0x0000A34C00CCA321 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (483, 1, 4, 5, CAST(0x0000A34C00CCA419 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (484, 1, 4, 5, CAST(0x0000A34C00CCA764 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (485, 1, 4, 5, CAST(0x0000A34C00CCA840 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (486, 1, 4, 5, CAST(0x0000A34C00CCA8F0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (487, 1, 4, 5, CAST(0x0000A34C00CCA9BB AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (488, 1, 4, 5, CAST(0x0000A34C00CCAAD3 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (489, 1, 4, 5, CAST(0x0000A34C00CCAC13 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (490, 1, 4, 5, CAST(0x0000A34C00CCACF6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (491, 1, 4, 5, CAST(0x0000A34C00CCAD98 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (492, 1, 4, 5, CAST(0x0000A34C00CCAE55 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (493, 1, 4, 5, CAST(0x0000A34C00CCAF23 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (494, 1, 4, 5, CAST(0x0000A34C00CCB268 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (495, 1, 4, 5, CAST(0x0000A34C00CCB32B AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (496, 1, 4, 5, CAST(0x0000A34C00CCB3DE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (497, 1, 4, 5, CAST(0x0000A34C00CCB47D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (498, 1, 4, 5, CAST(0x0000A34C00CCB530 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (499, 1, 4, 5, CAST(0x0000A34C00CCB5E0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
GO
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (500, 1, 4, 5, CAST(0x0000A34C00CCB6B6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (501, 1, 4, 5, CAST(0x0000A34C00CCB76E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (502, 1, 4, 5, CAST(0x0000A34C00CCB843 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (503, 1, 4, 5, CAST(0x0000A34C00CCB937 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (504, 1, 4, 5, CAST(0x0000A34C00CD77BF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (505, 1, 4, 5, CAST(0x0000A34C00CD876D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (506, 1, 4, 5, CAST(0x0000A34C00CD8C17 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (507, 1, 4, 5, CAST(0x0000A34C00CE396C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (508, 1, 4, 5, CAST(0x0000A34C00CE408C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (509, 1, 4, 5, CAST(0x0000A34C00CE593A AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (510, 1, 4, 5, CAST(0x0000A34C00CE5CF0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (511, 1, 4, 5, CAST(0x0000A34C00CE5F92 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (512, 1, 4, 5, CAST(0x0000A34C00CE60AF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (513, 1, 5, 6, CAST(0x0000A34C00D6B1DE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (514, 1, 5, 6, CAST(0x0000A34C00D6B7FE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (515, 1, 5, 6, CAST(0x0000A34C00D6BA88 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (516, 1, 5, 6, CAST(0x0000A34C00D6BBF1 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (517, 1, 5, 6, CAST(0x0000A34C00D6BDD3 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (518, 1, 5, 6, CAST(0x0000A34C00D6BF6F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (519, 1, 5, 6, CAST(0x0000A34C00D6C0C4 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (520, 1, 5, 6, CAST(0x0000A34C00D6C249 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (521, 1, 5, 6, CAST(0x0000A34C00D6C492 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (522, 1, 5, 6, CAST(0x0000A34C00D6C577 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (523, 1, 5, 6, CAST(0x0000A34C00D6C666 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (524, 1, 5, 6, CAST(0x0000A34C00D6C8F0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (525, 1, 5, 6, CAST(0x0000A34C00D6C9F6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (526, 1, 5, 6, CAST(0x0000A34C00D6CAC9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (527, 1, 5, 6, CAST(0x0000A34C00D6CBA0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (528, 1, 5, 6, CAST(0x0000A34C00D6FC29 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (529, 1, 5, 6, CAST(0x0000A34C00D70439 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (530, 1, 5, 6, CAST(0x0000A34C00D70E3E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (531, 1, 5, 6, CAST(0x0000A34C00D71758 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (532, 1, 5, 6, CAST(0x0000A34C00D72218 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (533, 1, 4, 5, CAST(0x0000A34C00D72781 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (534, 1, 4, 5, CAST(0x0000A34C00D72CC5 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (535, 1, 4, 5, CAST(0x0000A34C00D72EC8 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (536, 1, 4, 5, CAST(0x0000A34C00D7346E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (537, 1, 4, 5, CAST(0x0000A34C00D73FE0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (538, 1, 4, 5, CAST(0x0000A34C00D74406 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (539, 1, 4, 5, CAST(0x0000A34C00D74BE2 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (540, 1, 4, 5, CAST(0x0000A34C00D74EAA AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (541, 1, 4, 5, CAST(0x0000A34C00D75062 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (542, 1, 4, 5, CAST(0x0000A34C00D751F9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (543, 1, 4, 5, CAST(0x0000A34C00D753E9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (544, 1, 4, 5, CAST(0x0000A34C00D754EA AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (545, 1, 4, 5, CAST(0x0000A34C00D7560D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (546, 1, 4, 5, CAST(0x0000A34C00D757B6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (547, 1, 4, 5, CAST(0x0000A34C00D758CF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (548, 1, 4, 5, CAST(0x0000A34C00D75A38 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (549, 1, 4, 5, CAST(0x0000A34C00D75B26 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (550, 1, 4, 5, CAST(0x0000A34C00D75C56 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (551, 1, 4, 5, CAST(0x0000A34C00D75D5D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (552, 1, 4, 5, CAST(0x0000A34C00D75F10 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (553, 1, 4, 5, CAST(0x0000A34C00D76790 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (554, 1, 4, 5, CAST(0x0000A34C00D76906 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (555, 1, 4, 5, CAST(0x0000A34C00D76A16 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (556, 1, 4, 5, CAST(0x0000A34C00D76D7C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (557, 1, 4, 5, CAST(0x0000A34C00D76F42 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (558, 1, 4, 5, CAST(0x0000A34C00D77085 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (559, 1, 4, 5, CAST(0x0000A34C00D771ED AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (560, 1, 4, 5, CAST(0x0000A34C00D773AA AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (561, 1, 4, 5, CAST(0x0000A34C00D774F6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (562, 1, 4, 5, CAST(0x0000A34C00D777DA AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (563, 1, 4, 5, CAST(0x0000A34C00D77950 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (564, 1, 4, 5, CAST(0x0000A34C00D77B2D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (565, 1, 4, 5, CAST(0x0000A34C00D77C26 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (566, 1, 4, 5, CAST(0x0000A34C00D77D5A AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (567, 1, 4, 5, CAST(0x0000A34C00D77EB5 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (568, 1, 4, 5, CAST(0x0000A34C00D78030 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (569, 1, 4, 5, CAST(0x0000A34C00D7810C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (570, 1, 4, 5, CAST(0x0000A34C00D78245 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (571, 1, 4, 5, CAST(0x0000A34C00D783CE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (572, 1, 4, 5, CAST(0x0000A34C00D7878E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (573, 1, 4, 5, CAST(0x0000A34C00D789C9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (574, 1, 4, 5, CAST(0x0000A34C00D79387 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (575, 1, 4, 5, CAST(0x0000A34C00D794E1 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (576, 1, 4, 5, CAST(0x0000A34C00D79653 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (577, 1, 5, 6, CAST(0x0000A34C00E9DD5E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (578, 1, 5, 6, CAST(0x0000A34C00E9DFE0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (579, 1, 5, 6, CAST(0x0000A34C00E9E102 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (580, 1, 5, 6, CAST(0x0000A34C00E9E1FE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (581, 1, 5, 6, CAST(0x0000A34C00E9E2B9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (582, 1, 5, 6, CAST(0x0000A34C00E9F2AF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (583, 1, 5, 6, CAST(0x0000A34C00EA02BC AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (584, 1, 5, 6, CAST(0x0000A34C00EA7C1B AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (585, 1, 5, 6, CAST(0x0000A34C00EA89DF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (586, 1, 2, 3, CAST(0x0000A34C00EAB7AF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (587, 1, 2, 3, CAST(0x0000A34C00EAEB62 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (588, 1, 2, 3, CAST(0x0000A34C00EAF757 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (589, 1, 2, 3, CAST(0x0000A34C00EAFD23 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (590, 1, 2, 3, CAST(0x0000A34C00EB0D84 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (591, 1, 2, 3, CAST(0x0000A34C00EB14E2 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (592, 1, 2, 3, CAST(0x0000A34C00EB204F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (593, 1, 2, 3, CAST(0x0000A34C00EB26FB AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (594, 1, 2, 3, CAST(0x0000A34C00EC155A AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (595, 1, 2, 3, CAST(0x0000A34C00EC1AC4 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (596, 1, 2, 3, CAST(0x0000A34C00EC2D78 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (597, 1, 2, 3, CAST(0x0000A34C00EC47FE AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (598, 1, 2, 3, CAST(0x0000A34C00EC5038 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (599, 1, 2, 3, CAST(0x0000A34C00EC78BB AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
GO
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (600, 1, 2, 3, CAST(0x0000A34C00ED1CB9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (601, 1, 2, 3, CAST(0x0000A34C00EE44CA AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (602, 1, 2, 3, CAST(0x0000A34C00EE6B85 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (603, 1, 2, 3, CAST(0x0000A34C00EE6F39 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (604, 1, 2, 3, CAST(0x0000A34C00EEB406 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (605, 1, 2, 3, CAST(0x0000A34C00EEB7D6 AS DateTime), CAST(140616 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (606, 1, 1, 1, CAST(0x0000A34C00EECD08 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (607, 1, 2, 3, CAST(0x0000A34C00EED235 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (608, 1, 2, 3, CAST(0x0000A34C00EF326F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (609, 1, 4, 5, CAST(0x0000A34C00EF67A4 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (610, 1, 4, 5, CAST(0x0000A34C00EFD7ED AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (611, 1, 5, 6, CAST(0x0000A34C00EFDCB8 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (612, 1, 4, 5, CAST(0x0000A34C00EFE28A AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (613, 1, 4, 5, CAST(0x0000A34C00EFE766 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (614, 1, 4, 5, CAST(0x0000A34C00EFE99D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (615, 1, 5, 6, CAST(0x0000A34C00EFF039 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (616, 1, 5, 6, CAST(0x0000A34C00EFF126 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (617, 1, 5, 6, CAST(0x0000A34C00EFF1E7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (618, 1, 5, 6, CAST(0x0000A34C00EFF2EF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (619, 1, 5, 6, CAST(0x0000A34C00EFF465 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (620, 1, 4, 5, CAST(0x0000A34C00EFF85A AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (621, 1, 4, 5, CAST(0x0000A34C00F00066 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (622, 1, 4, 5, CAST(0x0000A34C00F003F7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (623, 1, 4, 5, CAST(0x0000A34C00F005BF AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (624, 1, 4, 5, CAST(0x0000A34C00F01A1F AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (625, 1, 4, 5, CAST(0x0000A34C00F01B69 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (626, 1, 4, 5, CAST(0x0000A34C00F01F23 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (627, 1, 4, 5, CAST(0x0000A34C00F02063 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (628, 1, 4, 5, CAST(0x0000A34C00F02172 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (629, 1, 4, 5, CAST(0x0000A34C00F023E0 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (630, 1, 4, 5, CAST(0x0000A34C00F02550 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (631, 1, 4, 5, CAST(0x0000A34C00F02674 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (632, 1, 4, 5, CAST(0x0000A34C00F0270B AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (633, 1, 4, 5, CAST(0x0000A34C00F0290C AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (634, 1, 4, 5, CAST(0x0000A34C00F0D3D7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (635, 1, 4, 5, CAST(0x0000A34C00F15631 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (636, 1, 4, 5, CAST(0x0000A34C00F19059 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (637, 1, 4, 5, CAST(0x0000A34C00F199B1 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (638, 1, 5, 6, CAST(0x0000A34C00F19FD8 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (639, 1, 1, 1, CAST(0x0000A34C00F1A63D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (640, 1, 4, 5, CAST(0x0000A34C00F1B0BC AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (641, 1, 4, 5, CAST(0x0000A34C00F20249 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (642, 1, 4, 5, CAST(0x0000A34C00F20FFB AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (643, 1, 4, 5, CAST(0x0000A34C00F212E7 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (644, 1, 4, 5, CAST(0x0000A34C00F216A5 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (645, 1, 4, 5, CAST(0x0000A34C00F219A9 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (646, 1, 4, 5, CAST(0x0000A34C00F21BEE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (647, 1, 4, 5, CAST(0x0000A34C00F21F19 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (648, 1, 4, 5, CAST(0x0000A34C00F22308 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (649, 1, 4, 5, CAST(0x0000A34C00F22674 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (650, 1, 4, 5, CAST(0x0000A34C00F22912 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (651, 1, 5, 6, CAST(0x0000A34C00F22E85 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (652, 1, 5, 6, CAST(0x0000A34C00F2310E AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (653, 1, 5, 6, CAST(0x0000A34C00F233DB AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (654, 1, 4, 5, CAST(0x0000A34C00F23CF3 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (655, 1, 4, 5, CAST(0x0000A34C00F23F41 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (656, 1, 4, 5, CAST(0x0000A34C00F241ED AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (657, 1, 4, 5, CAST(0x0000A34C00F244B8 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (658, 1, 4, 5, CAST(0x0000A34C00F24853 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (659, 1, 4, 5, CAST(0x0000A34C00F24B82 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (660, 1, 4, 5, CAST(0x0000A34C00F24EDE AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (661, 1, 4, 5, CAST(0x0000A34C00F2510D AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (662, 1, 4, 5, CAST(0x0000A34C00F25361 AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (663, 1, 4, 5, CAST(0x0000A34C00F26BEB AS DateTime), CAST(140616 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (664, 1, 5, 6, CAST(0x0000A34E009343DE AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (665, 1, 5, 6, CAST(0x0000A34E00934731 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (666, 1, 5, 6, CAST(0x0000A34E00934963 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (667, 1, 5, 6, CAST(0x0000A34E009350F9 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (668, 1, 5, 6, CAST(0x0000A34E0093573F AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (669, 1, 5, 6, CAST(0x0000A34E0093592F AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (670, 1, 5, 6, CAST(0x0000A34E00935ACB AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (671, 1, 5, 6, CAST(0x0000A34E00935CDC AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (672, 1, 5, 6, CAST(0x0000A34E00935DE3 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (673, 1, 5, 6, CAST(0x0000A34E00936157 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (674, 1, 5, 6, CAST(0x0000A34E00936416 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (675, 1, 5, 6, CAST(0x0000A34E0093677C AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (676, 1, 2, 3, CAST(0x0000A34E00937A8A AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (677, 1, 2, 3, CAST(0x0000A34E0093862C AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (678, 1, 2, 3, CAST(0x0000A34E00938A32 AS DateTime), CAST(140618 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (679, 1, 2, 3, CAST(0x0000A34E00939420 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (680, 1, 2, 3, CAST(0x0000A34E009399A1 AS DateTime), CAST(140618 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (681, 1, 2, 3, CAST(0x0000A34E0093A386 AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (682, 1, 2, 3, CAST(0x0000A34E0093A8AF AS DateTime), CAST(140618 AS Numeric(6, 0)), 3)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (683, 1, 2, 3, CAST(0x0000A34E0096EEEF AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (684, 1, 4, 5, CAST(0x0000A34E0097B8AF AS DateTime), CAST(140618 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (685, 1, 1, 1, CAST(0x0000A3500104C5F7 AS DateTime), CAST(140620 AS Numeric(6, 0)), 2)
INSERT [cms].[ActionLogs] ([ActionLogId], [UserId], [PagePermissionId], [ActionLogControlId], [ActionLogDate], [ActionLogDateMMS], [UserActionId]) VALUES (686, 1, 2, 3, CAST(0x0000A3500104CE5F AS DateTime), CAST(140620 AS Numeric(6, 0)), 2)
SET IDENTITY_INSERT [cms].[ActionLogs] OFF
SET IDENTITY_INSERT [cms].[Entities] ON 

INSERT [cms].[Entities] ([EntityId], [FirstName], [LastName], [CreationDate], [CreationDateMMS], [ModificationDate], [ModificationDateMMS], [IsActive]) VALUES (1, N'Elie', N'Ayoub', CAST(0x0000A34900D022A6 AS DateTime), CAST(140613 AS Numeric(6, 0)), CAST(0x0000A34500000000 AS DateTime), CAST(140609 AS Numeric(6, 0)), 1)
INSERT [cms].[Entities] ([EntityId], [FirstName], [LastName], [CreationDate], [CreationDateMMS], [ModificationDate], [ModificationDateMMS], [IsActive]) VALUES (2, N't', N't', CAST(0x0000A34800D24D18 AS DateTime), CAST(140612 AS Numeric(6, 0)), NULL, NULL, 1)
INSERT [cms].[Entities] ([EntityId], [FirstName], [LastName], [CreationDate], [CreationDateMMS], [ModificationDate], [ModificationDateMMS], [IsActive]) VALUES (3, N'a', N'a', CAST(0x0000A34800F48F9D AS DateTime), CAST(140612 AS Numeric(6, 0)), NULL, NULL, 0)
INSERT [cms].[Entities] ([EntityId], [FirstName], [LastName], [CreationDate], [CreationDateMMS], [ModificationDate], [ModificationDateMMS], [IsActive]) VALUES (4, N'a2', N'a', CAST(0x0000A34800F50E9F AS DateTime), CAST(140612 AS Numeric(6, 0)), NULL, NULL, 0)
INSERT [cms].[Entities] ([EntityId], [FirstName], [LastName], [CreationDate], [CreationDateMMS], [ModificationDate], [ModificationDateMMS], [IsActive]) VALUES (5, N't', N't', CAST(0x0000A34800FF0509 AS DateTime), CAST(140612 AS Numeric(6, 0)), NULL, NULL, 1)
INSERT [cms].[Entities] ([EntityId], [FirstName], [LastName], [CreationDate], [CreationDateMMS], [ModificationDate], [ModificationDateMMS], [IsActive]) VALUES (6, N't', N't', CAST(0x0000A34800FF23EB AS DateTime), CAST(140612 AS Numeric(6, 0)), NULL, NULL, 1)
SET IDENTITY_INSERT [cms].[Entities] OFF
SET IDENTITY_INSERT [cms].[ErrorLogs] ON 

INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (1, 1, CAST(0x0000A34500AE4CFA AS DateTime), CAST(140609 AS Numeric(6, 0)), N'DataBinding: ''Model.v_GetMenuByUser'' does not contain a property with the name ''PermissionTitle''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_core_buckets_adminheader_ascx.__DataBind__control3(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\core\buckets\AdminHeader.ascx:line 35
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.AdminHeader.BuildMenu() in D:\Work\Projects\ABC CMS\Web\Admin\Core\buckets\AdminHeader.ascx.vb:line 38', N'', N'System.Web', 0, NULL)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (2, 1, CAST(0x0000A34500B0A347 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'DataBinding: ''Model.v_GetMenuByUser'' does not contain a property with the name ''PermissionTitle''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_core_buckets_adminheader_ascx.__DataBind__control3(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\core\buckets\AdminHeader.ascx:line 36
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.AdminHeader.BuildMenu() in D:\Work\Projects\ABC CMS\Web\Admin\Core\buckets\AdminHeader.ascx.vb:line 38', N'', N'System.Web', 0, NULL)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (3, 1, CAST(0x0000A34500BF7C6C AS DateTime), CAST(140609 AS Numeric(6, 0)), N'DataBinding: ''Model.v_GetMenuByUser'' does not contain a property with the name ''PermissionDescription''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_core_buckets_adminheader_ascx.__DataBind__control7(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\core\buckets\AdminHeader.ascx:line 37
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.AdminHeader.rptMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Core\buckets\AdminHeader.ascx.vb:line 45', N'', N'System.Web', 0, NULL)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (4, 1, CAST(0x0000A34500C210E1 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Multiple controls with the same ID ''AdminHeader'' were found. FindControl requires that controls have unique IDs.', N'   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FindControl(String id, Int32 pathOffset)
   at System.Web.UI.Control.FindControl(String id)
   at Business.Operations.PageAssembler.LoadMasterPageBuckets(MasterPage Master, String BucketName, String PageControlName)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 19', N'', N'System.Web', 0, NULL)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (5, 1, CAST(0x0000A34500C2223A AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Multiple controls with the same ID ''AdminHeader'' were found. FindControl requires that controls have unique IDs.', N'   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FindControl(String id, Int32 pathOffset)
   at System.Web.UI.Control.FindControl(String id)
   at Business.Operations.PageAssembler.LoadMasterPageBuckets(MasterPage Master, String BucketName, String PageControlName)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 19', N'', N'System.Web', 0, NULL)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (6, 1, CAST(0x0000A34500C26A08 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Multiple controls with the same ID ''AdminHeader'' were found. FindControl requires that controls have unique IDs.', N'   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FillNamedControlsTable(Control namingContainer, ControlCollection controls)
   at System.Web.UI.Control.FindControl(String id, Int32 pathOffset)
   at System.Web.UI.Control.FindControl(String id)
   at Business.Operations.PageAssembler.LoadMasterPageBuckets(MasterPage Master, String BucketName, String PageControlName)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 19', N'', N'System.Web', 0, NULL)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (7, 1, CAST(0x0000A34500D6F980 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 142
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (8, 1, CAST(0x0000A34500D71366 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 142
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (9, 0, CAST(0x0000A34500D9BB2E AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 142
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (10, 0, CAST(0x0000A34500D9C882 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 142
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (11, 1, CAST(0x0000A34500E195B8 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (12, 1, CAST(0x0000A34500E1C0BE AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (13, 1, CAST(0x0000A34500E479A1 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 130
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (14, 1, CAST(0x0000A34500E5D4FC AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (15, 1, CAST(0x0000A34500E608BE AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (16, 1, CAST(0x0000A34500E65E8E AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (17, 1, CAST(0x0000A34500E68A6D AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 132
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (18, 1, CAST(0x0000A34500E6958F AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 132
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (19, 1, CAST(0x0000A34500E6C778 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Users.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 132
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 23', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (20, 1, CAST(0x0000A34500E82EFB AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (21, 1, CAST(0x0000A34500E8817A AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (22, 1, CAST(0x0000A34500E9BF86 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (23, 1, CAST(0x0000A34500EE5BE8 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Length of the data to decrypt is invalid.', N'   at System.Security.Cryptography.CryptoAPITransform.TransformFinalBlock(Byte[] inputBuffer, Int32 inputOffset, Int32 inputCount)
   at System.Security.Cryptography.CryptoStream.FlushFinalBlock()
   at CommonLibrary.Simple3Des.DecryptData(String encryptedtext)
   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 96', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (24, 1, CAST(0x0000A34500EF9633 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Sequence contains no elements', N'   at System.Linq.Enumerable.Single[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__3[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.Single[TSource](IQueryable`1 source)
   at Web.Users.UpdateUser(Int32 SelectedUserId, Int32 SelectedUserEntityIdToUpdate) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 194
   at Web.Users.btnUpdate_Click(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 59', N'', N'System.Core', 1, 3)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (25, 1, CAST(0x0000A34500EFDCD4 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Sequence contains no elements', N'   at System.Linq.Enumerable.Single[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__3[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.Single[TSource](IQueryable`1 source)
   at Web.Users.UpdateUser(Int32 SelectedUserId, Int32 SelectedUserEntityIdToUpdate) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 194
   at Web.Users.btnUpdate_Click(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 59', N'', N'System.Core', 1, 3)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (26, 1, CAST(0x0000A34500EFFFD6 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Sequence contains no elements', N'   at System.Linq.Enumerable.Single[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__3[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.Single[TSource](IQueryable`1 source)
   at Web.Users.UpdateUser(Int32 SelectedUserId, Int32 SelectedUserEntityIdToUpdate) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 194
   at Web.Users.btnUpdate_Click(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 59', N'', N'System.Core', 1, 3)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (27, 1, CAST(0x0000A34500F0B2A7 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Unable to cast object of type ''System.Int64'' to type ''System.Web.UI.WebControls.HiddenField''.', N'   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 89', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (28, 1, CAST(0x0000A345010D5181 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Unable to cast object of type ''System.Web.UI.WebControls.ListItem'' to type ''System.Web.UI.WebControls.CheckBox''.', N'   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 124', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (29, 1, CAST(0x0000A345010DA1A9 AS DateTime), CAST(140609 AS Numeric(6, 0)), N'Unable to cast object of type ''System.Web.UI.WebControls.ListItem'' to type ''System.Web.UI.WebControls.ListBox''.', N'   at Web.Users.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 124', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (30, 1, CAST(0x0000A34600BE8045 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 106', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (31, 1, CAST(0x0000A34601014D97 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 108', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (32, 1, CAST(0x0000A3460104FB63 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'DataBinding: ''Model.PermissionsControl'' does not contain a property with the name ''UserActionName''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_roles_aspx.__DataBinding__control14(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx:line 108
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.PerformSelect()
   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.Roles.rptFrontEndMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 152', N'', N'System.Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (33, 1, CAST(0x0000A3460104FB6E AS DateTime), CAST(140610 AS Numeric(6, 0)), N'DataBinding: ''Model.PermissionsControl'' does not contain a property with the name ''UserActionName''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_roles_aspx.__DataBinding__control14(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx:line 108
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.PerformSelect()
   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.Roles.rptFrontEndMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 152', N'', N'System.Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (34, 1, CAST(0x0000A34601050870 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'DataBinding: ''Model.PermissionsControl'' does not contain a property with the name ''UserActionName''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_roles_aspx.__DataBinding__control14(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx:line 108
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.PerformSelect()
   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.Roles.rptFrontEndMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 152', N'', N'System.Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (35, 1, CAST(0x0000A34601050874 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'DataBinding: ''Model.PermissionsControl'' does not contain a property with the name ''UserActionName''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_roles_aspx.__DataBinding__control14(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx:line 108
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.PerformSelect()
   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.Roles.rptFrontEndMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 152', N'', N'System.Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (36, 0, CAST(0x0000A3460106F975 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'DataBinding: ''Model.PermissionsControl'' does not contain a property with the name ''UserActionName''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_roles_aspx.__DataBinding__control14(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx:line 108
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.PerformSelect()
   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.Roles.rptFrontEndMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 155', N'', N'System.Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (37, 0, CAST(0x0000A3460106F980 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'DataBinding: ''Model.PermissionsControl'' does not contain a property with the name ''UserActionName''.', N'   at System.Web.UI.DataBinder.GetPropertyValue(Object container, String propName)
   at System.Web.UI.DataBinder.Eval(Object container, String[] expressionParts)
   at System.Web.UI.DataBinder.Eval(Object container, String expression)
   at System.Web.UI.TemplateControl.Eval(String expression)
   at ASP.admin_roles_aspx.__DataBinding__control14(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx:line 108
   at System.Web.UI.Control.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.ListControl.PerformSelect()
   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
   at System.Web.UI.Control.DataBindChildren()
   at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding)
   at System.Web.UI.Control.DataBind()
   at System.Web.UI.WebControls.Repeater.CreateItem(Int32 itemIndex, ListItemType itemType, Boolean dataBind, Object dataItem)
   at System.Web.UI.WebControls.Repeater.CreateControlHierarchy(Boolean useDataSource)
   at System.Web.UI.WebControls.Repeater.OnDataBinding(EventArgs e)
   at System.Web.UI.WebControls.Repeater.DataBind()
   at Web.Roles.rptFrontEndMenu_ItemDataBound(Object sender, RepeaterItemEventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 155', N'', N'System.Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (38, 1, CAST(0x0000A3460113B5A6 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 108', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (39, 1, CAST(0x0000A3460113F21B AS DateTime), CAST(140610 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 108', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (40, 1, CAST(0x0000A34601141662 AS DateTime), CAST(140610 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 108', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (41, 1, CAST(0x0000A3470094ADB2 AS DateTime), CAST(140611 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 223
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 22', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (42, 0, CAST(0x0000A3470094E268 AS DateTime), CAST(140611 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.Roles.ClearFields() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 223
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 22', N'', N'Web', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (43, 1, CAST(0x0000A34700C026FC AS DateTime), CAST(140611 AS Numeric(6, 0)), N'Unable to cast object of type ''System.Web.UI.WebControls.ListItem'' to type ''System.Web.UI.WebControls.CheckBox''.', N'   at Web.Roles.InsertRole() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 274
   at Web.Roles.btnInsert_Click(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 56', N'', N'Web', 1, 1)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (44, 1, CAST(0x0000A34700D9515B AS DateTime), CAST(140611 AS Numeric(6, 0)), N'Nullable object must have a value.', N'   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Nullable`1.op_Explicit(Nullable`1 value)
   at Web.Roles.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 144', N'', N'mscorlib', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (45, 1, CAST(0x0000A3470107C005 AS DateTime), CAST(140611 AS Numeric(6, 0)), N'An entity object cannot be referenced by multiple instances of IEntityChangeTracker.', N'   at System.Data.Objects.ObjectContext.VerifyContextForAddOrAttach(IEntityWrapper wrappedEntity)
   at System.Data.Objects.ObjectContext.AddSingleObject(EntitySet entitySet, IEntityWrapper wrappedEntity, String argumentName)
   at System.Data.Objects.ObjectContext.AddObject(String entitySetName, Object entity)
   at Model.ABC_CMSApplicationEntities.AddToRoles(Role role)
   at Business.Roles.UpdateRole(Int32 RoleIdToUpdate, String EditRoleName, String EditRoleDescription, Boolean EditRoleIsActive, List`1 EditRolePermissionsActions)', N'', N'System.Data.Entity', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (46, 1, CAST(0x0000A3470107DB5C AS DateTime), CAST(140611 AS Numeric(6, 0)), N'An entity object cannot be referenced by multiple instances of IEntityChangeTracker.', N'   at System.Data.Objects.ObjectContext.VerifyContextForAddOrAttach(IEntityWrapper wrappedEntity)
   at System.Data.Objects.ObjectContext.AddSingleObject(EntitySet entitySet, IEntityWrapper wrappedEntity, String argumentName)
   at System.Data.Objects.ObjectContext.AddObject(String entitySetName, Object entity)
   at Model.ABC_CMSApplicationEntities.AddToRoles(Role role)
   at Business.Roles.UpdateRole(Int32 RoleIdToUpdate, String EditRoleName, String EditRoleDescription, Boolean EditRoleIsActive, List`1 EditRolePermissionsActions)', N'', N'System.Data.Entity', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (47, 0, CAST(0x0000A34800DBE431 AS DateTime), CAST(140612 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Users.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 155
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 29', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (48, 0, CAST(0x0000A34801023568 AS DateTime), CAST(140612 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Users.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 157
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 31', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (49, 0, CAST(0x0000A34801025D91 AS DateTime), CAST(140612 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Users.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 157
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 31', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (50, 0, CAST(0x0000A3480102A454 AS DateTime), CAST(140612 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Users.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 157
   at Web.Users.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Users.aspx.vb:line 31', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (51, 0, CAST(0x0000A34900A4C69A AS DateTime), CAST(140613 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 232
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 26', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (52, 0, CAST(0x0000A34900A5847A AS DateTime), CAST(140613 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 232
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 26', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (53, 1, CAST(0x0000A34900CC70E3 AS DateTime), CAST(140613 AS Numeric(6, 0)), N'The object cannot be deleted because it was not found in the ObjectStateManager.', N'   at System.Data.Objects.ObjectContext.DeleteObject(Object entity, EntitySet expectedEntitySet)
   at System.Data.Objects.ObjectSet`1.DeleteObject(TEntity entity)
   at Data.RolesRepository.DeleteUserRolesData(Int32 SelectedUserId)', N'', N'System.Data.Entity', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (54, 0, CAST(0x0000A34900CFB5FA AS DateTime), CAST(140613 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 234
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 28', N'', N'Business', 1, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (55, 1, CAST(0x0000A34900D0150E AS DateTime), CAST(140613 AS Numeric(6, 0)), N'The object cannot be deleted because it was not found in the ObjectStateManager.', N'   at System.Data.Objects.ObjectContext.DeleteObject(Object entity, EntitySet expectedEntitySet)
   at System.Data.Objects.ObjectSet`1.DeleteObject(TEntity entity)
   at Data.RolesRepository.DeleteUserRolesData(Int32 SelectedUserId)', N'', N'System.Data.Entity', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (56, 1, CAST(0x0000A34900D022AB AS DateTime), CAST(140613 AS Numeric(6, 0)), N'The object cannot be deleted because it was not found in the ObjectStateManager.', N'   at System.Data.Objects.ObjectContext.DeleteObject(Object entity, EntitySet expectedEntitySet)
   at System.Data.Objects.ObjectSet`1.DeleteObject(TEntity entity)
   at Data.RolesRepository.DeleteUserRolesData(Int32 SelectedUserId)', N'', N'System.Data.Entity', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (57, 0, CAST(0x0000A34900FD6391 AS DateTime), CAST(140613 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 234
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 28', N'', N'Business', 3, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (58, 1, CAST(0x0000A34C00B8C667 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.ErrorLogs.ClearMessageFields() in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 93
   at Web.ErrorLogs.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 12', N'', N'Web', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (59, 1, CAST(0x0000A34C00B8CAD3 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.ErrorLogs.ClearMessageFields() in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 93
   at Web.ErrorLogs.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 12', N'', N'Web', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (60, 1, CAST(0x0000A34C00B8CCD6 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Web.ErrorLogs.ClearMessageFields() in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 93
   at Web.ErrorLogs.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 12', N'', N'Web', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (61, 1, CAST(0x0000A34C00C51317 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'String was not recognized as a valid DateTime.', N'   at System.DateTimeParse.Parse(String s, DateTimeFormatInfo dtfi, DateTimeStyles styles)
   at System.Convert.ToDateTime(String value)
   at Web.ErrorLogs.BindSearchUsersInformations() in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 110', N'', N'mscorlib', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (62, 1, CAST(0x0000A34C00C55915 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'String was not recognized as a valid DateTime.', N'   at System.DateTimeParse.Parse(String s, DateTimeFormatInfo dtfi, DateTimeStyles styles)
   at System.Convert.ToDateTime(String value)
   at Web.ErrorLogs.BindSearchUsersInformations() in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 110', N'', N'mscorlib', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (63, 1, CAST(0x0000A34C00C96502 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'The value of a property that is part of an object''s key does not match the corresponding property value stored in the ObjectContext.  This can occur if properties that are part of the key return inconsistent or incorrect values or if DetectChanges is not called after changes are made to a property that is part of the key.', N'   at System.Data.Objects.ObjectStateManager.CheckKeyMatchesEntity(IEntityWrapper wrappedEntity, EntityKey entityKey, EntitySet entitySetForType, Boolean forAttach)
   at System.Data.Objects.ObjectStateManager.AddEntry(IEntityWrapper wrappedObject, EntityKey passedKey, EntitySet entitySet, String argumentName, Boolean isAdded)
   at System.Data.Common.Internal.Materialization.Shaper.HandleEntityAppendOnly[TEntity](Func`2 constructEntityDelegate, EntityKey entityKey, EntitySet entitySet)
   at lambda_method(Closure , Shaper )
   at System.Data.Common.Internal.Materialization.Coordinator`1.ReadNextElement(Shaper shaper)
   at System.Data.Common.Internal.Materialization.Shaper`1.SimpleEnumerator.MoveNext()
   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__1[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at Business.ErrorLogs.GetErrorLogDataById(Int32 SelectedErrorLogId)
   at Web.ErrorLogs.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 49', N'', N'System.Data.Entity', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (64, 1, CAST(0x0000A34C00CB2547 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'The value of a property that is part of an object''s key does not match the corresponding property value stored in the ObjectContext.  This can occur if properties that are part of the key return inconsistent or incorrect values or if DetectChanges is not called after changes are made to a property that is part of the key.', N'   at System.Data.Objects.ObjectStateManager.CheckKeyMatchesEntity(IEntityWrapper wrappedEntity, EntityKey entityKey, EntitySet entitySetForType, Boolean forAttach)
   at System.Data.Objects.ObjectStateManager.AddEntry(IEntityWrapper wrappedObject, EntityKey passedKey, EntitySet entitySet, String argumentName, Boolean isAdded)
   at System.Data.Common.Internal.Materialization.Shaper.HandleEntityAppendOnly[TEntity](Func`2 constructEntityDelegate, EntityKey entityKey, EntitySet entitySet)
   at lambda_method(Closure , Shaper )
   at System.Data.Common.Internal.Materialization.Coordinator`1.ReadNextElement(Shaper shaper)
   at System.Data.Common.Internal.Materialization.Shaper`1.SimpleEnumerator.MoveNext()
   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__1[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at Business.ErrorLogs.GetErrorLogDataById(Int32 SelectedErrorLogId)
   at Web.ErrorLogs.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 49', N'', N'System.Data.Entity', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (65, 1, CAST(0x0000A34C00CB6409 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'The value of a property that is part of an object''s key does not match the corresponding property value stored in the ObjectContext.  This can occur if properties that are part of the key return inconsistent or incorrect values or if DetectChanges is not called after changes are made to a property that is part of the key.', N'   at System.Data.Objects.ObjectStateManager.CheckKeyMatchesEntity(IEntityWrapper wrappedEntity, EntityKey entityKey, EntitySet entitySetForType, Boolean forAttach)
   at System.Data.Objects.ObjectStateManager.AddEntry(IEntityWrapper wrappedObject, EntityKey passedKey, EntitySet entitySet, String argumentName, Boolean isAdded)
   at System.Data.Common.Internal.Materialization.Shaper.HandleEntityAppendOnly[TEntity](Func`2 constructEntityDelegate, EntityKey entityKey, EntitySet entitySet)
   at lambda_method(Closure , Shaper )
   at System.Data.Common.Internal.Materialization.Coordinator`1.ReadNextElement(Shaper shaper)
   at System.Data.Common.Internal.Materialization.Shaper`1.SimpleEnumerator.MoveNext()
   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__1[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at Business.ErrorLogs.GetErrorLogDataById(Int32 SelectedErrorLogId)
   at Web.ErrorLogs.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 49', N'', N'System.Data.Entity', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (66, 1, CAST(0x0000A34C00CBB678 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'The value of a property that is part of an object''s key does not match the corresponding property value stored in the ObjectContext.  This can occur if properties that are part of the key return inconsistent or incorrect values or if DetectChanges is not called after changes are made to a property that is part of the key.', N'   at System.Data.Objects.ObjectStateManager.CheckKeyMatchesEntity(IEntityWrapper wrappedEntity, EntityKey entityKey, EntitySet entitySetForType, Boolean forAttach)
   at System.Data.Objects.ObjectStateManager.AddEntry(IEntityWrapper wrappedObject, EntityKey passedKey, EntitySet entitySet, String argumentName, Boolean isAdded)
   at System.Data.Common.Internal.Materialization.Shaper.HandleEntityAppendOnly[TEntity](Func`2 constructEntityDelegate, EntityKey entityKey, EntitySet entitySet)
   at lambda_method(Closure , Shaper )
   at System.Data.Common.Internal.Materialization.Coordinator`1.ReadNextElement(Shaper shaper)
   at System.Data.Common.Internal.Materialization.Shaper`1.SimpleEnumerator.MoveNext()
   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__1[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at Business.ErrorLogs.GetErrorLogDataById(Int32 SelectedErrorLogId)
   at Web.ErrorLogs.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 49', N'', N'System.Data.Entity', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (67, 1, CAST(0x0000A34C00CBB712 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'The value of a property that is part of an object''s key does not match the corresponding property value stored in the ObjectContext.  This can occur if properties that are part of the key return inconsistent or incorrect values or if DetectChanges is not called after changes are made to a property that is part of the key.', N'   at System.Data.Objects.ObjectStateManager.CheckKeyMatchesEntity(IEntityWrapper wrappedEntity, EntityKey entityKey, EntitySet entitySetForType, Boolean forAttach)
   at System.Data.Objects.ObjectStateManager.AddEntry(IEntityWrapper wrappedObject, EntityKey passedKey, EntitySet entitySet, String argumentName, Boolean isAdded)
   at System.Data.Common.Internal.Materialization.Shaper.HandleEntityAppendOnly[TEntity](Func`2 constructEntityDelegate, EntityKey entityKey, EntitySet entitySet)
   at lambda_method(Closure , Shaper )
   at System.Data.Common.Internal.Materialization.Coordinator`1.ReadNextElement(Shaper shaper)
   at System.Data.Common.Internal.Materialization.Shaper`1.SimpleEnumerator.MoveNext()
   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__1[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at Business.ErrorLogs.GetErrorLogDataById(Int32 SelectedErrorLogId)
   at Web.ErrorLogs.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 49', N'', N'System.Data.Entity', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (68, 1, CAST(0x0000A34C00CBB7F4 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'The value of a property that is part of an object''s key does not match the corresponding property value stored in the ObjectContext.  This can occur if properties that are part of the key return inconsistent or incorrect values or if DetectChanges is not called after changes are made to a property that is part of the key.', N'   at System.Data.Objects.ObjectStateManager.CheckKeyMatchesEntity(IEntityWrapper wrappedEntity, EntityKey entityKey, EntitySet entitySetForType, Boolean forAttach)
   at System.Data.Objects.ObjectStateManager.AddEntry(IEntityWrapper wrappedObject, EntityKey passedKey, EntitySet entitySet, String argumentName, Boolean isAdded)
   at System.Data.Common.Internal.Materialization.Shaper.HandleEntityAppendOnly[TEntity](Func`2 constructEntityDelegate, EntityKey entityKey, EntitySet entitySet)
   at lambda_method(Closure , Shaper )
   at System.Data.Common.Internal.Materialization.Coordinator`1.ReadNextElement(Shaper shaper)
   at System.Data.Common.Internal.Materialization.Shaper`1.SimpleEnumerator.MoveNext()
   at System.Linq.Enumerable.FirstOrDefault[TSource](IEnumerable`1 source)
   at System.Data.Objects.ELinq.ObjectQueryProvider.<GetElementFunction>b__1[TResult](IEnumerable`1 sequence)
   at System.Data.Objects.ELinq.ObjectQueryProvider.ExecuteSingle[TResult](IEnumerable`1 query, Expression queryRoot)
   at System.Data.Objects.ELinq.ObjectQueryProvider.System.Linq.IQueryProvider.Execute[S](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at Business.ErrorLogs.GetErrorLogDataById(Int32 SelectedErrorLogId)
   at Web.ErrorLogs.gvSearch_SelectedIndexChanged(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\ErrorLogs.aspx.vb:line 49', N'', N'System.Data.Entity', 5, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (69, 0, CAST(0x0000A34C01156475 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (70, 0, CAST(0x0000A34C0115F850 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (71, 0, CAST(0x0000A34C0116430E AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (72, 0, CAST(0x0000A34C0117113F AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (73, 0, CAST(0x0000A34C011725B4 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 242
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 28', N'', N'Business', 3, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (74, 0, CAST(0x0000A34C011725C7 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (75, 0, CAST(0x0000A34C011982A3 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (76, 0, CAST(0x0000A34C011AD694 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (77, 0, CAST(0x0000A34C011AF5FD AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 242
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 28', N'', N'Business', 3, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (78, 0, CAST(0x0000A34C011AF605 AS DateTime), CAST(140616 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (79, 0, CAST(0x0000A34D009EE94E AS DateTime), CAST(140617 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (80, 0, CAST(0x0000A34D00C0F4CF AS DateTime), CAST(140617 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (81, 0, CAST(0x0000A34D00C2115B AS DateTime), CAST(140617 AS Numeric(6, 0)), N'Object reference not set to an instance of an object.', N'   at Business.Permissions.hasUserControlsPermissions(Int32 UserActionId, Int32 ControlId, Int32 UserId)
   at Web.Roles.CheckUserControlsPermissionsOnLoad() in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 242
   at Web.Roles.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Roles.aspx.vb:line 28', N'', N'Business', 3, 2)
INSERT [cms].[ErrorLogs] ([ErrorLogId], [UserId], [ErrorLogDate], [ErrorLogDateMMS], [Message], [StackTrace], [InnerException], [Source], [ErrorLogControlId], [UserActionId]) VALUES (82, 0, CAST(0x0000A34D00C21187 AS DateTime), CAST(140617 AS Numeric(6, 0)), N'Thread was being aborted.', N'   at System.Threading.Thread.AbortInternal()
   at System.Threading.Thread.Abort(Object stateInfo)
   at System.Web.HttpResponse.AbortCurrentThread()
   at System.Web.HttpResponse.End()
   at System.Web.HttpResponse.Redirect(String url, Boolean endResponse, Boolean permanent)
   at System.Web.HttpResponse.Redirect(String url)
   at Web.Admin.Page_Load(Object sender, EventArgs e) in D:\Work\Projects\ABC CMS\Web\Admin\Admin.Master.vb:line 11', N'', N'mscorlib', 0, 0)
SET IDENTITY_INSERT [cms].[ErrorLogs] OFF
SET IDENTITY_INSERT [cms].[Menus] ON 

INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 1, 1, 0, N'Home', NULL, N'Default.aspx', 3, 1)
INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (2, 1, 2, 0, N'Users Management', NULL, NULL, 0, 1)
INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (3, 1, 1, 2, N'Users', NULL, N'Users.aspx', 1, 1)
INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (4, 1, 2, 2, N'Roles', NULL, N'Roles.aspx', 2, 1)
INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (5, 1, 3, 0, N'Logs', NULL, NULL, 0, 1)
INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (6, 1, 1, 5, N'Error Logs', NULL, N'ErrorLogs.aspx', 4, 1)
INSERT [cms].[Menus] ([MenuId], [MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (7, 1, 2, 5, N'Action Logs', NULL, N'ActionLogs.aspx', 5, 1)
SET IDENTITY_INSERT [cms].[Menus] OFF
SET IDENTITY_INSERT [cms].[Pages] ON 

INSERT [cms].[Pages] ([PageId], [PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (1, N'Users', NULL, 1, 1)
INSERT [cms].[Pages] ([PageId], [PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (2, N'Roles', NULL, 1, 1)
INSERT [cms].[Pages] ([PageId], [PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (3, N'Home', N'Admin Homepage', 1, 1)
INSERT [cms].[Pages] ([PageId], [PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (4, N'ErrorLogs', NULL, 1, 1)
INSERT [cms].[Pages] ([PageId], [PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (5, N'ActionLogs', NULL, 1, 1)
SET IDENTITY_INSERT [cms].[Pages] OFF
SET IDENTITY_INSERT [cms].[PagesPermissions] ON 

INSERT [cms].[PagesPermissions] ([PagePermissionId], [PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (1, N'Users - Users Module', NULL, N'1', 1, 1, 1)
INSERT [cms].[PagesPermissions] ([PagePermissionId], [PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (2, N'Roles - Roles Module', NULL, N'2', 1, 1, 1)
INSERT [cms].[PagesPermissions] ([PagePermissionId], [PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (3, N'Home - Admin Homepage', NULL, N'3', 1, 1, 1)
INSERT [cms].[PagesPermissions] ([PagePermissionId], [PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (4, N'Logs - Error Logs', NULL, N'4', 1, 1, 1)
INSERT [cms].[PagesPermissions] ([PagePermissionId], [PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (5, N'logs - Action Logs', NULL, N'5', 1, 1, 1)
SET IDENTITY_INSERT [cms].[PagesPermissions] OFF
SET IDENTITY_INSERT [cms].[PermissionControlsTypes] ON 

INSERT [cms].[PermissionControlsTypes] ([PermissionControlsTypeId], [PermissionControlTypeName], [IsActive]) VALUES (1, N'Module', 1)
SET IDENTITY_INSERT [cms].[PermissionControlsTypes] OFF
SET IDENTITY_INSERT [cms].[PermissionsActions] ON 

INSERT [cms].[PermissionsActions] ([PermissionActionId], [PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (297, 1, 1, 1, 1, 1, 1, 1)
INSERT [cms].[PermissionsActions] ([PermissionActionId], [PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (298, 1, 2, 1, 1, 1, 1, 1)
INSERT [cms].[PermissionsActions] ([PermissionActionId], [PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (299, 2, 3, 1, 1, 1, 1, 1)
INSERT [cms].[PermissionsActions] ([PermissionActionId], [PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (300, 2, 4, 1, 1, 1, 1, 1)
INSERT [cms].[PermissionsActions] ([PermissionActionId], [PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (301, 4, 5, 1, 0, 1, 0, 0)
INSERT [cms].[PermissionsActions] ([PermissionActionId], [PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (302, 5, 6, 1, 0, 1, 0, 0)
SET IDENTITY_INSERT [cms].[PermissionsActions] OFF
SET IDENTITY_INSERT [cms].[PermissionsControls] ON 

INSERT [cms].[PermissionsControls] ([PermissionControlId], [PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (1, N'Admin_UsersPage', 1, 1, 1, 1)
INSERT [cms].[PermissionsControls] ([PermissionControlId], [PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (2, N'Admin_UsersPage_RolesModule', 1, 1, 1, 1)
INSERT [cms].[PermissionsControls] ([PermissionControlId], [PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (3, N'Admin_RolesPage', 1, 2, 2, 1)
INSERT [cms].[PermissionsControls] ([PermissionControlId], [PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (4, N'Admin_RolesPage_PermissionsModule', 1, 2, 2, 1)
INSERT [cms].[PermissionsControls] ([PermissionControlId], [PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (5, N'Admin_ErrorLogsPage', 1, 4, 4, 1)
INSERT [cms].[PermissionsControls] ([PermissionControlId], [PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (6, N'Admin_ActionsLogsPage', 1, 5, 5, 1)
SET IDENTITY_INSERT [cms].[PermissionsControls] OFF
SET IDENTITY_INSERT [cms].[PermissionsTypes] ON 

INSERT [cms].[PermissionsTypes] ([PermissionTypeId], [PermissionTypeName]) VALUES (1, N'Backend')
INSERT [cms].[PermissionsTypes] ([PermissionTypeId], [PermissionTypeName]) VALUES (2, N'Frontend')
SET IDENTITY_INSERT [cms].[PermissionsTypes] OFF
SET IDENTITY_INSERT [cms].[Roles] ON 

INSERT [cms].[Roles] ([RoleId], [RoleName], [RoleDescription], [IsActive]) VALUES (1, N'Administrator', N'test', 1)
SET IDENTITY_INSERT [cms].[Roles] OFF
SET IDENTITY_INSERT [cms].[RolesPermissions] ON 

INSERT [cms].[RolesPermissions] ([RolePermissionId], [RoleId], [PagePermissionId]) VALUES (163, 1, 1)
INSERT [cms].[RolesPermissions] ([RolePermissionId], [RoleId], [PagePermissionId]) VALUES (164, 1, 2)
INSERT [cms].[RolesPermissions] ([RolePermissionId], [RoleId], [PagePermissionId]) VALUES (165, 1, 4)
INSERT [cms].[RolesPermissions] ([RolePermissionId], [RoleId], [PagePermissionId]) VALUES (166, 1, 5)
SET IDENTITY_INSERT [cms].[RolesPermissions] OFF
SET IDENTITY_INSERT [cms].[Users] ON 

INSERT [cms].[Users] ([UserId], [Username], [Password], [Email], [EntityId], [IsActive], [ModificationDate], [ModificationDateMMS]) VALUES (1, N'eayoub', N'bI08s5gYig4=', N'eayoub@abc.com.lb', 1, 1, CAST(0x0000A34D00A06A4E AS DateTime), CAST(140617 AS Numeric(6, 0)))
INSERT [cms].[Users] ([UserId], [Username], [Password], [Email], [EntityId], [IsActive], [ModificationDate], [ModificationDateMMS]) VALUES (2, N't', N'uqxyv+MCKxU=', N'eayoub@abc.com.lb', 2, 1, NULL, NULL)
INSERT [cms].[Users] ([UserId], [Username], [Password], [Email], [EntityId], [IsActive], [ModificationDate], [ModificationDateMMS]) VALUES (3, N'a', N'WXvSK6mJQWQ=', N'eayoub@abc.com.lb', 3, 0, NULL, NULL)
INSERT [cms].[Users] ([UserId], [Username], [Password], [Email], [EntityId], [IsActive], [ModificationDate], [ModificationDateMMS]) VALUES (4, N'a', N'WXvSK6mJQWQ=', N'eayoub@abc.com.lb', 4, 0, NULL, NULL)
INSERT [cms].[Users] ([UserId], [Username], [Password], [Email], [EntityId], [IsActive], [ModificationDate], [ModificationDateMMS]) VALUES (5, N'tg', N'uqxyv+MCKxU=', N'eayoub@abc.com.lb', 5, 1, NULL, NULL)
INSERT [cms].[Users] ([UserId], [Username], [Password], [Email], [EntityId], [IsActive], [ModificationDate], [ModificationDateMMS]) VALUES (6, N'tg1', N'uqxyv+MCKxU=', N'eayoub@abc.com.lb', 6, 1, NULL, NULL)
SET IDENTITY_INSERT [cms].[Users] OFF
SET IDENTITY_INSERT [cms].[UsersActions] ON 

INSERT [cms].[UsersActions] ([UserActionId], [UserActionName]) VALUES (1, N'Create')
INSERT [cms].[UsersActions] ([UserActionId], [UserActionName]) VALUES (2, N'Read')
INSERT [cms].[UsersActions] ([UserActionId], [UserActionName]) VALUES (3, N'Update')
INSERT [cms].[UsersActions] ([UserActionId], [UserActionName]) VALUES (4, N'Delete')
SET IDENTITY_INSERT [cms].[UsersActions] OFF
SET IDENTITY_INSERT [cms].[UsersRoles] ON 

INSERT [cms].[UsersRoles] ([UserRoleId], [RoleId], [UserId]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [cms].[UsersRoles] OFF
ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Create]  DEFAULT ((0)) FOR [Create]
GO
ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Read]  DEFAULT ((0)) FOR [Read]
GO
ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Update]  DEFAULT ((0)) FOR [Update]
GO
ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Delete]  DEFAULT ((0)) FOR [Delete]
GO
USE [master]
GO
ALTER DATABASE [ABC_CMSApplication] SET  READ_WRITE 
GO
