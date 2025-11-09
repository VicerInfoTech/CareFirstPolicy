USE [master]
GO
/****** Object:  Database [EndeavorCRM]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[AgentMaster]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[Deal]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[LeadMaster]    Script Date: 09-11-2025 13:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadMaster](
	[LeadId] [int] IDENTITY(1,1) NOT NULL,
	[LeadSource] [varchar](100) NULL,
	[CustomerName] [varchar](200) NOT NULL,
	[ContactNumber] [varchar](20) NULL,
	[Email] [varchar](150) NULL,
	[Address] [varchar](500) NULL,
	[InterestedCoverage] [varchar](200) NULL,
	[LeadStatus] [int] NOT NULL,
	[AssignedAgentId] [int] NULL,
	[Notes] [varchar](max) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LeadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginFailure]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[LoginHistory]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[MenuRole]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 09-11-2025 13:57:10 ******/
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
/****** Object:  Table [dbo].[UserMaster]    Script Date: 09-11-2025 13:57:10 ******/
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
INSERT [dbo].[AgentMaster] ([AgentMasterId], [Username], [UserMasterId], [LastName], [FirstName], [ContactNumber], [Degiganition], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (3, N'john@example.com', 4, N'9991112222', N'John Carter', N'9991112222', N'ttr', 1, 1, CAST(N'2025-11-08T23:51:54.550' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[AgentMaster] ([AgentMasterId], [Username], [UserMasterId], [LastName], [FirstName], [ContactNumber], [Degiganition], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (4, N'emily@example.com', 5, N'Rose', N'Emily ', N'8885556666', N'yy', 1, 1, CAST(N'2025-11-08T23:52:21.443' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[AgentMaster] ([AgentMasterId], [Username], [UserMasterId], [LastName], [FirstName], [ContactNumber], [Degiganition], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (5, N'sophia@example.com', 6, N'Davis', N'Sophia ', N'6662224444', N'yy', 1, 1, CAST(N'2025-11-08T23:53:03.867' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[AgentMaster] ([AgentMasterId], [Username], [UserMasterId], [LastName], [FirstName], [ContactNumber], [Degiganition], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (6, N'robert@example.com', 7, N'Wilson', N'Robert ', N'9997773333', N'tt', 1, 1, CAST(N'2025-11-08T23:53:34.240' AS DateTime), NULL, NULL, N'::1')
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
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (4, N'Life', N'CustFirst1', N'CustLast1', 5, N'FFM1', 4, 2, 3537, 2, 2, 2, CAST(N'2025-11-16T10:51:19.387' AS DateTime), N'Demo Notes 1', 2, 1, 1, CAST(N'2025-11-09T10:51:19.387' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (5, N'Life', N'CustFirst2', N'CustLast2', 4, N'FFM2', 1, 4, 5454, 1, 2, 2, CAST(N'2025-11-10T10:51:19.390' AS DateTime), N'Demo Notes 2', 1, 1, 1, CAST(N'2025-11-09T10:51:19.390' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (6, N'Dental', N'CustFirst3', N'CustLast3', 4, N'FFM3', 3, 1, 6492, 2, 2, 3, CAST(N'2025-11-14T10:51:19.390' AS DateTime), N'Demo Notes 3', 2, 1, 1, CAST(N'2025-11-09T10:51:19.390' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (7, N'Health', N'CustFirst4', N'CustLast4', 1, N'FFM4', 1, 2, 2574, 2, 1, 2, CAST(N'2025-11-15T10:51:19.390' AS DateTime), N'Demo Notes 4', 6, 1, 1, CAST(N'2025-11-09T10:51:19.390' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (8, N'Life', N'CustFirst5', N'CustLast5', 1, N'FFM5', 4, 4, 2629, 1, 2, 2, CAST(N'2025-11-10T10:51:19.390' AS DateTime), N'Demo Notes 5', 6, 1, 1, CAST(N'2025-11-09T10:51:19.390' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (9, N'Vision', N'CustFirst6', N'CustLast6', 5, N'FFM6', 5, 4, 3607, 2, 2, 2, CAST(N'2025-11-15T10:51:19.390' AS DateTime), N'Demo Notes 6', 6, 1, 1, CAST(N'2025-11-09T10:51:19.390' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (10, N'Vision', N'CustFirst7', N'CustLast7', 2, N'FFM7', 4, 1, 4775, 2, 1, 2, CAST(N'2025-11-14T10:51:19.390' AS DateTime), N'Demo Notes 7', 6, 1, 1, CAST(N'2025-11-09T10:51:19.390' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (11, N'Life', N'CustFirst8', N'CustLast8', 5, N'FFM8', 2, 3, 5304, 1, 2, 1, CAST(N'2025-11-15T10:51:19.393' AS DateTime), N'Demo Notes 8', 2, 1, 1, CAST(N'2025-11-09T10:51:19.393' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (12, N'Life', N'CustFirst9', N'CustLast9', 4, N'FFM9', 1, 4, 2953, 1, 2, 2, CAST(N'2025-11-17T10:51:19.393' AS DateTime), N'Demo Notes 9', 1, 1, 1, CAST(N'2025-11-09T10:51:19.393' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (13, N'Dental', N'CustFirst10', N'CustLast10', 2, N'FFM10', 1, 3, 4112, 1, 2, 2, CAST(N'2025-11-18T10:51:19.393' AS DateTime), N'Demo Notes 10', 2, 1, 1, CAST(N'2025-11-09T10:51:19.393' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (14, N'Health', N'CustFirst11', N'CustLast11', 2, N'FFM11', 3, 4, 5793, 2, 2, 3, CAST(N'2025-11-16T10:51:19.393' AS DateTime), N'Demo Notes 11', 2, 1, 1, CAST(N'2025-11-09T10:51:19.393' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (15, N'Life', N'CustFirst12', N'CustLast12', 2, N'FFM12', 2, 2, 4801, 1, 2, 3, CAST(N'2025-11-09T10:51:19.393' AS DateTime), N'Demo Notes 12', 1, 1, 1, CAST(N'2025-11-09T10:51:19.393' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (16, N'Health', N'CustFirst13', N'CustLast13', 5, N'FFM13', 4, 1, 3046, 1, 2, 2, CAST(N'2025-11-09T10:51:19.393' AS DateTime), N'Demo Notes 13', 1, 1, 1, CAST(N'2025-11-09T10:51:19.393' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (17, N'Health', N'CustFirst14', N'CustLast14', 3, N'FFM14', 4, 3, 5415, 1, 2, 1, CAST(N'2025-11-18T10:51:19.397' AS DateTime), N'Demo Notes 14', 2, 1, 1, CAST(N'2025-11-09T10:51:19.397' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (18, N'Health', N'CustFirst15', N'CustLast15', 5, N'FFM15', 4, 1, 6289, 3, 2, 2, CAST(N'2025-11-14T10:51:19.397' AS DateTime), N'Demo Notes 15', 1, 1, 1, CAST(N'2025-11-09T10:51:19.397' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (19, N'Health', N'CustFirst16', N'CustLast16', 5, N'FFM16', 2, 3, 5119, 2, 1, 2, CAST(N'2025-11-16T10:51:19.400' AS DateTime), N'Demo Notes 16', 2, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (20, N'Life', N'CustFirst17', N'CustLast17', 2, N'FFM17', 4, 1, 2854, 3, 1, 3, CAST(N'2025-11-16T10:51:19.400' AS DateTime), N'Demo Notes 17', 2, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (21, N'Life', N'CustFirst18', N'CustLast18', 1, N'FFM18', 4, 1, 5539, 1, 2, 3, CAST(N'2025-11-14T10:51:19.400' AS DateTime), N'Demo Notes 18', 2, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (22, N'Dental', N'CustFirst19', N'CustLast19', 2, N'FFM19', 1, 4, 6203, 1, 2, 3, CAST(N'2025-11-17T10:51:19.400' AS DateTime), N'Demo Notes 19', 1, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (23, N'Life', N'CustFirst20', N'CustLast20', 2, N'FFM20', 1, 4, 3473, 2, 2, 1, CAST(N'2025-11-13T10:51:19.400' AS DateTime), N'Demo Notes 20', 2, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (24, N'Health', N'CustFirst21', N'CustLast21', 3, N'FFM21', 2, 4, 5974, 2, 1, 1, CAST(N'2025-11-16T10:51:19.400' AS DateTime), N'Demo Notes 21', 6, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (25, N'Dental', N'CustFirst22', N'CustLast22', 1, N'FFM22', 5, 3, 4919, 3, 1, 1, CAST(N'2025-11-18T10:51:19.400' AS DateTime), N'Demo Notes 22', 2, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (26, N'Dental', N'CustFirst23', N'CustLast23', 5, N'FFM23', 1, 2, 4630, 1, 1, 3, CAST(N'2025-11-18T10:51:19.400' AS DateTime), N'Demo Notes 23', 6, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (27, N'Dental', N'CustFirst24', N'CustLast24', 3, N'FFM24', 2, 1, 6155, 3, 2, 3, CAST(N'2025-11-10T10:51:19.400' AS DateTime), N'Demo Notes 24', 1, 1, 1, CAST(N'2025-11-09T10:51:19.400' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (28, N'Life', N'CustFirst25', N'CustLast25', 1, N'FFM25', 2, 3, 5377, 2, 1, 2, CAST(N'2025-11-11T10:51:19.403' AS DateTime), N'Demo Notes 25', 2, 1, 1, CAST(N'2025-11-09T10:51:19.403' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (29, N'Vision', N'CustFirst26', N'CustLast26', 5, N'FFM26', 4, 4, 4769, 3, 1, 2, CAST(N'2025-11-11T10:51:19.403' AS DateTime), N'Demo Notes 26', 2, 1, 1, CAST(N'2025-11-09T10:51:19.403' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (30, N'Life', N'CustFirst27', N'CustLast27', 3, N'FFM27', 2, 1, 4701, 2, 1, 3, CAST(N'2025-11-10T10:51:19.403' AS DateTime), N'Demo Notes 27', 1, 1, 1, CAST(N'2025-11-09T10:51:19.403' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (31, N'Life', N'CustFirst28', N'CustLast28', 3, N'FFM28', 3, 3, 4402, 1, 1, 1, CAST(N'2025-11-17T10:51:19.403' AS DateTime), N'Demo Notes 28', 2, 1, 1, CAST(N'2025-11-09T10:51:19.403' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (32, N'Vision', N'CustFirst29', N'CustLast29', 2, N'FFM29', 1, 1, 4267, 2, 2, 3, CAST(N'2025-11-09T10:51:19.403' AS DateTime), N'Demo Notes 29', 2, 1, 1, CAST(N'2025-11-09T10:51:19.403' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (33, N'Life', N'CustFirst30', N'CustLast30', 2, N'FFM30', 3, 3, 4646, 3, 2, 2, CAST(N'2025-11-13T10:51:19.403' AS DateTime), N'Demo Notes 30', 1, 1, 1, CAST(N'2025-11-09T10:51:19.403' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (34, N'Dental', N'CustFirst31', N'CustLast31', 2, N'FFM31', 1, 1, 3438, 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), N'Demo Notes 31', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (35, N'Life', N'CustFirst32', N'CustLast32', 2, N'FFM32', 2, 1, 5492, 2, 1, 1, CAST(N'2025-11-17T10:51:19.410' AS DateTime), N'Demo Notes 32', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (36, N'Life', N'CustFirst33', N'CustLast33', 2, N'FFM33', 5, 2, 4194, 2, 1, 2, CAST(N'2025-11-09T10:51:19.410' AS DateTime), N'Demo Notes 33', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (37, N'Dental', N'CustFirst34', N'CustLast34', 3, N'FFM34', 4, 4, 4265, 1, 2, 3, CAST(N'2025-11-11T10:51:19.410' AS DateTime), N'Demo Notes 34', 2, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (38, N'Vision', N'CustFirst35', N'CustLast35', 2, N'FFM35', 2, 4, 4775, 1, 2, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), N'Demo Notes 35', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (39, N'Vision', N'CustFirst36', N'CustLast36', 5, N'FFM36', 5, 2, 5166, 1, 2, 1, CAST(N'2025-11-14T10:51:19.410' AS DateTime), N'Demo Notes 36', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (40, N'Dental', N'CustFirst37', N'CustLast37', 1, N'FFM37', 3, 4, 5044, 1, 1, 3, CAST(N'2025-11-16T10:51:19.410' AS DateTime), N'Demo Notes 37', 2, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (41, N'Life', N'CustFirst38', N'CustLast38', 1, N'FFM38', 4, 1, 4745, 3, 1, 1, CAST(N'2025-11-17T10:51:19.410' AS DateTime), N'Demo Notes 38', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (42, N'Dental', N'CustFirst39', N'CustLast39', 3, N'FFM39', 4, 1, 3153, 1, 2, 2, CAST(N'2025-11-16T10:51:19.410' AS DateTime), N'Demo Notes 39', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (43, N'Life', N'CustFirst40', N'CustLast40', 3, N'FFM40', 4, 4, 6038, 2, 1, 3, CAST(N'2025-11-15T10:51:19.410' AS DateTime), N'Demo Notes 40', 2, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (44, N'Life', N'CustFirst41', N'CustLast41', 1, N'FFM41', 5, 4, 4010, 2, 2, 2, CAST(N'2025-11-16T10:51:19.410' AS DateTime), N'Demo Notes 41', 1, 1, 1, CAST(N'2025-11-09T10:51:19.410' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (45, N'Health', N'CustFirst42', N'CustLast42', 2, N'FFM42', 5, 3, 4636, 1, 1, 2, CAST(N'2025-11-16T10:51:19.413' AS DateTime), N'Demo Notes 42', 2, 1, 1, CAST(N'2025-11-09T10:51:19.413' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (46, N'Vision', N'CustFirst43', N'CustLast43', 4, N'FFM43', 1, 2, 3417, 2, 2, 2, CAST(N'2025-11-15T10:51:19.413' AS DateTime), N'Demo Notes 43', 1, 1, 1, CAST(N'2025-11-09T10:51:19.413' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (47, N'Life', N'CustFirst44', N'CustLast44', 2, N'FFM44', 1, 2, 2603, 1, 2, 3, CAST(N'2025-11-12T10:51:19.417' AS DateTime), N'Demo Notes 44', 2, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (48, N'Life', N'CustFirst45', N'CustLast45', 3, N'FFM45', 1, 3, 5541, 3, 1, 2, CAST(N'2025-11-13T10:51:19.417' AS DateTime), N'Demo Notes 45', 1, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (49, N'Life', N'CustFirst46', N'CustLast46', 3, N'FFM46', 4, 3, 4226, 1, 2, 3, CAST(N'2025-11-10T10:51:19.417' AS DateTime), N'Demo Notes 46', 6, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (50, N'Dental', N'CustFirst47', N'CustLast47', 1, N'FFM47', 1, 1, 5348, 3, 1, 1, CAST(N'2025-11-17T10:51:19.417' AS DateTime), N'Demo Notes 47', 2, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (51, N'Health', N'CustFirst48', N'CustLast48', 2, N'FFM48', 1, 2, 2896, 1, 1, 2, CAST(N'2025-11-16T10:51:19.417' AS DateTime), N'Demo Notes 48', 1, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (52, N'Dental', N'CustFirst49', N'CustLast49', 2, N'FFM49', 3, 1, 5268, 2, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), N'Demo Notes 49', 6, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (53, N'Health', N'CustFirst50', N'CustLast50', 1, N'FFM50', 1, 4, 2592, 3, 2, 1, CAST(N'2025-11-16T10:51:19.417' AS DateTime), N'Demo Notes 50', 2, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (54, N'Life', N'CustFirst51', N'CustLast51', 1, N'FFM51', 5, 3, 4962, 1, 1, 1, CAST(N'2025-11-10T10:51:19.417' AS DateTime), N'Demo Notes 51', 1, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (55, N'Life', N'CustFirst52', N'CustLast52', 1, N'FFM52', 1, 3, 5661, 3, 2, 1, CAST(N'2025-11-14T10:51:19.417' AS DateTime), N'Demo Notes 52', 1, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (56, N'Dental', N'CustFirst53', N'CustLast53', 3, N'FFM53', 1, 4, 5367, 2, 2, 3, CAST(N'2025-11-13T10:51:19.417' AS DateTime), N'Demo Notes 53', 1, 1, 1, CAST(N'2025-11-09T10:51:19.417' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (57, N'Health', N'CustFirst54', N'CustLast54', 2, N'FFM54', 2, 3, 4863, 2, 2, 2, CAST(N'2025-11-18T10:51:19.420' AS DateTime), N'Demo Notes 54', 6, 1, 1, CAST(N'2025-11-09T10:51:19.420' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (58, N'Life', N'CustFirst55', N'CustLast55', 1, N'FFM55', 5, 1, 3989, 1, 1, 1, CAST(N'2025-11-15T10:51:19.423' AS DateTime), N'Demo Notes 55', 1, 1, 1, CAST(N'2025-11-09T10:51:19.423' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (59, N'Life', N'CustFirst56', N'CustLast56', 1, N'FFM56', 5, 1, 4165, 1, 1, 3, CAST(N'2025-11-12T10:51:19.423' AS DateTime), N'Demo Notes 56', 6, 1, 1, CAST(N'2025-11-09T10:51:19.423' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (60, N'Vision', N'CustFirst57', N'CustLast57', 5, N'FFM57', 1, 2, 3221, 1, 1, 2, CAST(N'2025-11-16T10:51:19.423' AS DateTime), N'Demo Notes 57', 2, 1, 1, CAST(N'2025-11-09T10:51:19.423' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (61, N'Life', N'CustFirst58', N'CustLast58', 3, N'FFM58', 3, 3, 2669, 2, 2, 2, CAST(N'2025-11-10T10:51:19.423' AS DateTime), N'Demo Notes 58', 6, 1, 1, CAST(N'2025-11-09T10:51:19.423' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (62, N'Life', N'CustFirst59', N'CustLast59', 3, N'FFM59', 5, 1, 3411, 2, 2, 3, CAST(N'2025-11-18T10:51:19.427' AS DateTime), N'Demo Notes 59', 6, 1, 1, CAST(N'2025-11-09T10:51:19.427' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (63, N'Life', N'CustFirst60', N'CustLast60', 4, N'FFM60', 4, 3, 6068, 2, 2, 3, CAST(N'2025-11-10T10:51:19.427' AS DateTime), N'Demo Notes 60', 6, 1, 1, CAST(N'2025-11-09T10:51:19.427' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (64, N'Vision', N'CustFirst61', N'CustLast61', 1, N'FFM61', 2, 4, 6168, 1, 2, 2, CAST(N'2025-11-17T10:51:19.427' AS DateTime), N'Demo Notes 61', 6, 1, 1, CAST(N'2025-11-09T10:51:19.427' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (65, N'Health', N'CustFirst62', N'CustLast62', 5, N'FFM62', 4, 4, 3804, 1, 1, 3, CAST(N'2025-11-11T10:51:19.430' AS DateTime), N'Demo Notes 62', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (66, N'Life', N'CustFirst63', N'CustLast63', 5, N'FFM63', 4, 1, 4246, 2, 1, 2, CAST(N'2025-11-11T10:51:19.430' AS DateTime), N'Demo Notes 63', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (67, N'Health', N'CustFirst64', N'CustLast64', 5, N'FFM64', 1, 3, 5687, 3, 1, 3, CAST(N'2025-11-17T10:51:19.430' AS DateTime), N'Demo Notes 64', 6, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (68, N'Life', N'CustFirst65', N'CustLast65', 1, N'FFM65', 4, 2, 6386, 1, 1, 3, CAST(N'2025-11-12T10:51:19.430' AS DateTime), N'Demo Notes 65', 1, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (69, N'Life', N'CustFirst66', N'CustLast66', 3, N'FFM66', 1, 1, 4388, 1, 2, 2, CAST(N'2025-11-11T10:51:19.430' AS DateTime), N'Demo Notes 66', 6, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (70, N'Dental', N'CustFirst67', N'CustLast67', 1, N'FFM67', 4, 3, 5184, 1, 2, 1, CAST(N'2025-11-10T10:51:19.430' AS DateTime), N'Demo Notes 67', 1, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (71, N'Health', N'CustFirst68', N'CustLast68', 4, N'FFM68', 5, 3, 4385, 3, 1, 1, CAST(N'2025-11-18T10:51:19.430' AS DateTime), N'Demo Notes 68', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (72, N'Dental', N'CustFirst69', N'CustLast69', 4, N'FFM69', 5, 4, 6319, 2, 2, 2, CAST(N'2025-11-09T10:51:19.430' AS DateTime), N'Demo Notes 69', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (73, N'Health', N'CustFirst70', N'CustLast70', 5, N'FFM70', 2, 2, 3496, 2, 2, 1, CAST(N'2025-11-12T10:51:19.430' AS DateTime), N'Demo Notes 70', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (74, N'Health', N'CustFirst71', N'CustLast71', 2, N'FFM71', 3, 3, 2570, 2, 2, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), N'Demo Notes 71', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (75, N'Vision', N'CustFirst72', N'CustLast72', 1, N'FFM72', 1, 4, 6491, 2, 1, 3, CAST(N'2025-11-09T10:51:19.430' AS DateTime), N'Demo Notes 72', 1, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (76, N'Life', N'CustFirst73', N'CustLast73', 3, N'FFM73', 4, 1, 6135, 1, 1, 3, CAST(N'2025-11-17T10:51:19.430' AS DateTime), N'Demo Notes 73', 1, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (77, N'Vision', N'CustFirst74', N'CustLast74', 3, N'FFM74', 3, 2, 3279, 2, 1, 2, CAST(N'2025-11-13T10:51:19.430' AS DateTime), N'Demo Notes 74', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (78, N'Health', N'CustFirst75', N'CustLast75', 4, N'FFM75', 5, 2, 6389, 1, 2, 2, CAST(N'2025-11-16T10:51:19.430' AS DateTime), N'Demo Notes 75', 1, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (79, N'Dental', N'CustFirst76', N'CustLast76', 1, N'FFM76', 4, 4, 3462, 3, 2, 2, CAST(N'2025-11-11T10:51:19.430' AS DateTime), N'Demo Notes 76', 6, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (80, N'Dental', N'CustFirst77', N'CustLast77', 1, N'FFM77', 1, 3, 4013, 1, 2, 2, CAST(N'2025-11-13T10:51:19.430' AS DateTime), N'Demo Notes 77', 2, 1, 1, CAST(N'2025-11-09T10:51:19.430' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (81, N'Life', N'CustFirst78', N'CustLast78', 1, N'FFM78', 5, 1, 3858, 1, 1, 2, CAST(N'2025-11-10T10:51:19.433' AS DateTime), N'Demo Notes 78', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (82, N'Health', N'CustFirst79', N'CustLast79', 5, N'FFM79', 1, 2, 6325, 1, 2, 3, CAST(N'2025-11-14T10:51:19.433' AS DateTime), N'Demo Notes 79', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (83, N'Health', N'CustFirst80', N'CustLast80', 3, N'FFM80', 3, 3, 3717, 2, 1, 1, CAST(N'2025-11-17T10:51:19.433' AS DateTime), N'Demo Notes 80', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (84, N'Health', N'CustFirst81', N'CustLast81', 4, N'FFM81', 5, 4, 5298, 2, 1, 1, CAST(N'2025-11-11T10:51:19.433' AS DateTime), N'Demo Notes 81', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (85, N'Vision', N'CustFirst82', N'CustLast82', 2, N'FFM82', 1, 3, 3447, 3, 1, 1, CAST(N'2025-11-12T10:51:19.433' AS DateTime), N'Demo Notes 82', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (86, N'Life', N'CustFirst83', N'CustLast83', 4, N'FFM83', 3, 1, 4851, 1, 2, 3, CAST(N'2025-11-15T10:51:19.433' AS DateTime), N'Demo Notes 83', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (87, N'Dental', N'CustFirst84', N'CustLast84', 1, N'FFM84', 4, 3, 2957, 2, 1, 2, CAST(N'2025-11-18T10:51:19.433' AS DateTime), N'Demo Notes 84', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (88, N'Dental', N'CustFirst85', N'CustLast85', 1, N'FFM85', 3, 3, 4106, 1, 2, 3, CAST(N'2025-11-09T10:51:19.433' AS DateTime), N'Demo Notes 85', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (89, N'Vision', N'CustFirst86', N'CustLast86', 4, N'FFM86', 1, 2, 2938, 3, 1, 1, CAST(N'2025-11-16T10:51:19.433' AS DateTime), N'Demo Notes 86', 2, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (90, N'Life', N'CustFirst87', N'CustLast87', 2, N'FFM87', 4, 2, 5162, 3, 2, 3, CAST(N'2025-11-09T10:51:19.433' AS DateTime), N'Demo Notes 87', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (91, N'Vision', N'CustFirst88', N'CustLast88', 4, N'FFM88', 1, 4, 6061, 3, 2, 2, CAST(N'2025-11-10T10:51:19.433' AS DateTime), N'Demo Notes 88', 2, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (92, N'Health', N'CustFirst89', N'CustLast89', 1, N'FFM89', 4, 3, 4647, 1, 2, 1, CAST(N'2025-11-10T10:51:19.433' AS DateTime), N'Demo Notes 89', 1, 1, 1, CAST(N'2025-11-09T10:51:19.433' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (93, N'Dental', N'CustFirst90', N'CustLast90', 2, N'FFM90', 1, 2, 3707, 2, 1, 3, CAST(N'2025-11-09T10:51:19.437' AS DateTime), N'Demo Notes 90', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (94, N'Life', N'CustFirst91', N'CustLast91', 3, N'FFM91', 1, 4, 4132, 1, 1, 3, CAST(N'2025-11-18T10:51:19.437' AS DateTime), N'Demo Notes 91', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (95, N'Dental', N'CustFirst92', N'CustLast92', 1, N'FFM92', 3, 2, 4911, 2, 2, 1, CAST(N'2025-11-16T10:51:19.437' AS DateTime), N'Demo Notes 92', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (96, N'Health', N'CustFirst93', N'CustLast93', 4, N'FFM93', 4, 3, 6457, 2, 1, 3, CAST(N'2025-11-11T10:51:19.437' AS DateTime), N'Demo Notes 93', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (97, N'Vision', N'CustFirst94', N'CustLast94', 4, N'FFM94', 1, 3, 4130, 2, 2, 1, CAST(N'2025-11-18T10:51:19.437' AS DateTime), N'Demo Notes 94', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (98, N'Dental', N'CustFirst95', N'CustLast95', 2, N'FFM95', 1, 4, 5839, 3, 1, 3, CAST(N'2025-11-14T10:51:19.437' AS DateTime), N'Demo Notes 95', 2, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (99, N'Life', N'CustFirst96', N'CustLast96', 5, N'FFM96', 2, 3, 4688, 3, 1, 1, CAST(N'2025-11-16T10:51:19.437' AS DateTime), N'Demo Notes 96', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (100, N'Health', N'CustFirst97', N'CustLast97', 2, N'FFM97', 1, 1, 5414, 2, 1, 2, CAST(N'2025-11-15T10:51:19.437' AS DateTime), N'Demo Notes 97', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (101, N'Vision', N'CustFirst98', N'CustLast98', 3, N'FFM98', 4, 2, 4407, 2, 2, 2, CAST(N'2025-11-17T10:51:19.437' AS DateTime), N'Demo Notes 98', 2, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (102, N'Vision', N'CustFirst99', N'CustLast99', 5, N'FFM99', 1, 1, 3263, 2, 2, 3, CAST(N'2025-11-15T10:51:19.437' AS DateTime), N'Demo Notes 99', 1, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (103, N'Vision', N'CustFirst100', N'CustLast100', 5, N'FFM100', 2, 2, 3281, 3, 1, 1, CAST(N'2025-11-17T10:51:19.437' AS DateTime), N'Demo Notes 100', 2, 1, 1, CAST(N'2025-11-09T10:51:19.437' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (104, N'Dental', N'CustFirst1', N'CustLast1', 5, N'FFM1', 1, 1, 4031, 2, 1, 2, CAST(N'2025-11-17T10:51:32.020' AS DateTime), N'Demo Notes 1', 2, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (105, N'Life', N'CustFirst2', N'CustLast2', 1, N'FFM2', 5, 3, 6465, 3, 1, 3, CAST(N'2025-11-14T10:51:32.020' AS DateTime), N'Demo Notes 2', 1, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (106, N'Health', N'CustFirst3', N'CustLast3', 2, N'FFM3', 5, 3, 3808, 1, 2, 2, CAST(N'2025-11-16T10:51:32.020' AS DateTime), N'Demo Notes 3', 2, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (107, N'Health', N'CustFirst4', N'CustLast4', 1, N'FFM4', 5, 1, 5316, 2, 1, 1, CAST(N'2025-11-15T10:51:32.020' AS DateTime), N'Demo Notes 4', 1, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (108, N'Life', N'CustFirst5', N'CustLast5', 3, N'FFM5', 1, 1, 5463, 2, 2, 2, CAST(N'2025-11-18T10:51:32.020' AS DateTime), N'Demo Notes 5', 1, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (109, N'Life', N'CustFirst6', N'CustLast6', 4, N'FFM6', 1, 4, 3155, 1, 1, 2, CAST(N'2025-11-14T10:51:32.020' AS DateTime), N'Demo Notes 6', 2, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (110, N'Vision', N'CustFirst7', N'CustLast7', 2, N'FFM7', 1, 1, 5449, 3, 1, 3, CAST(N'2025-11-13T10:51:32.020' AS DateTime), N'Demo Notes 7', 2, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (111, N'Health', N'CustFirst8', N'CustLast8', 5, N'FFM8', 2, 3, 3698, 2, 2, 3, CAST(N'2025-11-09T10:51:32.020' AS DateTime), N'Demo Notes 8', 2, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (112, N'Life', N'CustFirst9', N'CustLast9', 5, N'FFM9', 2, 4, 3107, 3, 1, 3, CAST(N'2025-11-18T10:51:32.020' AS DateTime), N'Demo Notes 9', 2, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (113, N'Vision', N'CustFirst10', N'CustLast10', 3, N'FFM10', 4, 1, 5188, 3, 2, 1, CAST(N'2025-11-14T10:51:32.020' AS DateTime), N'Demo Notes 10', 1, 1, 1, CAST(N'2025-11-09T10:51:32.020' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (114, N'Life', N'CustFirst11', N'CustLast11', 2, N'FFM11', 3, 1, 5062, 3, 1, 2, CAST(N'2025-11-10T10:51:32.023' AS DateTime), N'Demo Notes 11', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (115, N'Life', N'CustFirst12', N'CustLast12', 5, N'FFM12', 1, 3, 4567, 3, 2, 1, CAST(N'2025-11-14T10:51:32.023' AS DateTime), N'Demo Notes 12', 1, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (116, N'Dental', N'CustFirst13', N'CustLast13', 5, N'FFM13', 5, 4, 6340, 1, 2, 2, CAST(N'2025-11-16T10:51:32.023' AS DateTime), N'Demo Notes 13', 1, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (117, N'Health', N'CustFirst14', N'CustLast14', 5, N'FFM14', 1, 4, 5434, 1, 1, 2, CAST(N'2025-11-15T10:51:32.023' AS DateTime), N'Demo Notes 14', 1, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (118, N'Dental', N'CustFirst15', N'CustLast15', 5, N'FFM15', 5, 3, 2923, 1, 2, 3, CAST(N'2025-11-18T10:51:32.023' AS DateTime), N'Demo Notes 15', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (119, N'Vision', N'CustFirst16', N'CustLast16', 1, N'FFM16', 3, 3, 5852, 1, 1, 1, CAST(N'2025-11-12T10:51:32.023' AS DateTime), N'Demo Notes 16', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (120, N'Life', N'CustFirst17', N'CustLast17', 4, N'FFM17', 5, 4, 3715, 3, 1, 1, CAST(N'2025-11-16T10:51:32.023' AS DateTime), N'Demo Notes 17', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (121, N'Vision', N'CustFirst18', N'CustLast18', 2, N'FFM18', 4, 4, 5948, 1, 1, 2, CAST(N'2025-11-17T10:51:32.023' AS DateTime), N'Demo Notes 18', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (122, N'Vision', N'CustFirst19', N'CustLast19', 1, N'FFM19', 4, 3, 5819, 3, 1, 2, CAST(N'2025-11-11T10:51:32.023' AS DateTime), N'Demo Notes 19', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (123, N'Health', N'CustFirst20', N'CustLast20', 2, N'FFM20', 2, 1, 2570, 2, 2, 1, CAST(N'2025-11-15T10:51:32.023' AS DateTime), N'Demo Notes 20', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (124, N'Dental', N'CustFirst21', N'CustLast21', 4, N'FFM21', 2, 4, 5929, 1, 1, 1, CAST(N'2025-11-17T10:51:32.023' AS DateTime), N'Demo Notes 21', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (125, N'Dental', N'CustFirst22', N'CustLast22', 5, N'FFM22', 5, 1, 2724, 3, 2, 2, CAST(N'2025-11-13T10:51:32.023' AS DateTime), N'Demo Notes 22', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (126, N'Health', N'CustFirst23', N'CustLast23', 3, N'FFM23', 3, 3, 4711, 1, 2, 3, CAST(N'2025-11-09T10:51:32.023' AS DateTime), N'Demo Notes 23', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (127, N'Health', N'CustFirst24', N'CustLast24', 3, N'FFM24', 5, 1, 4060, 3, 2, 1, CAST(N'2025-11-16T10:51:32.023' AS DateTime), N'Demo Notes 24', 2, 1, 1, CAST(N'2025-11-09T10:51:32.023' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (128, N'Health', N'CustFirst25', N'CustLast25', 4, N'FFM25', 4, 1, 3733, 3, 2, 2, CAST(N'2025-11-11T10:51:32.027' AS DateTime), N'Demo Notes 25', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (129, N'Life', N'CustFirst26', N'CustLast26', 3, N'FFM26', 1, 1, 3605, 1, 2, 3, CAST(N'2025-11-12T10:51:32.027' AS DateTime), N'Demo Notes 26', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (130, N'Dental', N'CustFirst27', N'CustLast27', 2, N'FFM27', 2, 2, 5071, 2, 2, 2, CAST(N'2025-11-09T10:51:32.027' AS DateTime), N'Demo Notes 27', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (131, N'Vision', N'CustFirst28', N'CustLast28', 1, N'FFM28', 1, 2, 5808, 3, 2, 3, CAST(N'2025-11-12T10:51:32.027' AS DateTime), N'Demo Notes 28', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (132, N'Dental', N'CustFirst29', N'CustLast29', 1, N'FFM29', 2, 4, 3446, 2, 2, 2, CAST(N'2025-11-14T10:51:32.027' AS DateTime), N'Demo Notes 29', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (133, N'Life', N'CustFirst30', N'CustLast30', 5, N'FFM30', 5, 2, 6140, 2, 1, 2, CAST(N'2025-11-11T10:51:32.027' AS DateTime), N'Demo Notes 30', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (134, N'Life', N'CustFirst31', N'CustLast31', 4, N'FFM31', 3, 2, 5303, 2, 1, 3, CAST(N'2025-11-09T10:51:32.027' AS DateTime), N'Demo Notes 31', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (135, N'Health', N'CustFirst32', N'CustLast32', 3, N'FFM32', 2, 1, 5112, 1, 1, 2, CAST(N'2025-11-10T10:51:32.027' AS DateTime), N'Demo Notes 32', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (136, N'Health', N'CustFirst33', N'CustLast33', 2, N'FFM33', 2, 3, 2663, 2, 1, 1, CAST(N'2025-11-18T10:51:32.027' AS DateTime), N'Demo Notes 33', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (137, N'Health', N'CustFirst34', N'CustLast34', 4, N'FFM34', 4, 2, 2739, 2, 2, 1, CAST(N'2025-11-18T10:51:32.027' AS DateTime), N'Demo Notes 34', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (138, N'Dental', N'CustFirst35', N'CustLast35', 1, N'FFM35', 2, 4, 2723, 3, 1, 1, CAST(N'2025-11-16T10:51:32.027' AS DateTime), N'Demo Notes 35', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (139, N'Life', N'CustFirst36', N'CustLast36', 4, N'FFM36', 2, 4, 3105, 1, 1, 2, CAST(N'2025-11-16T10:51:32.027' AS DateTime), N'Demo Notes 36', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (140, N'Vision', N'CustFirst37', N'CustLast37', 5, N'FFM37', 1, 1, 4606, 3, 2, 2, CAST(N'2025-11-11T10:51:32.027' AS DateTime), N'Demo Notes 37', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (141, N'Life', N'CustFirst38', N'CustLast38', 4, N'FFM38', 2, 1, 4954, 2, 1, 2, CAST(N'2025-11-17T10:51:32.027' AS DateTime), N'Demo Notes 38', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (142, N'Life', N'CustFirst39', N'CustLast39', 1, N'FFM39', 4, 4, 5606, 1, 2, 3, CAST(N'2025-11-13T10:51:32.027' AS DateTime), N'Demo Notes 39', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (143, N'Life', N'CustFirst40', N'CustLast40', 4, N'FFM40', 1, 1, 6078, 3, 1, 2, CAST(N'2025-11-10T10:51:32.027' AS DateTime), N'Demo Notes 40', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (144, N'Health', N'CustFirst41', N'CustLast41', 4, N'FFM41', 3, 2, 5053, 1, 2, 2, CAST(N'2025-11-12T10:51:32.027' AS DateTime), N'Demo Notes 41', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (145, N'Dental', N'CustFirst42', N'CustLast42', 3, N'FFM42', 3, 1, 2932, 2, 2, 2, CAST(N'2025-11-14T10:51:32.027' AS DateTime), N'Demo Notes 42', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (146, N'Dental', N'CustFirst43', N'CustLast43', 3, N'FFM43', 5, 2, 4760, 1, 2, 1, CAST(N'2025-11-17T10:51:32.027' AS DateTime), N'Demo Notes 43', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (147, N'Dental', N'CustFirst44', N'CustLast44', 4, N'FFM44', 3, 1, 5208, 2, 1, 2, CAST(N'2025-11-17T10:51:32.027' AS DateTime), N'Demo Notes 44', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (148, N'Life', N'CustFirst45', N'CustLast45', 2, N'FFM45', 5, 4, 6025, 2, 1, 2, CAST(N'2025-11-12T10:51:32.027' AS DateTime), N'Demo Notes 45', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (149, N'Health', N'CustFirst46', N'CustLast46', 3, N'FFM46', 5, 4, 2623, 1, 1, 1, CAST(N'2025-11-14T10:51:32.027' AS DateTime), N'Demo Notes 46', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (150, N'Health', N'CustFirst47', N'CustLast47', 4, N'FFM47', 1, 4, 5207, 1, 2, 2, CAST(N'2025-11-09T10:51:32.027' AS DateTime), N'Demo Notes 47', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (151, N'Life', N'CustFirst48', N'CustLast48', 5, N'FFM48', 2, 2, 3032, 3, 2, 3, CAST(N'2025-11-09T10:51:32.027' AS DateTime), N'Demo Notes 48', 1, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (152, N'Health', N'CustFirst49', N'CustLast49', 3, N'FFM49', 3, 2, 4572, 2, 2, 3, CAST(N'2025-11-12T10:51:32.027' AS DateTime), N'Demo Notes 49', 2, 1, 1, CAST(N'2025-11-09T10:51:32.027' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (153, N'Life', N'CustFirst50', N'CustLast50', 4, N'FFM50', 5, 2, 4217, 2, 1, 1, CAST(N'2025-11-10T10:51:32.030' AS DateTime), N'Demo Notes 50', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (154, N'Dental', N'CustFirst51', N'CustLast51', 3, N'FFM51', 1, 3, 5821, 2, 1, 3, CAST(N'2025-11-17T10:51:32.030' AS DateTime), N'Demo Notes 51', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (155, N'Dental', N'CustFirst52', N'CustLast52', 5, N'FFM52', 3, 2, 3812, 3, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), N'Demo Notes 52', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (156, N'Dental', N'CustFirst53', N'CustLast53', 1, N'FFM53', 3, 2, 6347, 3, 2, 3, CAST(N'2025-11-15T10:51:32.030' AS DateTime), N'Demo Notes 53', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (157, N'Life', N'CustFirst54', N'CustLast54', 5, N'FFM54', 2, 3, 2658, 3, 2, 1, CAST(N'2025-11-12T10:51:32.030' AS DateTime), N'Demo Notes 54', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (158, N'Life', N'CustFirst55', N'CustLast55', 5, N'FFM55', 5, 4, 3134, 1, 1, 2, CAST(N'2025-11-09T10:51:32.030' AS DateTime), N'Demo Notes 55', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (159, N'Vision', N'CustFirst56', N'CustLast56', 2, N'FFM56', 3, 1, 3612, 1, 1, 1, CAST(N'2025-11-14T10:51:32.030' AS DateTime), N'Demo Notes 56', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (160, N'Life', N'CustFirst57', N'CustLast57', 5, N'FFM57', 4, 2, 2642, 3, 2, 3, CAST(N'2025-11-10T10:51:32.030' AS DateTime), N'Demo Notes 57', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (161, N'Life', N'CustFirst58', N'CustLast58', 2, N'FFM58', 5, 2, 5448, 1, 1, 2, CAST(N'2025-11-18T10:51:32.030' AS DateTime), N'Demo Notes 58', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (162, N'Vision', N'CustFirst59', N'CustLast59', 2, N'FFM59', 2, 1, 5375, 3, 2, 1, CAST(N'2025-11-16T10:51:32.030' AS DateTime), N'Demo Notes 59', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (163, N'Life', N'CustFirst60', N'CustLast60', 4, N'FFM60', 2, 1, 3592, 3, 2, 3, CAST(N'2025-11-10T10:51:32.030' AS DateTime), N'Demo Notes 60', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (164, N'Health', N'CustFirst61', N'CustLast61', 2, N'FFM61', 3, 4, 4521, 2, 1, 3, CAST(N'2025-11-11T10:51:32.030' AS DateTime), N'Demo Notes 61', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (165, N'Life', N'CustFirst62', N'CustLast62', 1, N'FFM62', 1, 2, 5033, 3, 1, 3, CAST(N'2025-11-09T10:51:32.030' AS DateTime), N'Demo Notes 62', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (166, N'Health', N'CustFirst63', N'CustLast63', 5, N'FFM63', 5, 1, 4832, 1, 1, 2, CAST(N'2025-11-16T10:51:32.030' AS DateTime), N'Demo Notes 63', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (167, N'Life', N'CustFirst64', N'CustLast64', 1, N'FFM64', 5, 4, 2560, 2, 1, 3, CAST(N'2025-11-09T10:51:32.030' AS DateTime), N'Demo Notes 64', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (168, N'Life', N'CustFirst65', N'CustLast65', 1, N'FFM65', 4, 4, 3347, 1, 1, 3, CAST(N'2025-11-13T10:51:32.030' AS DateTime), N'Demo Notes 65', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (169, N'Health', N'CustFirst66', N'CustLast66', 1, N'FFM66', 5, 2, 5260, 2, 2, 1, CAST(N'2025-11-17T10:51:32.030' AS DateTime), N'Demo Notes 66', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (170, N'Life', N'CustFirst67', N'CustLast67', 1, N'FFM67', 1, 1, 2501, 1, 2, 3, CAST(N'2025-11-11T10:51:32.030' AS DateTime), N'Demo Notes 67', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (171, N'Health', N'CustFirst68', N'CustLast68', 5, N'FFM68', 1, 4, 6041, 3, 1, 1, CAST(N'2025-11-12T10:51:32.030' AS DateTime), N'Demo Notes 68', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (172, N'Health', N'CustFirst69', N'CustLast69', 4, N'FFM69', 5, 1, 3422, 1, 1, 2, CAST(N'2025-11-14T10:51:32.030' AS DateTime), N'Demo Notes 69', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (173, N'Health', N'CustFirst70', N'CustLast70', 5, N'FFM70', 5, 4, 4762, 2, 2, 2, CAST(N'2025-11-15T10:51:32.030' AS DateTime), N'Demo Notes 70', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (174, N'Health', N'CustFirst71', N'CustLast71', 1, N'FFM71', 3, 4, 3539, 2, 2, 3, CAST(N'2025-11-09T10:51:32.030' AS DateTime), N'Demo Notes 71', 1, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (175, N'Dental', N'CustFirst72', N'CustLast72', 5, N'FFM72', 3, 1, 2536, 2, 2, 2, CAST(N'2025-11-11T10:51:32.030' AS DateTime), N'Demo Notes 72', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (176, N'Health', N'CustFirst73', N'CustLast73', 3, N'FFM73', 4, 4, 6370, 2, 1, 2, CAST(N'2025-11-15T10:51:32.030' AS DateTime), N'Demo Notes 73', 2, 1, 1, CAST(N'2025-11-09T10:51:32.030' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (177, N'Life', N'CustFirst74', N'CustLast74', 2, N'FFM74', 2, 2, 4301, 1, 1, 1, CAST(N'2025-11-18T10:51:32.033' AS DateTime), N'Demo Notes 74', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (178, N'Life', N'CustFirst75', N'CustLast75', 1, N'FFM75', 3, 1, 3955, 3, 1, 1, CAST(N'2025-11-16T10:51:32.033' AS DateTime), N'Demo Notes 75', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (179, N'Vision', N'CustFirst76', N'CustLast76', 4, N'FFM76', 5, 1, 5518, 3, 1, 2, CAST(N'2025-11-13T10:51:32.033' AS DateTime), N'Demo Notes 76', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (180, N'Life', N'CustFirst77', N'CustLast77', 1, N'FFM77', 4, 3, 3478, 1, 1, 1, CAST(N'2025-11-12T10:51:32.033' AS DateTime), N'Demo Notes 77', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (181, N'Life', N'CustFirst78', N'CustLast78', 1, N'FFM78', 1, 1, 6277, 1, 1, 2, CAST(N'2025-11-18T10:51:32.033' AS DateTime), N'Demo Notes 78', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (182, N'Dental', N'CustFirst79', N'CustLast79', 3, N'FFM79', 5, 3, 3399, 1, 1, 1, CAST(N'2025-11-17T10:51:32.033' AS DateTime), N'Demo Notes 79', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (183, N'Vision', N'CustFirst80', N'CustLast80', 3, N'FFM80', 3, 1, 3992, 2, 2, 1, CAST(N'2025-11-16T10:51:32.033' AS DateTime), N'Demo Notes 80', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (184, N'Dental', N'CustFirst81', N'CustLast81', 4, N'FFM81', 5, 3, 4178, 2, 2, 1, CAST(N'2025-11-11T10:51:32.033' AS DateTime), N'Demo Notes 81', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (185, N'Health', N'CustFirst82', N'CustLast82', 4, N'FFM82', 3, 3, 2831, 2, 2, 2, CAST(N'2025-11-10T10:51:32.033' AS DateTime), N'Demo Notes 82', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (186, N'Health', N'CustFirst83', N'CustLast83', 4, N'FFM83', 1, 4, 4503, 2, 2, 3, CAST(N'2025-11-15T10:51:32.033' AS DateTime), N'Demo Notes 83', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (187, N'Vision', N'CustFirst84', N'CustLast84', 1, N'FFM84', 4, 3, 4675, 2, 2, 3, CAST(N'2025-11-13T10:51:32.033' AS DateTime), N'Demo Notes 84', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (188, N'Life', N'CustFirst85', N'CustLast85', 3, N'FFM85', 3, 4, 5567, 3, 1, 3, CAST(N'2025-11-17T10:51:32.033' AS DateTime), N'Demo Notes 85', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (189, N'Life', N'CustFirst86', N'CustLast86', 1, N'FFM86', 3, 4, 3373, 2, 1, 2, CAST(N'2025-11-11T10:51:32.033' AS DateTime), N'Demo Notes 86', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (190, N'Health', N'CustFirst87', N'CustLast87', 3, N'FFM87', 1, 1, 3051, 2, 2, 1, CAST(N'2025-11-18T10:51:32.033' AS DateTime), N'Demo Notes 87', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (191, N'Vision', N'CustFirst88', N'CustLast88', 4, N'FFM88', 5, 2, 6151, 1, 2, 1, CAST(N'2025-11-14T10:51:32.033' AS DateTime), N'Demo Notes 88', 1, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (192, N'Health', N'CustFirst89', N'CustLast89', 4, N'FFM89', 2, 1, 4260, 1, 2, 1, CAST(N'2025-11-12T10:51:32.033' AS DateTime), N'Demo Notes 89', 2, 1, 1, CAST(N'2025-11-09T10:51:32.033' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (193, N'Life', N'CustFirst90', N'CustLast90', 4, N'FFM90', 2, 1, 5935, 3, 2, 1, CAST(N'2025-11-13T10:51:32.037' AS DateTime), N'Demo Notes 90', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (194, N'Life', N'CustFirst91', N'CustLast91', 2, N'FFM91', 1, 2, 4408, 2, 1, 2, CAST(N'2025-11-15T10:51:32.037' AS DateTime), N'Demo Notes 91', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (195, N'Vision', N'CustFirst92', N'CustLast92', 1, N'FFM92', 4, 4, 6071, 2, 1, 3, CAST(N'2025-11-10T10:51:32.037' AS DateTime), N'Demo Notes 92', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (196, N'Vision', N'CustFirst93', N'CustLast93', 4, N'FFM93', 4, 3, 4255, 1, 2, 2, CAST(N'2025-11-09T10:51:32.037' AS DateTime), N'Demo Notes 93', 1, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (197, N'Health', N'CustFirst94', N'CustLast94', 1, N'FFM94', 5, 1, 4871, 2, 2, 1, CAST(N'2025-11-14T10:51:32.037' AS DateTime), N'Demo Notes 94', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (198, N'Life', N'CustFirst95', N'CustLast95', 5, N'FFM95', 4, 3, 2916, 2, 1, 1, CAST(N'2025-11-16T10:51:32.037' AS DateTime), N'Demo Notes 95', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (199, N'Life', N'CustFirst96', N'CustLast96', 1, N'FFM96', 5, 4, 3116, 3, 1, 1, CAST(N'2025-11-15T10:51:32.037' AS DateTime), N'Demo Notes 96', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (200, N'Life', N'CustFirst97', N'CustLast97', 1, N'FFM97', 4, 2, 4224, 1, 2, 3, CAST(N'2025-11-09T10:51:32.037' AS DateTime), N'Demo Notes 97', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (201, N'Life', N'CustFirst98', N'CustLast98', 5, N'FFM98', 3, 2, 6440, 1, 2, 2, CAST(N'2025-11-15T10:51:32.037' AS DateTime), N'Demo Notes 98', 1, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (202, N'Vision', N'CustFirst99', N'CustLast99', 4, N'FFM99', 1, 3, 4579, 1, 1, 3, CAST(N'2025-11-16T10:51:32.037' AS DateTime), N'Demo Notes 99', 2, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (203, N'Life', N'CustFirst100', N'CustLast100', 1, N'FFM100', 1, 3, 3500, 2, 1, 1, CAST(N'2025-11-18T10:51:32.037' AS DateTime), N'Demo Notes 100', 1, 1, 1, CAST(N'2025-11-09T10:51:32.037' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (204, N'Health', N'First1', N'Last1', 2, N'FFM1', 1, 3, 3886, 2, 2, 2, CAST(N'2025-11-20T11:25:26.890' AS DateTime), N'Notes for deal 1', 4, 1, 1, CAST(N'2025-11-09T11:25:26.890' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (205, N'Vision', N'First2', N'Last2', 3, N'FFM2', 1, 3, 5857, 2, 2, 1, CAST(N'2025-11-10T11:25:26.890' AS DateTime), N'Notes for deal 2', 3, 1, 1, CAST(N'2025-11-09T11:25:26.890' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (206, N'Life', N'First3', N'Last3', 4, N'FFM3', 2, 4, 5028, 3, 1, 3, CAST(N'2025-11-16T11:25:26.890' AS DateTime), N'Notes for deal 3', 4, 1, 1, CAST(N'2025-11-09T11:25:26.890' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (207, N'Vision', N'First4', N'Last4', 4, N'FFM4', 1, 1, 5638, 3, 1, 2, CAST(N'2025-11-16T11:25:26.890' AS DateTime), N'Notes for deal 4', 5, 1, 1, CAST(N'2025-11-09T11:25:26.890' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (208, N'Dental', N'First5', N'Last5', 2, N'FFM5', 5, 3, 2935, 3, 2, 1, CAST(N'2025-11-11T11:25:26.890' AS DateTime), N'Notes for deal 5', 4, 1, 1, CAST(N'2025-11-09T11:25:26.890' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (209, N'Life', N'First6', N'Last6', 4, N'FFM6', 3, 2, 5687, 1, 2, 2, CAST(N'2025-11-21T11:25:26.890' AS DateTime), N'Notes for deal 6', 4, 1, 1, CAST(N'2025-11-09T11:25:26.890' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (210, N'Life', N'First7', N'Last7', 5, N'FFM7', 4, 1, 5323, 1, 2, 1, CAST(N'2025-11-22T11:25:26.893' AS DateTime), N'Notes for deal 7', 3, 1, 1, CAST(N'2025-11-09T11:25:26.893' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (211, N'Health', N'First8', N'Last8', 4, N'FFM8', 1, 4, 3826, 2, 1, 2, CAST(N'2025-11-19T11:25:26.893' AS DateTime), N'Notes for deal 8', 4, 1, 1, CAST(N'2025-11-09T11:25:26.893' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (212, N'Health', N'First9', N'Last9', 1, N'FFM9', 5, 1, 2806, 2, 2, 1, CAST(N'2025-11-18T11:25:26.893' AS DateTime), N'Notes for deal 9', 3, 1, 1, CAST(N'2025-11-09T11:25:26.893' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (213, N'Vision', N'First10', N'Last10', 5, N'FFM10', 2, 3, 4131, 3, 2, 3, CAST(N'2025-11-10T11:25:26.893' AS DateTime), N'Notes for deal 10', 5, 1, 1, CAST(N'2025-11-09T11:25:26.893' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (214, N'Health', N'First11', N'Last11', 1, N'FFM11', 5, 3, 2104, 3, 2, 3, CAST(N'2025-11-24T11:25:26.893' AS DateTime), N'Notes for deal 11', 3, 1, 1, CAST(N'2025-11-09T11:25:26.893' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (215, N'Life', N'First12', N'Last12', 5, N'FFM12', 2, 1, 3417, 2, 1, 3, CAST(N'2025-11-24T11:25:26.893' AS DateTime), N'Notes for deal 12', 3, 1, 1, CAST(N'2025-11-09T11:25:26.893' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (216, N'Health', N'First13', N'Last13', 1, N'FFM13', 3, 3, 3261, 1, 1, 1, CAST(N'2025-11-27T11:25:26.897' AS DateTime), N'Notes for deal 13', 5, 1, 1, CAST(N'2025-11-09T11:25:26.897' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (217, N'Health', N'First14', N'Last14', 3, N'FFM14', 3, 3, 4140, 3, 2, 1, CAST(N'2025-11-20T11:25:26.897' AS DateTime), N'Notes for deal 14', 5, 1, 1, CAST(N'2025-11-09T11:25:26.897' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (218, N'Vision', N'First15', N'Last15', 4, N'FFM15', 3, 4, 4870, 3, 1, 2, CAST(N'2025-11-13T11:25:26.897' AS DateTime), N'Notes for deal 15', 4, 1, 1, CAST(N'2025-11-09T11:25:26.897' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (219, N'Dental', N'First16', N'Last16', 4, N'FFM16', 4, 3, 3619, 3, 1, 1, CAST(N'2025-11-12T11:25:26.897' AS DateTime), N'Notes for deal 16', 4, 1, 1, CAST(N'2025-11-09T11:25:26.897' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (220, N'Dental', N'First17', N'Last17', 4, N'FFM17', 5, 1, 4013, 1, 1, 1, CAST(N'2025-11-25T11:25:26.897' AS DateTime), N'Notes for deal 17', 3, 1, 1, CAST(N'2025-11-09T11:25:26.897' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (221, N'Life', N'First18', N'Last18', 3, N'FFM18', 4, 4, 4448, 1, 1, 2, CAST(N'2025-11-20T11:25:26.897' AS DateTime), N'Notes for deal 18', 5, 1, 1, CAST(N'2025-11-09T11:25:26.897' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (222, N'Life', N'First19', N'Last19', 5, N'FFM19', 5, 3, 4397, 1, 1, 1, CAST(N'2025-11-16T11:25:26.900' AS DateTime), N'Notes for deal 19', 5, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (223, N'Health', N'First20', N'Last20', 1, N'FFM20', 3, 4, 3698, 2, 1, 1, CAST(N'2025-11-15T11:25:26.900' AS DateTime), N'Notes for deal 20', 5, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (224, N'Life', N'First21', N'Last21', 2, N'FFM21', 3, 3, 2567, 1, 1, 1, CAST(N'2025-11-27T11:25:26.900' AS DateTime), N'Notes for deal 21', 3, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (225, N'Life', N'First22', N'Last22', 2, N'FFM22', 2, 4, 2421, 2, 1, 3, CAST(N'2025-11-17T11:25:26.900' AS DateTime), N'Notes for deal 22', 4, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (226, N'Health', N'First23', N'Last23', 2, N'FFM23', 5, 1, 4736, 1, 1, 2, CAST(N'2025-11-16T11:25:26.900' AS DateTime), N'Notes for deal 23', 4, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (227, N'Health', N'First24', N'Last24', 4, N'FFM24', 4, 2, 3341, 3, 2, 3, CAST(N'2025-11-11T11:25:26.900' AS DateTime), N'Notes for deal 24', 5, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (228, N'Life', N'First25', N'Last25', 5, N'FFM25', 4, 2, 2951, 3, 1, 2, CAST(N'2025-11-26T11:25:26.900' AS DateTime), N'Notes for deal 25', 4, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (229, N'Life', N'First26', N'Last26', 3, N'FFM26', 4, 1, 4839, 3, 1, 3, CAST(N'2025-11-18T11:25:26.900' AS DateTime), N'Notes for deal 26', 5, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (230, N'Health', N'First27', N'Last27', 1, N'FFM27', 4, 4, 4801, 3, 2, 1, CAST(N'2025-11-14T11:25:26.900' AS DateTime), N'Notes for deal 27', 4, 1, 1, CAST(N'2025-11-09T11:25:26.900' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (231, N'Vision', N'First28', N'Last28', 3, N'FFM28', 4, 2, 2385, 3, 2, 1, CAST(N'2025-11-28T11:25:26.903' AS DateTime), N'Notes for deal 28', 5, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (232, N'Life', N'First29', N'Last29', 1, N'FFM29', 5, 2, 2117, 2, 2, 3, CAST(N'2025-11-23T11:25:26.903' AS DateTime), N'Notes for deal 29', 3, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (233, N'Dental', N'First30', N'Last30', 5, N'FFM30', 1, 2, 4170, 2, 1, 3, CAST(N'2025-11-19T11:25:26.903' AS DateTime), N'Notes for deal 30', 4, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (234, N'Life', N'First31', N'Last31', 1, N'FFM31', 2, 2, 4519, 3, 2, 2, CAST(N'2025-11-24T11:25:26.903' AS DateTime), N'Notes for deal 31', 5, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (235, N'Life', N'First32', N'Last32', 2, N'FFM32', 5, 3, 2842, 3, 2, 1, CAST(N'2025-11-15T11:25:26.903' AS DateTime), N'Notes for deal 32', 5, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (236, N'Life', N'First33', N'Last33', 5, N'FFM33', 4, 1, 4657, 1, 2, 3, CAST(N'2025-11-17T11:25:26.903' AS DateTime), N'Notes for deal 33', 4, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (237, N'Life', N'First34', N'Last34', 2, N'FFM34', 4, 2, 3836, 1, 2, 2, CAST(N'2025-11-15T11:25:26.903' AS DateTime), N'Notes for deal 34', 3, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (238, N'Dental', N'First35', N'Last35', 4, N'FFM35', 3, 1, 3993, 3, 2, 1, CAST(N'2025-11-25T11:25:26.903' AS DateTime), N'Notes for deal 35', 3, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (239, N'Vision', N'First36', N'Last36', 4, N'FFM36', 2, 4, 3875, 2, 1, 2, CAST(N'2025-11-28T11:25:26.903' AS DateTime), N'Notes for deal 36', 5, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (240, N'Dental', N'First37', N'Last37', 4, N'FFM37', 5, 3, 3464, 3, 2, 2, CAST(N'2025-11-19T11:25:26.903' AS DateTime), N'Notes for deal 37', 4, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (241, N'Dental', N'First38', N'Last38', 3, N'FFM38', 5, 3, 4828, 2, 2, 3, CAST(N'2025-11-19T11:25:26.903' AS DateTime), N'Notes for deal 38', 5, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (242, N'Health', N'First39', N'Last39', 4, N'FFM39', 5, 3, 2467, 3, 2, 2, CAST(N'2025-11-13T11:25:26.903' AS DateTime), N'Notes for deal 39', 3, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (243, N'Vision', N'First40', N'Last40', 3, N'FFM40', 5, 2, 4389, 3, 1, 1, CAST(N'2025-11-23T11:25:26.903' AS DateTime), N'Notes for deal 40', 5, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (244, N'Life', N'First41', N'Last41', 5, N'FFM41', 4, 3, 5508, 3, 2, 2, CAST(N'2025-11-23T11:25:26.903' AS DateTime), N'Notes for deal 41', 4, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (245, N'Vision', N'First42', N'Last42', 4, N'FFM42', 5, 1, 5660, 2, 2, 3, CAST(N'2025-11-15T11:25:26.903' AS DateTime), N'Notes for deal 42', 3, 1, 1, CAST(N'2025-11-09T11:25:26.903' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (246, N'Life', N'First43', N'Last43', 5, N'FFM43', 3, 3, 3080, 2, 1, 1, CAST(N'2025-11-09T11:25:26.907' AS DateTime), N'Notes for deal 43', 5, 1, 1, CAST(N'2025-11-09T11:25:26.907' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (247, N'Life', N'First44', N'Last44', 5, N'FFM44', 4, 2, 4458, 3, 2, 1, CAST(N'2025-11-23T11:25:26.910' AS DateTime), N'Notes for deal 44', 5, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (248, N'Life', N'First45', N'Last45', 5, N'FFM45', 3, 4, 5933, 1, 2, 1, CAST(N'2025-11-19T11:25:26.910' AS DateTime), N'Notes for deal 45', 4, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (249, N'Life', N'First46', N'Last46', 5, N'FFM46', 5, 4, 5557, 1, 2, 2, CAST(N'2025-11-21T11:25:26.910' AS DateTime), N'Notes for deal 46', 5, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (250, N'Life', N'First47', N'Last47', 5, N'FFM47', 1, 2, 3697, 2, 2, 2, CAST(N'2025-11-14T11:25:26.910' AS DateTime), N'Notes for deal 47', 4, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (251, N'Life', N'First48', N'Last48', 4, N'FFM48', 5, 1, 5089, 3, 1, 1, CAST(N'2025-11-28T11:25:26.910' AS DateTime), N'Notes for deal 48', 3, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (252, N'Health', N'First49', N'Last49', 5, N'FFM49', 4, 4, 3234, 1, 2, 3, CAST(N'2025-11-15T11:25:26.910' AS DateTime), N'Notes for deal 49', 3, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (253, N'Dental', N'First50', N'Last50', 2, N'FFM50', 2, 3, 5361, 2, 2, 2, CAST(N'2025-11-15T11:25:26.910' AS DateTime), N'Notes for deal 50', 3, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (254, N'Life', N'First51', N'Last51', 5, N'FFM51', 2, 2, 2008, 1, 1, 3, CAST(N'2025-11-14T11:25:26.910' AS DateTime), N'Notes for deal 51', 5, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (255, N'Dental', N'First52', N'Last52', 4, N'FFM52', 2, 2, 2993, 2, 1, 3, CAST(N'2025-11-13T11:25:26.910' AS DateTime), N'Notes for deal 52', 5, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (256, N'Health', N'First53', N'Last53', 4, N'FFM53', 3, 2, 2230, 3, 2, 1, CAST(N'2025-11-15T11:25:26.910' AS DateTime), N'Notes for deal 53', 4, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (257, N'Dental', N'First54', N'Last54', 4, N'FFM54', 2, 2, 3395, 1, 2, 3, CAST(N'2025-11-20T11:25:26.910' AS DateTime), N'Notes for deal 54', 3, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (258, N'Vision', N'First55', N'Last55', 5, N'FFM55', 5, 4, 2130, 1, 2, 1, CAST(N'2025-11-13T11:25:26.910' AS DateTime), N'Notes for deal 55', 3, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (259, N'Health', N'First56', N'Last56', 4, N'FFM56', 3, 2, 5304, 1, 2, 1, CAST(N'2025-11-10T11:25:26.910' AS DateTime), N'Notes for deal 56', 3, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (260, N'Dental', N'First57', N'Last57', 4, N'FFM57', 4, 2, 3426, 1, 1, 1, CAST(N'2025-11-17T11:25:26.910' AS DateTime), N'Notes for deal 57', 5, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (261, N'Dental', N'First58', N'Last58', 4, N'FFM58', 1, 2, 3891, 2, 2, 1, CAST(N'2025-11-16T11:25:26.910' AS DateTime), N'Notes for deal 58', 4, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (262, N'Life', N'First59', N'Last59', 3, N'FFM59', 2, 2, 4914, 1, 1, 3, CAST(N'2025-11-26T11:25:26.910' AS DateTime), N'Notes for deal 59', 5, 1, 1, CAST(N'2025-11-09T11:25:26.910' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (263, N'Health', N'First60', N'Last60', 1, N'FFM60', 1, 2, 4573, 1, 1, 2, CAST(N'2025-11-17T11:25:26.913' AS DateTime), N'Notes for deal 60', 4, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (264, N'Vision', N'First61', N'Last61', 5, N'FFM61', 2, 4, 3502, 1, 1, 1, CAST(N'2025-11-18T11:25:26.913' AS DateTime), N'Notes for deal 61', 3, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (265, N'Vision', N'First62', N'Last62', 4, N'FFM62', 5, 2, 2406, 1, 2, 1, CAST(N'2025-11-15T11:25:26.913' AS DateTime), N'Notes for deal 62', 4, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (266, N'Vision', N'First63', N'Last63', 1, N'FFM63', 1, 1, 2104, 2, 1, 2, CAST(N'2025-11-22T11:25:26.913' AS DateTime), N'Notes for deal 63', 5, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (267, N'Life', N'First64', N'Last64', 4, N'FFM64', 1, 2, 3382, 1, 2, 3, CAST(N'2025-11-16T11:25:26.913' AS DateTime), N'Notes for deal 64', 4, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (268, N'Vision', N'First65', N'Last65', 4, N'FFM65', 1, 4, 5741, 2, 1, 3, CAST(N'2025-11-17T11:25:26.913' AS DateTime), N'Notes for deal 65', 5, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (269, N'Life', N'First66', N'Last66', 4, N'FFM66', 3, 3, 4695, 3, 1, 1, CAST(N'2025-11-27T11:25:26.913' AS DateTime), N'Notes for deal 66', 5, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (270, N'Vision', N'First67', N'Last67', 3, N'FFM67', 4, 3, 2204, 1, 2, 2, CAST(N'2025-11-22T11:25:26.913' AS DateTime), N'Notes for deal 67', 3, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (271, N'Life', N'First68', N'Last68', 5, N'FFM68', 4, 4, 5061, 1, 1, 1, CAST(N'2025-11-22T11:25:26.913' AS DateTime), N'Notes for deal 68', 4, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (272, N'Dental', N'First69', N'Last69', 5, N'FFM69', 3, 4, 2750, 1, 1, 2, CAST(N'2025-11-09T11:25:26.913' AS DateTime), N'Notes for deal 69', 3, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (273, N'Health', N'First70', N'Last70', 1, N'FFM70', 2, 4, 4993, 2, 1, 1, CAST(N'2025-11-22T11:25:26.913' AS DateTime), N'Notes for deal 70', 3, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (274, N'Vision', N'First71', N'Last71', 2, N'FFM71', 2, 4, 2591, 2, 1, 1, CAST(N'2025-11-21T11:25:26.913' AS DateTime), N'Notes for deal 71', 5, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (275, N'Vision', N'First72', N'Last72', 4, N'FFM72', 4, 1, 2120, 2, 2, 3, CAST(N'2025-11-09T11:25:26.913' AS DateTime), N'Notes for deal 72', 3, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (276, N'Life', N'First73', N'Last73', 1, N'FFM73', 4, 2, 4475, 3, 1, 1, CAST(N'2025-11-11T11:25:26.913' AS DateTime), N'Notes for deal 73', 5, 1, 1, CAST(N'2025-11-09T11:25:26.913' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (277, N'Health', N'First74', N'Last74', 5, N'FFM74', 5, 3, 3757, 1, 2, 1, CAST(N'2025-11-26T11:25:26.917' AS DateTime), N'Notes for deal 74', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (278, N'Life', N'First75', N'Last75', 3, N'FFM75', 4, 3, 5155, 2, 2, 3, CAST(N'2025-11-15T11:25:26.917' AS DateTime), N'Notes for deal 75', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (279, N'Dental', N'First76', N'Last76', 5, N'FFM76', 5, 1, 3901, 3, 2, 1, CAST(N'2025-11-20T11:25:26.917' AS DateTime), N'Notes for deal 76', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (280, N'Dental', N'First77', N'Last77', 5, N'FFM77', 5, 1, 4375, 2, 1, 1, CAST(N'2025-11-12T11:25:26.917' AS DateTime), N'Notes for deal 77', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (281, N'Dental', N'First78', N'Last78', 4, N'FFM78', 4, 4, 3578, 3, 1, 1, CAST(N'2025-11-21T11:25:26.917' AS DateTime), N'Notes for deal 78', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (282, N'Dental', N'First79', N'Last79', 5, N'FFM79', 2, 1, 5414, 1, 1, 3, CAST(N'2025-11-12T11:25:26.917' AS DateTime), N'Notes for deal 79', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (283, N'Life', N'First80', N'Last80', 4, N'FFM80', 1, 4, 5667, 3, 2, 1, CAST(N'2025-11-10T11:25:26.917' AS DateTime), N'Notes for deal 80', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (284, N'Dental', N'First81', N'Last81', 4, N'FFM81', 5, 3, 5833, 2, 2, 3, CAST(N'2025-11-11T11:25:26.917' AS DateTime), N'Notes for deal 81', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (285, N'Life', N'First82', N'Last82', 5, N'FFM82', 1, 3, 5617, 1, 2, 1, CAST(N'2025-11-25T11:25:26.917' AS DateTime), N'Notes for deal 82', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (286, N'Dental', N'First83', N'Last83', 2, N'FFM83', 2, 3, 5649, 3, 2, 2, CAST(N'2025-11-11T11:25:26.917' AS DateTime), N'Notes for deal 83', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (287, N'Life', N'First84', N'Last84', 3, N'FFM84', 2, 1, 4082, 2, 2, 2, CAST(N'2025-11-27T11:25:26.917' AS DateTime), N'Notes for deal 84', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (288, N'Life', N'First85', N'Last85', 3, N'FFM85', 2, 2, 4188, 2, 2, 3, CAST(N'2025-11-26T11:25:26.917' AS DateTime), N'Notes for deal 85', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (289, N'Life', N'First86', N'Last86', 4, N'FFM86', 1, 3, 4583, 2, 2, 1, CAST(N'2025-11-25T11:25:26.917' AS DateTime), N'Notes for deal 86', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (290, N'Life', N'First87', N'Last87', 2, N'FFM87', 2, 3, 2943, 3, 1, 3, CAST(N'2025-11-28T11:25:26.917' AS DateTime), N'Notes for deal 87', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (291, N'Dental', N'First88', N'Last88', 5, N'FFM88', 5, 3, 4327, 2, 1, 2, CAST(N'2025-11-12T11:25:26.917' AS DateTime), N'Notes for deal 88', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (292, N'Life', N'First89', N'Last89', 1, N'FFM89', 4, 2, 4162, 2, 2, 2, CAST(N'2025-11-11T11:25:26.917' AS DateTime), N'Notes for deal 89', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (293, N'Dental', N'First90', N'Last90', 4, N'FFM90', 4, 2, 4817, 2, 2, 2, CAST(N'2025-11-22T11:25:26.917' AS DateTime), N'Notes for deal 90', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (294, N'Life', N'First91', N'Last91', 5, N'FFM91', 1, 1, 2846, 2, 1, 2, CAST(N'2025-11-24T11:25:26.917' AS DateTime), N'Notes for deal 91', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (295, N'Life', N'First92', N'Last92', 4, N'FFM92', 2, 2, 2854, 2, 1, 1, CAST(N'2025-11-22T11:25:26.917' AS DateTime), N'Notes for deal 92', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (296, N'Life', N'First93', N'Last93', 3, N'FFM93', 3, 3, 4171, 3, 2, 2, CAST(N'2025-11-14T11:25:26.917' AS DateTime), N'Notes for deal 93', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (297, N'Life', N'First94', N'Last94', 3, N'FFM94', 4, 3, 5750, 2, 1, 1, CAST(N'2025-11-19T11:25:26.917' AS DateTime), N'Notes for deal 94', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (298, N'Dental', N'First95', N'Last95', 2, N'FFM95', 4, 3, 2041, 1, 1, 1, CAST(N'2025-11-16T11:25:26.917' AS DateTime), N'Notes for deal 95', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (299, N'Health', N'First96', N'Last96', 4, N'FFM96', 4, 4, 3875, 3, 2, 1, CAST(N'2025-11-25T11:25:26.917' AS DateTime), N'Notes for deal 96', 4, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (300, N'Vision', N'First97', N'Last97', 2, N'FFM97', 1, 3, 3404, 1, 2, 1, CAST(N'2025-11-22T11:25:26.917' AS DateTime), N'Notes for deal 97', 5, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (301, N'Life', N'First98', N'Last98', 5, N'FFM98', 4, 4, 5781, 1, 2, 2, CAST(N'2025-11-10T11:25:26.917' AS DateTime), N'Notes for deal 98', 3, 1, 1, CAST(N'2025-11-09T11:25:26.917' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (302, N'Life', N'First99', N'Last99', 3, N'FFM99', 4, 2, 2343, 1, 1, 2, CAST(N'2025-11-27T11:25:26.920' AS DateTime), N'Notes for deal 99', 5, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (303, N'Dental', N'First100', N'Last100', 1, N'FFM100', 2, 4, 5147, 1, 2, 3, CAST(N'2025-11-15T11:25:26.920' AS DateTime), N'Notes for deal 100', 3, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (304, N'Life', N'First101', N'Last101', 3, N'FFM101', 2, 3, 2809, 2, 1, 2, CAST(N'2025-11-19T11:25:26.920' AS DateTime), N'Notes for deal 101', 3, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (305, N'Health', N'First102', N'Last102', 2, N'FFM102', 4, 2, 4609, 1, 2, 1, CAST(N'2025-11-15T11:25:26.920' AS DateTime), N'Notes for deal 102', 5, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (306, N'Life', N'First103', N'Last103', 3, N'FFM103', 1, 3, 4190, 2, 2, 3, CAST(N'2025-11-15T11:25:26.920' AS DateTime), N'Notes for deal 103', 4, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (307, N'Life', N'First104', N'Last104', 1, N'FFM104', 5, 1, 4951, 3, 2, 2, CAST(N'2025-11-18T11:25:26.920' AS DateTime), N'Notes for deal 104', 3, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (308, N'Vision', N'First105', N'Last105', 2, N'FFM105', 3, 2, 4266, 3, 2, 1, CAST(N'2025-11-18T11:25:26.920' AS DateTime), N'Notes for deal 105', 3, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (309, N'Health', N'First106', N'Last106', 5, N'FFM106', 4, 4, 5665, 2, 2, 3, CAST(N'2025-11-27T11:25:26.920' AS DateTime), N'Notes for deal 106', 5, 1, 1, CAST(N'2025-11-09T11:25:26.920' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (310, N'Life', N'First107', N'Last107', 1, N'FFM107', 5, 2, 5189, 3, 2, 2, CAST(N'2025-11-14T11:25:26.923' AS DateTime), N'Notes for deal 107', 3, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (311, N'Dental', N'First108', N'Last108', 2, N'FFM108', 5, 3, 2826, 2, 1, 1, CAST(N'2025-11-26T11:25:26.923' AS DateTime), N'Notes for deal 108', 3, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (312, N'Health', N'First109', N'Last109', 2, N'FFM109', 5, 3, 2382, 1, 2, 3, CAST(N'2025-11-26T11:25:26.923' AS DateTime), N'Notes for deal 109', 4, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (313, N'Health', N'First110', N'Last110', 5, N'FFM110', 5, 2, 3047, 1, 2, 1, CAST(N'2025-11-25T11:25:26.923' AS DateTime), N'Notes for deal 110', 3, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (314, N'Dental', N'First111', N'Last111', 5, N'FFM111', 3, 2, 2095, 3, 1, 1, CAST(N'2025-11-28T11:25:26.923' AS DateTime), N'Notes for deal 111', 4, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (315, N'Health', N'First112', N'Last112', 2, N'FFM112', 1, 3, 4935, 2, 1, 3, CAST(N'2025-11-22T11:25:26.923' AS DateTime), N'Notes for deal 112', 5, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (316, N'Health', N'First113', N'Last113', 5, N'FFM113', 3, 1, 4854, 3, 1, 2, CAST(N'2025-11-19T11:25:26.923' AS DateTime), N'Notes for deal 113', 5, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (317, N'Health', N'First114', N'Last114', 3, N'FFM114', 2, 2, 2135, 2, 2, 1, CAST(N'2025-11-26T11:25:26.923' AS DateTime), N'Notes for deal 114', 3, 1, 1, CAST(N'2025-11-09T11:25:26.923' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (318, N'Life', N'First115', N'Last115', 1, N'FFM115', 3, 1, 4293, 3, 2, 1, CAST(N'2025-11-28T11:25:26.927' AS DateTime), N'Notes for deal 115', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (319, N'Life', N'First116', N'Last116', 3, N'FFM116', 2, 4, 5444, 3, 1, 2, CAST(N'2025-11-17T11:25:26.927' AS DateTime), N'Notes for deal 116', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (320, N'Health', N'First117', N'Last117', 3, N'FFM117', 2, 4, 4747, 3, 1, 2, CAST(N'2025-11-09T11:25:26.927' AS DateTime), N'Notes for deal 117', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (321, N'Life', N'First118', N'Last118', 5, N'FFM118', 3, 4, 2782, 2, 2, 3, CAST(N'2025-11-13T11:25:26.927' AS DateTime), N'Notes for deal 118', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (322, N'Life', N'First119', N'Last119', 4, N'FFM119', 2, 1, 5317, 1, 2, 1, CAST(N'2025-11-20T11:25:26.927' AS DateTime), N'Notes for deal 119', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (323, N'Vision', N'First120', N'Last120', 2, N'FFM120', 3, 4, 3658, 3, 2, 2, CAST(N'2025-11-21T11:25:26.927' AS DateTime), N'Notes for deal 120', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (324, N'Life', N'First121', N'Last121', 2, N'FFM121', 3, 1, 5059, 1, 2, 2, CAST(N'2025-11-27T11:25:26.927' AS DateTime), N'Notes for deal 121', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (325, N'Vision', N'First122', N'Last122', 3, N'FFM122', 1, 3, 3211, 2, 1, 3, CAST(N'2025-11-22T11:25:26.927' AS DateTime), N'Notes for deal 122', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (326, N'Life', N'First123', N'Last123', 3, N'FFM123', 2, 4, 2560, 1, 1, 3, CAST(N'2025-11-19T11:25:26.927' AS DateTime), N'Notes for deal 123', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (327, N'Vision', N'First124', N'Last124', 4, N'FFM124', 1, 4, 5425, 2, 1, 1, CAST(N'2025-11-13T11:25:26.927' AS DateTime), N'Notes for deal 124', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (328, N'Life', N'First125', N'Last125', 1, N'FFM125', 1, 1, 5653, 2, 1, 1, CAST(N'2025-11-11T11:25:26.927' AS DateTime), N'Notes for deal 125', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (329, N'Life', N'First126', N'Last126', 4, N'FFM126', 4, 2, 3583, 2, 1, 2, CAST(N'2025-11-19T11:25:26.927' AS DateTime), N'Notes for deal 126', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (330, N'Vision', N'First127', N'Last127', 4, N'FFM127', 2, 3, 4855, 2, 1, 1, CAST(N'2025-11-11T11:25:26.927' AS DateTime), N'Notes for deal 127', 4, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (331, N'Health', N'First128', N'Last128', 5, N'FFM128', 3, 1, 2927, 2, 1, 2, CAST(N'2025-11-10T11:25:26.927' AS DateTime), N'Notes for deal 128', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (332, N'Life', N'First129', N'Last129', 5, N'FFM129', 5, 4, 2530, 3, 1, 3, CAST(N'2025-11-17T11:25:26.927' AS DateTime), N'Notes for deal 129', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (333, N'Life', N'First130', N'Last130', 2, N'FFM130', 4, 3, 3374, 2, 1, 3, CAST(N'2025-11-24T11:25:26.927' AS DateTime), N'Notes for deal 130', 4, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (334, N'Life', N'First131', N'Last131', 5, N'FFM131', 1, 2, 5836, 3, 2, 3, CAST(N'2025-11-15T11:25:26.927' AS DateTime), N'Notes for deal 131', 5, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (335, N'Health', N'First132', N'Last132', 1, N'FFM132', 1, 3, 2056, 1, 2, 1, CAST(N'2025-11-22T11:25:26.927' AS DateTime), N'Notes for deal 132', 3, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (336, N'Life', N'First133', N'Last133', 2, N'FFM133', 4, 4, 4023, 2, 1, 3, CAST(N'2025-11-22T11:25:26.927' AS DateTime), N'Notes for deal 133', 4, 1, 1, CAST(N'2025-11-09T11:25:26.927' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (337, N'Health', N'First134', N'Last134', 2, N'FFM134', 1, 3, 2219, 2, 1, 3, CAST(N'2025-11-15T11:25:26.930' AS DateTime), N'Notes for deal 134', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (338, N'Life', N'First135', N'Last135', 5, N'FFM135', 2, 2, 3600, 3, 2, 3, CAST(N'2025-11-10T11:25:26.930' AS DateTime), N'Notes for deal 135', 5, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (339, N'Life', N'First136', N'Last136', 5, N'FFM136', 4, 2, 3529, 3, 2, 1, CAST(N'2025-11-20T11:25:26.930' AS DateTime), N'Notes for deal 136', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (340, N'Life', N'First137', N'Last137', 1, N'FFM137', 5, 4, 3024, 1, 1, 1, CAST(N'2025-11-24T11:25:26.930' AS DateTime), N'Notes for deal 137', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (341, N'Health', N'First138', N'Last138', 1, N'FFM138', 2, 4, 3665, 2, 1, 1, CAST(N'2025-11-15T11:25:26.930' AS DateTime), N'Notes for deal 138', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (342, N'Dental', N'First139', N'Last139', 3, N'FFM139', 5, 4, 3709, 3, 2, 3, CAST(N'2025-11-09T11:25:26.930' AS DateTime), N'Notes for deal 139', 5, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (343, N'Life', N'First140', N'Last140', 2, N'FFM140', 5, 3, 4431, 1, 1, 2, CAST(N'2025-11-23T11:25:26.930' AS DateTime), N'Notes for deal 140', 3, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (344, N'Dental', N'First141', N'Last141', 2, N'FFM141', 4, 2, 2914, 1, 1, 2, CAST(N'2025-11-27T11:25:26.930' AS DateTime), N'Notes for deal 141', 5, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (345, N'Life', N'First142', N'Last142', 5, N'FFM142', 1, 3, 4873, 1, 1, 3, CAST(N'2025-11-24T11:25:26.930' AS DateTime), N'Notes for deal 142', 3, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (346, N'Vision', N'First143', N'Last143', 2, N'FFM143', 5, 3, 5791, 1, 1, 2, CAST(N'2025-11-19T11:25:26.930' AS DateTime), N'Notes for deal 143', 5, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (347, N'Life', N'First144', N'Last144', 4, N'FFM144', 3, 1, 4378, 3, 2, 3, CAST(N'2025-11-12T11:25:26.930' AS DateTime), N'Notes for deal 144', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (348, N'Dental', N'First145', N'Last145', 2, N'FFM145', 2, 4, 4328, 2, 2, 3, CAST(N'2025-11-20T11:25:26.930' AS DateTime), N'Notes for deal 145', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (349, N'Dental', N'First146', N'Last146', 2, N'FFM146', 5, 3, 2264, 3, 2, 2, CAST(N'2025-11-17T11:25:26.930' AS DateTime), N'Notes for deal 146', 5, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (350, N'Life', N'First147', N'Last147', 2, N'FFM147', 3, 3, 4115, 2, 1, 3, CAST(N'2025-11-13T11:25:26.930' AS DateTime), N'Notes for deal 147', 3, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (351, N'Life', N'First148', N'Last148', 5, N'FFM148', 3, 1, 3881, 1, 2, 3, CAST(N'2025-11-27T11:25:26.930' AS DateTime), N'Notes for deal 148', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (352, N'Vision', N'First149', N'Last149', 3, N'FFM149', 1, 4, 2820, 3, 2, 1, CAST(N'2025-11-19T11:25:26.930' AS DateTime), N'Notes for deal 149', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (353, N'Life', N'First150', N'Last150', 4, N'FFM150', 4, 3, 4426, 3, 1, 2, CAST(N'2025-11-19T11:25:26.930' AS DateTime), N'Notes for deal 150', 3, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (354, N'Health', N'First151', N'Last151', 4, N'FFM151', 3, 4, 2059, 3, 1, 2, CAST(N'2025-11-20T11:25:26.930' AS DateTime), N'Notes for deal 151', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (355, N'Vision', N'First152', N'Last152', 1, N'FFM152', 4, 2, 3201, 1, 1, 2, CAST(N'2025-11-25T11:25:26.930' AS DateTime), N'Notes for deal 152', 5, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (356, N'Life', N'First153', N'Last153', 1, N'FFM153', 1, 3, 5860, 1, 2, 3, CAST(N'2025-11-26T11:25:26.930' AS DateTime), N'Notes for deal 153', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (357, N'Life', N'First154', N'Last154', 2, N'FFM154', 1, 2, 4485, 3, 1, 2, CAST(N'2025-11-23T11:25:26.930' AS DateTime), N'Notes for deal 154', 4, 1, 1, CAST(N'2025-11-09T11:25:26.930' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (358, N'Health', N'First155', N'Last155', 2, N'FFM155', 1, 1, 4093, 3, 1, 1, CAST(N'2025-11-14T11:25:26.933' AS DateTime), N'Notes for deal 155', 5, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (359, N'Health', N'First156', N'Last156', 1, N'FFM156', 3, 2, 5847, 3, 1, 1, CAST(N'2025-11-21T11:25:26.933' AS DateTime), N'Notes for deal 156', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (360, N'Life', N'First157', N'Last157', 4, N'FFM157', 4, 2, 5545, 1, 2, 3, CAST(N'2025-11-19T11:25:26.933' AS DateTime), N'Notes for deal 157', 4, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (361, N'Health', N'First158', N'Last158', 3, N'FFM158', 5, 3, 4783, 1, 1, 2, CAST(N'2025-11-15T11:25:26.933' AS DateTime), N'Notes for deal 158', 4, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (362, N'Life', N'First159', N'Last159', 2, N'FFM159', 4, 2, 3617, 1, 2, 3, CAST(N'2025-11-25T11:25:26.933' AS DateTime), N'Notes for deal 159', 4, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (363, N'Life', N'First160', N'Last160', 3, N'FFM160', 4, 3, 3990, 3, 2, 1, CAST(N'2025-11-25T11:25:26.933' AS DateTime), N'Notes for deal 160', 5, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (364, N'Health', N'First161', N'Last161', 5, N'FFM161', 2, 4, 3678, 2, 1, 1, CAST(N'2025-11-17T11:25:26.933' AS DateTime), N'Notes for deal 161', 4, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (365, N'Health', N'First162', N'Last162', 2, N'FFM162', 3, 3, 4482, 3, 2, 3, CAST(N'2025-11-15T11:25:26.933' AS DateTime), N'Notes for deal 162', 4, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (366, N'Life', N'First163', N'Last163', 1, N'FFM163', 4, 3, 5339, 3, 1, 2, CAST(N'2025-11-24T11:25:26.933' AS DateTime), N'Notes for deal 163', 5, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (367, N'Life', N'First164', N'Last164', 3, N'FFM164', 3, 1, 5017, 2, 2, 1, CAST(N'2025-11-25T11:25:26.933' AS DateTime), N'Notes for deal 164', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (368, N'Life', N'First165', N'Last165', 1, N'FFM165', 4, 1, 4158, 3, 2, 1, CAST(N'2025-11-10T11:25:26.933' AS DateTime), N'Notes for deal 165', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (369, N'Vision', N'First166', N'Last166', 3, N'FFM166', 3, 2, 3162, 3, 1, 3, CAST(N'2025-11-27T11:25:26.933' AS DateTime), N'Notes for deal 166', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (370, N'Vision', N'First167', N'Last167', 2, N'FFM167', 1, 2, 4802, 3, 2, 2, CAST(N'2025-11-26T11:25:26.933' AS DateTime), N'Notes for deal 167', 4, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (371, N'Dental', N'First168', N'Last168', 2, N'FFM168', 5, 1, 5460, 1, 1, 3, CAST(N'2025-11-20T11:25:26.933' AS DateTime), N'Notes for deal 168', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (372, N'Vision', N'First169', N'Last169', 5, N'FFM169', 3, 3, 2898, 1, 2, 1, CAST(N'2025-11-25T11:25:26.933' AS DateTime), N'Notes for deal 169', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (373, N'Vision', N'First170', N'Last170', 1, N'FFM170', 3, 1, 4061, 2, 2, 2, CAST(N'2025-11-10T11:25:26.933' AS DateTime), N'Notes for deal 170', 5, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (374, N'Health', N'First171', N'Last171', 3, N'FFM171', 5, 2, 5136, 3, 2, 3, CAST(N'2025-11-17T11:25:26.933' AS DateTime), N'Notes for deal 171', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (375, N'Health', N'First172', N'Last172', 2, N'FFM172', 3, 1, 2279, 2, 2, 2, CAST(N'2025-11-15T11:25:26.933' AS DateTime), N'Notes for deal 172', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (376, N'Dental', N'First173', N'Last173', 5, N'FFM173', 4, 4, 3541, 1, 1, 3, CAST(N'2025-11-17T11:25:26.933' AS DateTime), N'Notes for deal 173', 3, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (377, N'Health', N'First174', N'Last174', 5, N'FFM174', 2, 4, 4371, 1, 1, 2, CAST(N'2025-11-16T11:25:26.933' AS DateTime), N'Notes for deal 174', 5, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (378, N'Life', N'First175', N'Last175', 3, N'FFM175', 5, 1, 4878, 1, 1, 1, CAST(N'2025-11-17T11:25:26.933' AS DateTime), N'Notes for deal 175', 5, 1, 1, CAST(N'2025-11-09T11:25:26.933' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (379, N'Life', N'First176', N'Last176', 3, N'FFM176', 1, 2, 4201, 3, 1, 2, CAST(N'2025-11-28T11:25:26.937' AS DateTime), N'Notes for deal 176', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (380, N'Health', N'First177', N'Last177', 4, N'FFM177', 4, 4, 5779, 2, 2, 2, CAST(N'2025-11-23T11:25:26.937' AS DateTime), N'Notes for deal 177', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (381, N'Health', N'First178', N'Last178', 4, N'FFM178', 2, 3, 3521, 2, 1, 2, CAST(N'2025-11-27T11:25:26.937' AS DateTime), N'Notes for deal 178', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (382, N'Health', N'First179', N'Last179', 5, N'FFM179', 3, 4, 2162, 3, 1, 2, CAST(N'2025-11-15T11:25:26.937' AS DateTime), N'Notes for deal 179', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (383, N'Vision', N'First180', N'Last180', 3, N'FFM180', 4, 2, 2915, 3, 2, 2, CAST(N'2025-11-09T11:25:26.937' AS DateTime), N'Notes for deal 180', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (384, N'Vision', N'First181', N'Last181', 2, N'FFM181', 2, 2, 5776, 3, 2, 1, CAST(N'2025-11-24T11:25:26.937' AS DateTime), N'Notes for deal 181', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (385, N'Health', N'First182', N'Last182', 3, N'FFM182', 4, 3, 4586, 3, 1, 1, CAST(N'2025-11-25T11:25:26.937' AS DateTime), N'Notes for deal 182', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (386, N'Dental', N'First183', N'Last183', 3, N'FFM183', 4, 3, 3850, 2, 2, 3, CAST(N'2025-11-28T11:25:26.937' AS DateTime), N'Notes for deal 183', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (387, N'Dental', N'First184', N'Last184', 5, N'FFM184', 4, 1, 3346, 2, 2, 3, CAST(N'2025-11-27T11:25:26.937' AS DateTime), N'Notes for deal 184', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (388, N'Health', N'First185', N'Last185', 4, N'FFM185', 5, 1, 5349, 1, 1, 3, CAST(N'2025-11-19T11:25:26.937' AS DateTime), N'Notes for deal 185', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (389, N'Vision', N'First186', N'Last186', 5, N'FFM186', 3, 1, 4470, 3, 2, 2, CAST(N'2025-11-25T11:25:26.937' AS DateTime), N'Notes for deal 186', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (390, N'Vision', N'First187', N'Last187', 5, N'FFM187', 2, 1, 4426, 1, 1, 2, CAST(N'2025-11-13T11:25:26.937' AS DateTime), N'Notes for deal 187', 5, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (391, N'Dental', N'First188', N'Last188', 4, N'FFM188', 4, 2, 2037, 1, 1, 3, CAST(N'2025-11-17T11:25:26.937' AS DateTime), N'Notes for deal 188', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (392, N'Vision', N'First189', N'Last189', 1, N'FFM189', 1, 3, 2635, 1, 1, 2, CAST(N'2025-11-14T11:25:26.937' AS DateTime), N'Notes for deal 189', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (393, N'Dental', N'First190', N'Last190', 5, N'FFM190', 1, 3, 2895, 3, 1, 2, CAST(N'2025-11-25T11:25:26.937' AS DateTime), N'Notes for deal 190', 3, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (394, N'Life', N'First191', N'Last191', 5, N'FFM191', 1, 3, 2067, 3, 1, 2, CAST(N'2025-11-11T11:25:26.937' AS DateTime), N'Notes for deal 191', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (395, N'Health', N'First192', N'Last192', 2, N'FFM192', 2, 2, 4583, 2, 2, 3, CAST(N'2025-11-23T11:25:26.937' AS DateTime), N'Notes for deal 192', 5, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (396, N'Health', N'First193', N'Last193', 1, N'FFM193', 4, 1, 5831, 3, 2, 2, CAST(N'2025-11-15T11:25:26.937' AS DateTime), N'Notes for deal 193', 5, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (397, N'Vision', N'First194', N'Last194', 1, N'FFM194', 4, 4, 2886, 3, 2, 1, CAST(N'2025-11-16T11:25:26.937' AS DateTime), N'Notes for deal 194', 4, 1, 1, CAST(N'2025-11-09T11:25:26.937' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (398, N'Dental', N'First195', N'Last195', 1, N'FFM195', 3, 3, 2494, 2, 2, 2, CAST(N'2025-11-26T11:25:26.940' AS DateTime), N'Notes for deal 195', 4, 1, 1, CAST(N'2025-11-09T11:25:26.940' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (399, N'Health', N'First196', N'Last196', 3, N'FFM196', 5, 4, 2396, 1, 2, 3, CAST(N'2025-11-13T11:25:26.940' AS DateTime), N'Notes for deal 196', 5, 1, 1, CAST(N'2025-11-09T11:25:26.940' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (400, N'Health', N'First197', N'Last197', 2, N'FFM197', 1, 4, 5313, 2, 1, 3, CAST(N'2025-11-09T11:25:26.940' AS DateTime), N'Notes for deal 197', 4, 1, 1, CAST(N'2025-11-09T11:25:26.940' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (401, N'Health', N'First198', N'Last198', 5, N'FFM198', 5, 1, 3652, 1, 1, 1, CAST(N'2025-11-18T11:25:26.940' AS DateTime), N'Notes for deal 198', 4, 1, 1, CAST(N'2025-11-09T11:25:26.940' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (402, N'Dental', N'First199', N'Last199', 4, N'FFM199', 4, 3, 4454, 2, 2, 3, CAST(N'2025-11-18T11:25:26.940' AS DateTime), N'Notes for deal 199', 3, 1, 1, CAST(N'2025-11-09T11:25:26.940' AS DateTime), NULL, NULL, N'127.0.0.1')
GO
INSERT [dbo].[Deal] ([DealId], [TypeOfCoverage], [FirstName], [LastName], [NoOfApplicants], [FFM], [Career], [TypeOfWork], [MonthlyIncome], [DocNeeded], [SocialProvided], [CustomerLanguage], [CloseDate], [Notes], [AgentId], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (403, N'Life', N'First200', N'Last200', 1, N'FFM200', 3, 2, 3935, 2, 1, 1, CAST(N'2025-11-24T11:25:26.940' AS DateTime), N'Notes for deal 200', 4, 1, 1, CAST(N'2025-11-09T11:25:26.940' AS DateTime), NULL, NULL, N'127.0.0.1')
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
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (40, 1, CAST(N'2025-11-08T01:12:49.977' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (41, 1, CAST(N'2025-11-08T04:19:35.340' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (42, 1, CAST(N'2025-11-08T04:27:04.267' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (43, 1, CAST(N'2025-11-08T23:43:33.783' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (44, 1, CAST(N'2025-11-08T23:49:04.563' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (45, 1, CAST(N'2025-11-09T01:43:48.407' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (46, 1, CAST(N'2025-11-09T01:45:58.917' AS DateTime), N'::1')
GO
INSERT [dbo].[LoginHistory] ([LoginHistoryId], [UserMasterId], [LoggedInTime], [IP]) VALUES (47, 1, CAST(N'2025-11-09T02:25:19.117' AS DateTime), N'::1')
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
INSERT [dbo].[Menu] ([MenuId], [MenuName], [MenuNameId], [PageURL], [Icon], [ParentId], [DisplayOrder], [IsHaveChild], [IsActive], [IsShowtoAdmin]) VALUES (5, N'Leader Board', N'LeaderBoard', N'LeaderBoard', N'ri-dashboard-2-line', 0, 4, 0, 1, 1)
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
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (4, N'john@example.com', N'3000~fitwhNSnpT28AULWAlCkMWm0otnxiuPC~qg6X4kZ4kjF7Iz8FRt8qfTAKCD7xdJg2', N'9991112222', N'John Carter', N'9991112222', 3, 1, 0, 1, 1, CAST(N'2025-11-08T23:51:54.520' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (5, N'emily@example.com', N'3000~J6TdpJ+Hius1bGBCUbkyVXrThTL4mgjR~itSb1mu/0TriS2bVBeqsbCraYGxGzGH6', N'Rose', N'Emily ', N'8885556666', 3, 1, 0, 1, 1, CAST(N'2025-11-08T23:52:21.433' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (6, N'sophia@example.com', N'3000~9p7pvg3YQ31UFUT5IUhw57vR6XHQrrmC~u2wLdU17wMuP7rFW4eDlzmQ2cX6tKWWG', N'Davis', N'Sophia ', N'6662224444', 3, 1, 0, 1, 1, CAST(N'2025-11-08T23:53:03.857' AS DateTime), NULL, NULL, N'::1')
GO
INSERT [dbo].[UserMaster] ([UserMasterId], [Username], [UserPassword], [LastName], [FirstName], [ContactNumber], [RoleId], [IsFirstTimeLogin], [TwoStepAuth], [IsActive], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IP]) VALUES (7, N'robert@example.com', N'3000~UMT+6vzwNTFD2e9cXs4pCgNxCzEHrmYk~vxaJiMI2JMc2WZYX6d0AQ3yt5iN7unED', N'Wilson', N'Robert ', N'9997773333', 3, 1, 0, 1, 1, CAST(N'2025-11-08T23:53:34.233' AS DateTime), NULL, NULL, N'::1')
GO
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
GO
ALTER TABLE [dbo].[LeadMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LeadMaster] ADD  DEFAULT ((1)) FOR [IsActive]
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
