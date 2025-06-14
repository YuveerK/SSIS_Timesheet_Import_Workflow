USE [master]
GO

USE [master];
GO

IF DB_ID('SSISTimesheetIntegrationDb') IS NULL
BEGIN
    CREATE DATABASE [SSISTimesheetIntegrationDb]
    CONTAINMENT = NONE
    ON  PRIMARY 
    ( NAME = N'SSISTimesheetIntegrationDb', 
      FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SSISTimesheetIntegrationDb.mdf', 
      SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
    LOG ON 
    ( NAME = N'SSISTimesheetIntegrationDb_log', 
      FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SSISTimesheetIntegrationDb_log.ldf', 
      SIZE = 270336KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB );
END
GO


IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SSISTimesheetIntegrationDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ARITHABORT OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET  ENABLE_BROKER 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET RECOVERY FULL 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET  MULTI_USER 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET DB_CHAINING OFF 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET QUERY_STORE = ON
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [SSISTimesheetIntegrationDb] SET  READ_WRITE 
GO



USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[AuditLog]    Script Date: 2025/06/14 22:36:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.AuditLog', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[AuditLog](
	[AuditID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [varchar](255) NULL,
	[TaskName] [varchar](255) NULL,
	[OperationType] [varchar](10) NULL,
	[EntityType] [varchar](255) NULL,
	[RowCount] [int] NULL,
	[AuditTime] [datetime] NULL,
	[FileProcessed] [varchar](500) NULL,
	[EmployeeID] [int] NULL,
	[EmployeeName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[AuditLog] ADD  DEFAULT (getdate()) FOR [AuditTime]
GO

USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[Client]    Script Date: 2025/06/14 22:36:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Client', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Client](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](255) NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[Client] ADD  CONSTRAINT [DF_Client_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO

USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[Description]    Script Date: 2025/06/14 22:36:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.Description', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Description](
	[DescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[Description] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO




USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[Employee]    Script Date: 2025/06/14 22:36:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.Employee', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](100) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO

USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[ErrorLog]    Script Date: 2025/06/14 22:36:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.ErrorLog', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[ErrorLog](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [varchar](255) NULL,
	[TaskName] [varchar](255) NULL,
	[ErrorDescription] [nvarchar](max) NULL,
	[ErrorCode] [int] NULL,
	[ErrorTime] [datetime] NULL,
	[FileProcessed] [varchar](500) NULL,
	[EmployeeName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[ErrorLog] ADD  DEFAULT (getdate()) FOR [ErrorTime]
GO

USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[Expense]    Script Date: 2025/06/14 22:36:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.Expense', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Expense](
	[ExpenseID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Month] [date] NULL,
	[ExpenseDescription] [varchar](255) NULL,
	[Type] [varchar](255) NULL,
	[ZarCost] [decimal](5, 2) NULL,
	[CreatedAt] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExpenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[Expense] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Expense]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO

USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[Leave]    Script Date: 2025/06/14 22:36:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.Leave', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Leave](
	[LeaveID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[TypeOfLeave] [varchar](255) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[NumberOfDays] [decimal](4, 1) NULL,
	[ApprovalObtained] [varchar](255) NULL,
	[SickNoteProvided] [varchar](255) NULL,
	[ContactInformation] [varchar](1000) NULL,
	[SubmissionDate] [date] NULL,
	[CreatedAt] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LeaveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[Leave] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Leave]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO

USE [SSISTimesheetIntegrationDb]
GO

/****** Object:  Table [dbo].[Timesheet]    Script Date: 2025/06/14 22:37:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Timesheet', 'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Timesheet](
	[TimesheetID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[Date] [date] NULL,
	[DayOfWeek] [varchar](50) NULL,
	[ClientID] [int] NULL,
	[ProjectName] [varchar](255) NULL,
	[DescriptionID] [int] NULL,
	[Billable] [varchar](50) NULL,
	[Comments] [varchar](255) NULL,
	[TotalHours] [decimal](5, 2) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TimesheetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[Timesheet] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ClientID])
GO

ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD FOREIGN KEY([DescriptionID])
REFERENCES [dbo].[Description] ([DescriptionID])
GO

ALTER TABLE [dbo].[Timesheet]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO

DECLARE @ProjectBinary VARBINARY(MAX);

-- read the .ispac file as a single BLOB
SELECT @ProjectBinary = BulkColumn
FROM   OPENROWSET(
         BULK '$(IspacFullPath)',          -- macro replaced by sqlcmd
         SINGLE_BLOB
       ) AS ProjectFile;

EXEC SSISDB.catalog.deploy_project
     @folder_name   = N'Timesheet Imports',
     @project_name  = N'Normalized_SSIS_Project',
     @project_stream= @ProjectBinary,
     @operation_id  = NULL;                -- returns operation-id if you need it


EXEC SSISDB.catalog.create_folder 
     @folder_name = N'Timesheet Imports',
     @folder_id   = NULL;