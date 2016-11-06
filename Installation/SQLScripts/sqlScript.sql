DECLARE @SchemaName AS VARCHAR(100) = 'cms'
DECLARE @sql VARCHAR(100) = 'Create Schema '+ @SchemaName +' AUTHORIZATION [dbo]'

IF NOT EXISTS(SELECT name FROM sys.schemas WHERE name = @SchemaName)
BEGIN
	EXEC(@sql)
END
GO

CREATE TABLE [cms].[ActionLogs](
	[ActionLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[PagePermissionId] [bigint] NULL,
	[ActionLogControlId] [bigint] NULL,
	[ActionLogDate] [datetime] NULL,
	[ActionLogDateMMS] [numeric](6, 0) NULL,
	[UserActionId] [bigint] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_ActionLogs] PRIMARY KEY CLUSTERED 
(
	[ActionLogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [cms].[PermissionControlsTypes](
	[PermissionControlsTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionControlTypeName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PermissionControlsTypes] PRIMARY KEY CLUSTERED 
(
	[PermissionControlsTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Create]  DEFAULT ((0)) FOR [Create]
GO

ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Read]  DEFAULT ((0)) FOR [Read]
GO

ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Update]  DEFAULT ((0)) FOR [Update]
GO

ALTER TABLE [cms].[PermissionsActions] ADD  CONSTRAINT [DF_PermissionsActions_Delete]  DEFAULT ((0)) FOR [Delete]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [cms].[PermissionsTypes](
	[PermissionTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_PermissionsTypes] PRIMARY KEY CLUSTERED 
(
	[PermissionTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [cms].[Roles](
	[RoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[RoleDescription] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [cms].[RolesPermissions](
	[RolePermissionId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [bigint] NULL,
	[PagePermissionId] [bigint] NULL,
 CONSTRAINT [PK_RolesPermissions] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [cms].[UsersActions](
	[UserActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserActionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UsersActions] PRIMARY KEY CLUSTERED 
(
	[UserActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [cms].[UsersRoles](
	[UserRoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [bigint] NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_UsersRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE View [cms].[v_GetActionLogsInformation] AS
Select A.[ActionLogId],A.[UserId],A.[PagePermissionId],A.[ActionLogControlId],A.[ActionLogDate]
,A.[ActionLogDateMMS],A.[UserActionId], IsNull(U.Username, '') Username,
IsNull(P.PagePermissionName, '') PagePermissionName,
IsNull(C.PermissionControlName, '') PermissionControlName,
IsNull(UA.UserActionName, '') UserActionName,
IsNull(G.PageName, '') PageName,
IsNull(A.Description, '') Description,
G.PageId
From ActionLogs A 
Left Join Users U on U.UserId = A.UserId
Left Join PagesPermissions P on P.PagePermissionId = A.PagePermissionId
Left Join PermissionsControls C on C.PermissionControlId = A.ActionLogControlId
Left Join UsersActions UA on UA.UserActionId = A.UserActionId
Left Join Pages G On G.PageId = P.PagePermissionPageId
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

CREATE View [cms].[v_GetUsersInformations] As
Select U.Username, U.Password, U.Email, E.FirstName, E.LastName, U.IsActive, U.UserId, E.EntityId,
E.CreationDate, E.CreationDateMMS,E.ModificationDate, E.ModificationDateMMS
From Users U
Inner Join Entities E On E.EntityId = U.EntityId
GO

INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 1, 0, N'Home', NULL, N'Default.aspx', 3, 1)
GO
INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 2, 0, N'Users Management', NULL, NULL, 0, 1)
GO
INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 1, 2, N'Users', NULL, N'Users.aspx', 1, 1)
GO
INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 2, 2, N'Roles', NULL, N'Roles.aspx', 2, 1)
GO
INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 3, 0, N'Logs', NULL, NULL, 0, 1)
GO
INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 1, 5, N'Error Logs', NULL, N'ErrorLogs.aspx', 4, 1)
GO
INSERT [cms].[Menus] ([MenuPermissionTypeId], [MenuOrder], [MenuParentId], [MenuName], [MenuDescription], [MenuPath], [MenuPageId], [IsActive]) VALUES (1, 2, 5, N'Action Logs', NULL, N'ActionLogs.aspx', 5, 1)
GO

GO
INSERT [cms].[Pages] ([PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (N'Users', NULL, 1, 1)
GO
INSERT [cms].[Pages] ([PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (N'Roles', NULL, 1, 1)
GO
INSERT [cms].[Pages] ([PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (N'Home', N'Admin Homepage', 1, 1)
GO
INSERT [cms].[Pages] ([PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (N'ErrorLogs', NULL, 1, 1)
GO
INSERT [cms].[Pages] ([PageName], [PageDescription], [PagePermissionTypeId], [IsActive]) VALUES (N'ActionLogs', NULL, 1, 1)
GO

INSERT [cms].[PagesPermissions] ([PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (N'Users - Users Module', NULL, N'1', 1, 1, 1)
GO
INSERT [cms].[PagesPermissions] ([PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (N'Roles - Roles Module', NULL, N'2', 1, 1, 1)
GO
INSERT [cms].[PagesPermissions] ([PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (N'Home - Admin Homepage', NULL, N'3', 1, 1, 1)
GO
INSERT [cms].[PagesPermissions] ([PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (N'Logs - Error Logs', NULL, N'4', 1, 1, 1)
GO
INSERT [cms].[PagesPermissions] ([PagePermissionName], [PagePermissionDescription], [PagePermissionPageId], [PagePermissionTypeId], [IsEnabled], [IsActive]) VALUES (N'logs - Action Logs', NULL, N'5', 1, 1, 1)
GO

INSERT [cms].[PermissionControlsTypes] ([PermissionControlTypeName], [IsActive]) VALUES (N'Module', 1)
GO

INSERT [cms].[PermissionsActions] ([PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (1, 1, 1, 1, 1, 1, 1)
GO
INSERT [cms].[PermissionsActions] ([PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (1, 2, 1, 1, 1, 1, 1)
GO
INSERT [cms].[PermissionsActions] ([PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (2, 3, 1, 1, 1, 1, 1)
GO
INSERT [cms].[PermissionsActions] ([PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES ( 2, 4, 1, 1, 1, 1, 1)
GO
INSERT [cms].[PermissionsActions] ([PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (4, 5, 1, 0, 1, 0, 0)
GO
INSERT [cms].[PermissionsActions] ([PermissionActionPagePermissionId], [PermissionActionPermissionControlId], [PermissionActionRoleId], [Create], [Read], [Update], [Delete]) VALUES (5, 6, 1, 0, 1, 0, 0)
GO

INSERT [cms].[PermissionsControls] ([PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (N'Admin_UsersPage', 1, 1, 1, 1)
GO
INSERT [cms].[PermissionsControls] ([PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (N'Admin_UsersPage_RolesModule', 1, 1, 1, 1)
GO
INSERT [cms].[PermissionsControls] ([PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (N'Admin_RolesPage', 1, 2, 2, 1)
GO
INSERT [cms].[PermissionsControls] ([PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (N'Admin_RolesPage_PermissionsModule', 1, 2, 2, 1)
GO
INSERT [cms].[PermissionsControls] ([PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (N'Admin_ErrorLogsPage', 1, 4, 4, 1)
GO
INSERT [cms].[PermissionsControls] ([PermissionControlName], [PermissionControlTypeId], [PermissionControlPageId], [PermissionControlPagePermissionId], [IsActive]) VALUES (N'Admin_ActionsLogsPage', 1, 5, 5, 1)
GO

INSERT [cms].[PermissionsTypes] ([PermissionTypeName]) VALUES ( N'Backend')
GO
INSERT [cms].[PermissionsTypes] ([PermissionTypeName]) VALUES ( N'Frontend')
GO

INSERT [cms].[Roles] ([RoleName], [RoleDescription], [IsActive]) VALUES ( <AdministratorRoleName>, N'', 1)
GO

INSERT [cms].[RolesPermissions] ([RoleId], [PagePermissionId]) VALUES (1, 1)
GO
INSERT [cms].[RolesPermissions] ([RoleId], [PagePermissionId]) VALUES (1, 2)
GO
INSERT [cms].[RolesPermissions] ([RoleId], [PagePermissionId]) VALUES (1, 4)
GO
INSERT [cms].[RolesPermissions] ([RoleId], [PagePermissionId]) VALUES (1, 5)
GO

INSERT [cms].[UsersActions] ([UserActionName]) VALUES (N'Create')
GO
INSERT [cms].[UsersActions] ([UserActionName]) VALUES (N'Read')
GO
INSERT [cms].[UsersActions] ([UserActionName]) VALUES (N'Update')
GO
INSERT [cms].[UsersActions] ([UserActionName]) VALUES (N'Delete')
GO

INSERT [cms].[UsersRoles] ([RoleId], [UserId]) VALUES (1, 1)
GO

INSERT INTO [cms].[Entities]
           ([FirstName]
           ,[LastName]
           ,[CreationDate]
           ,[CreationDateMMS]
           ,[IsActive])
     VALUES
           (<AdministratorFirstname>
           ,<AdministratorLastname>
           ,<today>
           ,<todayMMS>
           ,1)
GO

INSERT INTO [cms].[Users]
           ([Username]
           ,[Password]
           ,[Email]
           ,[EntityId]
           ,[IsActive])
     VALUES
           (<AdministratorUsername>
           ,<AdministratorPassword>
           ,<AdministratorEmail>
           ,1
           ,1)
GO
