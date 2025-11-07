USE [master]
GO
/****** Object:  Database [EndeavorCRM]    Script Date: 08-11-2025 00:04:59 ******/
CREATE DATABASE [EndeavorCRM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EndeavorCRM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EndeavorCRM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EndeavorCRM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EndeavorCRM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EndeavorCRM] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EndeavorCRM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EndeavorCRM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EndeavorCRM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EndeavorCRM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EndeavorCRM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EndeavorCRM] SET ARITHABORT OFF 
GO
ALTER DATABASE [EndeavorCRM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EndeavorCRM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EndeavorCRM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EndeavorCRM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EndeavorCRM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EndeavorCRM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EndeavorCRM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EndeavorCRM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EndeavorCRM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EndeavorCRM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EndeavorCRM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EndeavorCRM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EndeavorCRM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EndeavorCRM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EndeavorCRM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EndeavorCRM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EndeavorCRM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EndeavorCRM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EndeavorCRM] SET  MULTI_USER 
GO
ALTER DATABASE [EndeavorCRM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EndeavorCRM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EndeavorCRM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EndeavorCRM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EndeavorCRM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EndeavorCRM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EndeavorCRM] SET QUERY_STORE = ON
GO
ALTER DATABASE [EndeavorCRM] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EndeavorCRM]
GO
/****** Object:  Table [dbo].[AgentMaster]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgentMaster](
	[AgentMasterId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](200) NOT NULL,
	[UserMasterId] [int] NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[ContactNumber] [varchar](50) NULL,
	[Degiganition] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[IP] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AgentMaster] PRIMARY KEY CLUSTERED 
(
	[AgentMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deal]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deal](
	[DealId] [int] IDENTITY(1,1) NOT NULL,
	[TypeOfCoverage] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[NoOfApplicants] [int] NOT NULL,
	[FFM] [varchar](100) NOT NULL,
	[Career] [int] NOT NULL,
	[TypeOfWork] [int] NOT NULL,
	[MonthlyIncome] [int] NOT NULL,
	[DocNeeded] [int] NOT NULL,
	[SocialProvided] [int] NOT NULL,
	[CustomerLanguage] [int] NOT NULL,
	[CloseDate] [datetime] NOT NULL,
	[Notes] [varchar](500) NOT NULL,
	[AgentId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[IP] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Deal] PRIMARY KEY CLUSTERED 
(
	[DealId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginFailure]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginFailure](
	[LoginFailureId] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](200) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[IP] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LoginFailure] PRIMARY KEY CLUSTERED 
(
	[LoginFailureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginHistory]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginHistory](
	[LoginHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[UserMasterId] [int] NOT NULL,
	[LoggedInTime] [datetime] NOT NULL,
	[IP] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LoginHistory] PRIMARY KEY CLUSTERED 
(
	[LoginHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuId] [int] NOT NULL,
	[MenuName] [varchar](50) NOT NULL,
	[MenuNameId] [varchar](50) NOT NULL,
	[PageURL] [varchar](100) NOT NULL,
	[Icon] [varchar](30) NOT NULL,
	[ParentId] [int] NOT NULL,
	[DisplayOrder] [smallint] NOT NULL,
	[IsHaveChild] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsShowtoAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuRole]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuRole](
	[MenuRoleId] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_MenuRole] PRIMARY KEY CLUSTERED 
(
	[MenuRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 08-11-2025 00:04:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UserMasterId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](200) NOT NULL,
	[UserPassword] [varchar](500) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[ContactNumber] [varchar](50) NULL,
	[RoleId] [int] NOT NULL,
	[IsFirstTimeLogin] [bit] NOT NULL,
	[TwoStepAuth] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[IP] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UserMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AgentMaster] ON 
GO
INSERT [dbo].[AgentMaster] ([AgentMasterId], [Username], [UserMasterId], [LastName], [FirstName], [ContactNumber], [Degiganition], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (1, N'test@gmail.com', 2, N'prajapati', N'Suraj', N'0630745000', N'1234', 1, 1, CAST(N'2025-11-05T06:12:53.000' AS DateTime), 1, CAST(N'2025-11-05T11:55:25.183' AS DateTime), N'::1')
GO
INSERT [dbo].[AgentMaster] ([AgentMasterId], [Username], [UserMasterId], [LastName], [FirstName], [ContactNumber], [Degiganition], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (2, N'nitin@gmail.com', 3, N'Soni', N'Nitin', N'8009352740', N'test', 1, 1, CAST(N'2025-11-06T10:47:34.830' AS DateTime), NULL, NULL, N'::1')
GO
SET IDENTITY_INSERT [dbo].[AgentMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Deal] ON 
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (1, N'2,3', N'test', N'twww', 1, N'ii', 1, 1, 1, 1, 1, 1, CAST(N'2025-11-11T00:00:00.000' AS DateTime), N'w3453453', 1, 1, 1, CAST(N'2025-11-06T12:50:02.000' AS DateTime), 1, CAST(N'2025-11-07T11:57:58.500' AS DateTime), N'::1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (2, N'1,2', N'niyin_12', N'somi', 12, N'WWW', 1, 1, 33, 1, 1, 1, CAST(N'2025-11-11T00:00:00.000' AS DateTime), N'qwerwetrewrt', 2, 1, 1, CAST(N'2025-11-06T13:29:57.000' AS DateTime), 1, CAST(N'2025-11-07T11:29:47.327' AS DateTime), N'::1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (3, N'3,4', N'Tushar', N'Goyal', 2, N'ertert', 1, 2, 2000, 2, 1, 2, CAST(N'2025-11-09T00:00:00.000' AS DateTime), N'jksdfhgsfkgdjkfg', 1, 1, 1, CAST(N'2025-11-07T11:59:42.073' AS DateTime), NULL, NULL, N'::1')
GO
SET IDENTITY_INSERT [dbo].[Deal] OFF
GO
SET IDENTITY_INSERT [dbo].[LoginHistory] ON 
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (1, 1, CAST(N'2025-11-05T02:12:31.970' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (2, 1, CAST(N'2025-11-05T02:12:57.437' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (3, 1, CAST(N'2025-11-05T02:41:41.640' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (4, 1, CAST(N'2025-11-05T02:59:00.457' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (5, 1, CAST(N'2025-11-05T05:01:07.100' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (6, 1, CAST(N'2025-11-05T05:24:43.713' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (7, 1, CAST(N'2025-11-05T05:56:02.863' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (8, 1, CAST(N'2025-11-05T06:04:02.717' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (9, 1, CAST(N'2025-11-05T06:10:44.240' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (10, 1, CAST(N'2025-11-05T06:21:23.933' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (11, 1, CAST(N'2025-11-05T10:28:06.273' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (12, 1, CAST(N'2025-11-05T11:37:51.030' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (13, 1, CAST(N'2025-11-05T11:38:46.780' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (14, 1, CAST(N'2025-11-05T11:49:01.347' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (15, 1, CAST(N'2025-11-06T10:42:19.133' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (16, 1, CAST(N'2025-11-06T10:43:42.310' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (17, 3, CAST(N'2025-11-06T10:48:04.840' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (18, 1, CAST(N'2025-11-06T10:48:23.877' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (19, 1, CAST(N'2025-11-06T10:50:38.367' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (20, 1, CAST(N'2025-11-06T11:02:12.163' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (21, 1, CAST(N'2025-11-06T11:09:49.500' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (22, 1, CAST(N'2025-11-06T11:11:08.137' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (23, 1, CAST(N'2025-11-06T12:30:02.197' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (24, 1, CAST(N'2025-11-06T12:36:17.203' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (25, 1, CAST(N'2025-11-06T12:40:48.577' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (26, 1, CAST(N'2025-11-06T12:45:16.900' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (27, 1, CAST(N'2025-11-06T12:48:43.610' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (28, 1, CAST(N'2025-11-06T12:54:29.003' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (29, 1, CAST(N'2025-11-06T13:28:06.947' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (30, 1, CAST(N'2025-11-06T13:33:35.163' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (31, 1, CAST(N'2025-11-06T21:31:35.407' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (32, 1, CAST(N'2025-11-07T10:58:24.747' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (33, 1, CAST(N'2025-11-07T11:19:20.080' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (34, 3, CAST(N'2025-11-07T11:40:37.787' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (35, 3, CAST(N'2025-11-07T11:51:51.177' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (36, 3, CAST(N'2025-11-07T11:53:16.567' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (37, 1, CAST(N'2025-11-07T11:57:38.503' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (38, 1, CAST(N'2025-11-07T12:30:26.567' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (39, 1, CAST(N'2025-11-07T12:32:13.440' AS DateTime), N'::1')
GO
SET IDENTITY_INSERT [dbo].[LoginHistory] OFF
GO
INSERT [dbo].[Menu] ([MenuId], [MenuName], [MenuNameId], [PageURL], [Icon], [ParentId], [DisplayOrder], [IsHaveChild], [IsActive], [IsShowtoAdmin]) VALUES (1, N'Dashboard', N'Dashboard', N'Dashboard', N'ri-dashboard-line', 0, 1, 0, 1, 1)
GO
INSERT [dbo].[Menu] ([MenuId], [MenuName], [MenuNameId], [PageURL], [Icon], [ParentId], [DisplayOrder], [IsHaveChild], [IsActive], [IsShowtoAdmin]) VALUES (2, N'Master', N'Master', N'#', N'ri-folder-3-line', 0, 2, 1, 1, 1)
GO
INSERT [dbo].[Menu] ([MenuId], [MenuName], [MenuNameId], [PageURL], [Icon], [ParentId], [DisplayOrder], [IsHaveChild], [IsActive], [IsShowtoAdmin]) VALUES (3, N'Agent', N'Agent', N'Agent', N'ri-user-3-line', 2, 0, 0, 1, 1)
GO
INSERT [dbo].[Menu] ([MenuId], [MenuName], [MenuNameId], [PageURL], [Icon], [ParentId], [DisplayOrder], [IsHaveChild], [IsActive], [IsShowtoAdmin]) VALUES (4, N'Deal', N'Deal', N'Deal', N'ri-shake-hands-line', 0, 3, 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[MenuRole] ON 
GO
INSERT [dbo].[MenuRole] ([MenuRoleId], [MenuId], [RoleId]) VALUES (1, 1, 3)
GO
INSERT [dbo].[MenuRole] ([MenuRoleId], [MenuId], [RoleId]) VALUES (2, 2, 1)
GO
INSERT [dbo].[MenuRole] ([MenuRoleId], [MenuId], [RoleId]) VALUES (3, 4, 3)
GO
SET IDENTITY_INSERT [dbo].[MenuRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([RoleId], [RoleName], [IsActive]) VALUES (1, N'Super Admin', 1)
GO
INSERT [dbo].[Role] ([RoleId], [RoleName], [IsActive]) VALUES (3, N'User', 1)
GO
INSERT [dbo].[Role] ([RoleId], [RoleName], [IsActive]) VALUES (4, N'Agent', 1)
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[UserMaster] ON 
GO
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (1, N'admin@gmail.com', N'3000~r8g65gQewznN5A/Q2V2ligfBieVGk5QG~Pv0k8duAx2fZJNOCNt0v5kSYlJEFUG2f', N'Prajapati', N'Suraj', N'8009352740', 1, 1, 0, 1, 1, CAST(N'2025-11-05T00:00:00.000' AS DateTime), 1, CAST(N'2025-11-06T11:10:58.847' AS DateTime), N'::1')
GO
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (2, N'test@gmail.com', N'3000~wkpzu6Dsuef+Gm5d46qKrkdnc3Xr29SB~vZQuudXYSJwSCrevRZojatXYBB9yQGpf', N'prajapati', N'Suraj', N'0630745000', 3, 1, 0, 1, 1, CAST(N'2025-11-05T06:12:45.717' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (3, N'nitin@gmail.com', N'3000~NOvyHzeBFi/P1KS0ssyI+JobHZc76ioK~46IvqXTT8gdiVkBu/DYuJc/3DMAkmN6p', N'Soni', N'Nitin', N'8009352740', 3, 1, 0, 1, 1, CAST(N'2025-11-06T10:47:34.817' AS DateTime), 3, CAST(N'2025-11-07T11:40:21.100' AS DateTime), N'::1')
GO
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
GO
ALTER TABLE [dbo].[AgentMaster]  WITH CHECK ADD  CONSTRAINT [FK_AgentMaster_UserMaster_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserMaster] ([UserMasterId])
GO
ALTER TABLE [dbo].[AgentMaster] CHECK CONSTRAINT [FK_AgentMaster_UserMaster_CreatedBy]
GO
ALTER TABLE [dbo].[AgentMaster]  WITH CHECK ADD  CONSTRAINT [FK_AgentMaster_UserMaster_UpdatedBy] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UserMaster] ([UserMasterId])
GO
ALTER TABLE [dbo].[AgentMaster] CHECK CONSTRAINT [FK_AgentMaster_UserMaster_UpdatedBy]
GO
ALTER TABLE [dbo].[AgentMaster]  WITH CHECK ADD  CONSTRAINT [FK_AgentMaster_UserMaster_UserId] FOREIGN KEY([UserMasterId])
REFERENCES [dbo].[UserMaster] ([UserMasterId])
GO
ALTER TABLE [dbo].[AgentMaster] CHECK CONSTRAINT [FK_AgentMaster_UserMaster_UserId]
GO
ALTER TABLE [dbo].[Deal]  WITH CHECK ADD  CONSTRAINT [FK_Deal_AgentMaster_agentId] FOREIGN KEY([AgentId])
REFERENCES [dbo].[AgentMaster] ([AgentMasterId])
GO
ALTER TABLE [dbo].[Deal] CHECK CONSTRAINT [FK_Deal_AgentMaster_agentId]
GO
ALTER TABLE [dbo].[Deal]  WITH CHECK ADD  CONSTRAINT [FK_Deal_UserMaster] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UserMaster] ([UserMasterId])
GO
ALTER TABLE [dbo].[Deal] CHECK CONSTRAINT [FK_Deal_UserMaster]
GO
ALTER TABLE [dbo].[Deal]  WITH CHECK ADD  CONSTRAINT [FK_Deal_UserMaster_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserMaster] ([UserMasterId])
GO
ALTER TABLE [dbo].[Deal] CHECK CONSTRAINT [FK_Deal_UserMaster_CreatedBy]
GO
ALTER TABLE [dbo].[LoginHistory]  WITH CHECK ADD  CONSTRAINT [FK_LoginHistory_UserMaster_UserMasterId] FOREIGN KEY([UserMasterId])
REFERENCES [dbo].[UserMaster] ([UserMasterId])
GO
ALTER TABLE [dbo].[LoginHistory] CHECK CONSTRAINT [FK_LoginHistory_UserMaster_UserMasterId]
GO
ALTER TABLE [dbo].[MenuRole]  WITH CHECK ADD  CONSTRAINT [FK_MenuRole_Menu_MenuId] FOREIGN KEY([MenuId])
REFERENCES [dbo].[Menu] ([MenuId])
GO
ALTER TABLE [dbo].[MenuRole] CHECK CONSTRAINT [FK_MenuRole_Menu_MenuId]
GO
ALTER TABLE [dbo].[MenuRole]  WITH CHECK ADD  CONSTRAINT [FK_MenuRole_Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[MenuRole] CHECK CONSTRAINT [FK_MenuRole_Role_RoleId]
GO
ALTER TABLE [dbo].[UserMaster]  WITH CHECK ADD  CONSTRAINT [FK_UserMaster_Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[UserMaster] CHECK CONSTRAINT [FK_UserMaster_Role_RoleId]
GO
USE [master]
GO
ALTER DATABASE [EndeavorCRM] SET  READ_WRITE 
GO
