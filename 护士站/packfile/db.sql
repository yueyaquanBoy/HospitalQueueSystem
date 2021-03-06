USE [master]

GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Nurse')
BEGIN
CREATE DATABASE [Nurse]
END

GO
EXEC dbo.sp_dbcmptlevel @dbname=N'Nurse', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Nurse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Nurse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Nurse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Nurse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Nurse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Nurse] SET ARITHABORT OFF 
GO
ALTER DATABASE [Nurse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Nurse] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Nurse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Nurse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Nurse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Nurse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Nurse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Nurse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Nurse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Nurse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Nurse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Nurse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Nurse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Nurse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Nurse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Nurse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Nurse] SET  READ_WRITE 
GO
ALTER DATABASE [Nurse] SET RECOVERY FULL 
GO
ALTER DATABASE [Nurse] SET  MULTI_USER 
GO
ALTER DATABASE [Nurse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Nurse] SET DB_CHAINING OFF 
USE [Nurse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Nurse_Office]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Nurse_Office](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[nurse_id] [nvarchar](50) NOT NULL,
	[office_id] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Nurse_Office] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Consult]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Consult](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[consult_id] [nvarchar](30) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[call_name] [nvarchar](30) NULL,
	[caller_id] [int] NULL,
	[wnd_screen_id] [int] NULL,
	[compreh_screen_id] [int] NULL,
	[evaluator_id] [int] NULL,
	[office_id] [nvarchar](30) NOT NULL,
	[through_screen_id] [int] NULL,
	[through_screen_ip] [nvarchar](20) NULL,
	[stb_id] [nvarchar](20) NULL,
	[his_flag] [int] NULL CONSTRAINT [DF_Consult_his_flag]  DEFAULT ((0)),
	[position] [nvarchar](50) NULL,
 CONSTRAINT [PK_Consult] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Consult]') AND name = N'IX_Consult')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Consult] ON [dbo].[Consult] 
(
	[consult_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WaitingRoom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WaitingRoom](
	[room_id] [int] IDENTITY(1,1) NOT NULL,
	[room_name] [nvarchar](50) NULL,
	[stb_id] [nvarchar](50) NULL,
	[available] [int] NULL,
 CONSTRAINT [PK_WaitingRoom] PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Caller]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Caller](
	[caller_id] [int] NOT NULL,
	[consult_id] [int] NOT NULL,
	[table_id] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoginInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoginInfo](
	[UserName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[LoadTime] [datetime] NOT NULL,
	[UserPower] [int] NOT NULL,
	[UserIP] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Office]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Office](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[office_id] [nvarchar](30) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[call_id] [nvarchar](30) NULL,
	[call_name] [nvarchar](30) NULL,
	[NumStart] [int] NULL,
	[NumEnd] [int] NULL,
	[AmLimit] [int] NULL,
	[PmLimit] [int] NULL,
	[DayLimit] [int] NULL,
	[comp_screen_id] [int] NULL,
	[stb_id] [nvarchar](30) NULL,
	[his_flag] [int] NULL CONSTRAINT [DF_Office_his_flag]  DEFAULT ((0)),
	[parent_id] [nvarchar](30) NULL,
 CONSTRAINT [PK_OfficeQue] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Office]') AND name = N'IX_OfficeQue')
CREATE UNIQUE NONCLUSTERED INDEX [IX_OfficeQue] ON [dbo].[Office] 
(
	[office_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HisForBjlb_Patient]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HisForBjlb_Patient](
	[serial_id] [varchar](30) NOT NULL,
	[reg_id] [varchar](30) NOT NULL,
	[id_card] [varchar](30) NULL,
	[patient_id] [varchar](30) NOT NULL,
	[patient_name] [varchar](30) NOT NULL,
	[patient_gender] [smallint] NULL,
	[patient_birth] [varchar](20) NULL,
	[queue_num] [varchar](30) NOT NULL,
	[time] [datetime] NOT NULL,
	[id_depart] [varchar](30) NOT NULL,
	[id_item] [varchar](30) NULL,
	[item_desc] [varchar](30) NULL,
	[id_doctor] [varchar](30) NULL,
	[em_flag] [smallint] NULL,
	[in_flag] [smallint] NULL,
	[read_flag] [smallint] NULL,
 CONSTRAINT [PK_HisForBjlb_Patient] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Queue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Queue](
	[log_id] [nvarchar](30) NOT NULL,
	[reg_id] [nvarchar](30) NULL,
	[queue_id] [int] NULL,
	[queue_id_call] [nvarchar](30) NOT NULL,
	[patient_id] [nvarchar](30) NOT NULL,
	[patient_name] [nvarchar](20) NOT NULL,
	[patient_gender] [int] NULL,
	[patient_birth] [nvarchar](20) NULL,
	[office_id] [nvarchar](30) NOT NULL,
	[doctor_id] [nvarchar](30) NULL,
	[regtime] [datetime] NOT NULL,
	[status] [int] NOT NULL CONSTRAINT [DF_Queue_status]  DEFAULT ((0)),
	[priority] [int] NOT NULL,
	[gender_flag] [int] NULL,
	[his_queue_id] [nvarchar](30) NULL,
	[room_id] [int] NULL,
	[id_item] [nvarchar](30) NULL,
	[item_desc] [nvarchar](30) NULL,
	[in_flag] [smallint] NULL,
	[em_flag] [smallint] NULL,
	[comment] [nvarchar](20) NULL,
 CONSTRAINT [PK_Queue] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SetTopBox]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SetTopBox](
	[stb_id] [int] IDENTITY(1,1) NOT NULL,
	[stb_name] [nvarchar](50) NOT NULL,
	[stb_ip] [nvarchar](32) NULL,
	[stb_port] [int] NULL,
	[stb_init_text] [nvarchar](200) NULL,
	[stb_type] [int] NOT NULL CONSTRAINT [DF_SetTopBox_stb_type]  DEFAULT ((0)),
 CONSTRAINT [PK_SetTopBox_1] PRIMARY KEY CLUSTERED 
(
	[stb_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SetTopBox]') AND name = N'IX_SetTopBox_StbId')
CREATE NONCLUSTERED INDEX [IX_SetTopBox_StbId] ON [dbo].[SetTopBox] 
(
	[stb_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Doctor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Doctor](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[doctor_id] [nvarchar](30) NOT NULL,
	[login_id] [nvarchar](30) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[gender] [int] NOT NULL,
	[expert_flag] [int] NULL,
	[title] [nvarchar](30) NULL,
	[password] [nvarchar](30) NOT NULL,
	[photo] [image] NULL,
	[sound_call] [nvarchar](200) NULL,
	[sound_wait] [nvarchar](200) NULL,
	[display_call] [nvarchar](200) NULL,
	[display_wait] [nvarchar](200) NULL,
	[office_id] [nvarchar](30) NULL,
	[consult_id] [nvarchar](30) NULL,
	[table_num] [int] NULL,
	[caller_id] [int] NULL,
	[evaluator_id] [int] NULL,
	[working_flag] [int] NULL,
	[online_flag] [int] NULL,
	[max_recall_times] [int] NULL,
	[call_special_flag] [int] NULL,
	[his_flag] [int] NULL CONSTRAINT [DF_Doctor_his_flag]  DEFAULT ((0)),
	[wait_when_call_flag] [int] NULL,
	[wait_num] [int] NULL,
 CONSTRAINT [PK_DoctorData] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Doctor]') AND name = N'IX_DoctorData')
CREATE UNIQUE NONCLUSTERED INDEX [IX_DoctorData] ON [dbo].[Doctor] 
(
	[doctor_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThroughLED]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ThroughLED](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[ip] [nvarchar](20) NULL,
	[port] [int] NULL,
	[address] [int] NULL,
	[channel_num] [int] NULL,
 CONSTRAINT [PK_ThroughLED] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Nurse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Nurse](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[nurse_id] [nvarchar](50) NOT NULL,
	[nurse_name] [nvarchar](50) NULL,
	[password] [nvarchar](50) NOT NULL,
	[power] [int] NOT NULL,
	[regtime] [datetime] NOT NULL,
	[stb_id] [int] NULL,
 CONSTRAINT [PK_UserData] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_UserData] UNIQUE NONCLUSTERED 
(
	[nurse_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Item](
	[id] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[name] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[price] [nvarchar](15) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Doctor_Office]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Doctor_Office](
	[doctor_id] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[office_id] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
 CONSTRAINT [PK_Doctor_Office] PRIMARY KEY CLUSTERED 
(
	[doctor_id] ASC,
	[office_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
BEGIN
INSERT INTO [Nurse]([nurse_id],[nurse_name],[password],[power],[regtime])
	VALUES('admin','超级管理员','123',0,getdate())
END
