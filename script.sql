USE [N1_Project]
GO
/****** Object:  StoredProcedure [dbo].[UpdateStaffInfo]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[UpdateStaffInfo]
GO
/****** Object:  StoredProcedure [dbo].[statistical]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[statistical]
GO
/****** Object:  StoredProcedure [dbo].[sp_oid]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[sp_oid]
GO
/****** Object:  StoredProcedure [dbo].[sp_insertIdeas]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[sp_insertIdeas]
GO
/****** Object:  StoredProcedure [dbo].[sp_insertIdeaComments]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[sp_insertIdeaComments]
GO
/****** Object:  StoredProcedure [dbo].[QA_Update]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[QA_Update]
GO
/****** Object:  StoredProcedure [dbo].[LoginUser]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[LoginUser]
GO
/****** Object:  StoredProcedure [dbo].[Like_Dis_View]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[Like_Dis_View]
GO
/****** Object:  StoredProcedure [dbo].[GetListIdeas]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[GetListIdeas]
GO
/****** Object:  StoredProcedure [dbo].[getKeyEnCrypt]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[getKeyEnCrypt]
GO
/****** Object:  StoredProcedure [dbo].[getIdeasByID]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[getIdeasByID]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUser]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[GetAllUser]
GO
/****** Object:  StoredProcedure [dbo].[DeleteIdeas]    Script Date: 2022-03-14 10:13:24 AM ******/
DROP PROCEDURE [dbo].[DeleteIdeas]
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 2022-03-14 10:13:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tag]') AND type in (N'U'))
DROP TABLE [dbo].[Tag]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 2022-03-14 10:13:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Position]') AND type in (N'U'))
DROP TABLE [dbo].[Position]
GO
/****** Object:  Table [dbo].[Ideas]    Script Date: 2022-03-14 10:13:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ideas]') AND type in (N'U'))
DROP TABLE [dbo].[Ideas]
GO
/****** Object:  Table [dbo].[IdeaComment]    Script Date: 2022-03-14 10:13:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IdeaComment]') AND type in (N'U'))
DROP TABLE [dbo].[IdeaComment]
GO
/****** Object:  Table [dbo].[BosUser]    Script Date: 2022-03-14 10:13:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BosUser]') AND type in (N'U'))
DROP TABLE [dbo].[BosUser]
GO
/****** Object:  Table [dbo].[BosUser]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BosUser](
	[UserCode] [nvarchar](5) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[NumberPhone] [nvarchar](10) NULL,
	[Crt_Date] [datetime] NULL,
	[KeyEnCrypt] [nvarchar](100) NULL,
	[KeyValidate] [nvarchar](6) NULL,
	[isAdmin] [bit] NULL,
	[isQA] [bit] NULL,
	[Tag] [char](10) NULL,
	[isStaffIT] [bit] NULL,
	[isStaffBusiness] [bit] NULL,
	[isStaffComputerScience] [bit] NULL,
	[Position] [nchar](10) NULL,
 CONSTRAINT [PK__BosUser__1DF52D0DA8F5947E] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IdeaComment]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdeaComment](
	[IID] [nvarchar](30) NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[Crt_User] [varchar](10) NULL,
	[Crt_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ideas]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ideas](
	[IID] [varchar](30) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Content] [nvarchar](max) NULL,
	[Crt_User] [varchar](5) NULL,
	[Crt_Date] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsOnline] [bit] NULL,
	[View_numb] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[LikeNumb] [int] NULL,
	[DisLikeNumb] [int] NULL,
	[FileName] [nvarchar](500) NULL,
	[FilePath] [nvarchar](500) NULL,
	[isOption] [bit] NULL,
	[Date_Online] [datetime] NULL,
	[Tag] [char](10) NULL,
	[UserLike] [nvarchar](max) NULL,
	[UserDisLike] [nvarchar](max) NULL,
 CONSTRAINT [PK_Ideas] PRIMARY KEY CLUSTERED 
(
	[IID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[ID] [nchar](10) NOT NULL,
	[PositionName] [nvarchar](500) NULL,
	[isActive] [bit] NULL,
	[Crt_User] [nvarchar](500) NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[IDTag] [nchar](10) NULL,
	[TagName] [nvarchar](100) NULL,
	[Crt_User] [varchar](5) NULL,
	[Crt_Date] [datetime] NULL,
	[isActive] [bit] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[BosUser] ([UserCode], [UserName], [Password], [FullName], [Email], [Address], [NumberPhone], [Crt_Date], [KeyEnCrypt], [KeyValidate], [isAdmin], [isQA], [Tag], [isStaffIT], [isStaffBusiness], [isStaffComputerScience], [Position]) VALUES (N'00001', N'admin', N'admin', N'Nguyễn Tiến Văn', N'Ntv@gmail.com', N'33/21 Trung Lang', N'034023423', CAST(N'2022-03-02T00:00:00.000' AS DateTime), N'lZT1OrZAAuQ=', NULL, 1, 0, NULL, NULL, NULL, NULL, N'PS01      ')
INSERT [dbo].[BosUser] ([UserCode], [UserName], [Password], [FullName], [Email], [Address], [NumberPhone], [Crt_Date], [KeyEnCrypt], [KeyValidate], [isAdmin], [isQA], [Tag], [isStaffIT], [isStaffBusiness], [isStaffComputerScience], [Position]) VALUES (N'00002', N'staff', N'staff', N'Hà Thanh Dũng', N'dung@gmail.com', N'16 Xuân Diệu', N'0123123432', CAST(N'2022-03-02T00:00:00.000' AS DateTime), N'lZT1OrZAAuQ=', NULL, NULL, NULL, NULL, 0, 1, NULL, N'PS04      ')
INSERT [dbo].[BosUser] ([UserCode], [UserName], [Password], [FullName], [Email], [Address], [NumberPhone], [Crt_Date], [KeyEnCrypt], [KeyValidate], [isAdmin], [isQA], [Tag], [isStaffIT], [isStaffBusiness], [isStaffComputerScience], [Position]) VALUES (N'00003', N'QA', N'qa', N'Trương Hoài Quang', N'thq@gmail.com', N'16 Xuân Diệu', N'0342342342', CAST(N'2022-03-02T00:00:00.000' AS DateTime), N'lZT1OrZAAuQ=', NULL, 0, 1, NULL, NULL, NULL, NULL, N'PS02      ')
INSERT [dbo].[BosUser] ([UserCode], [UserName], [Password], [FullName], [Email], [Address], [NumberPhone], [Crt_Date], [KeyEnCrypt], [KeyValidate], [isAdmin], [isQA], [Tag], [isStaffIT], [isStaffBusiness], [isStaffComputerScience], [Position]) VALUES (N'00004', N'staffIT', N'it', N'Alex', N'alex@gmail.com', N'23 Xuân Diệu', N'0903689856', CAST(N'2022-03-02T00:00:00.000' AS DateTime), N'lZT1OrZAAuQ=', NULL, 0, 0, NULL, 1, NULL, NULL, N'PS03      ')
INSERT [dbo].[BosUser] ([UserCode], [UserName], [Password], [FullName], [Email], [Address], [NumberPhone], [Crt_Date], [KeyEnCrypt], [KeyValidate], [isAdmin], [isQA], [Tag], [isStaffIT], [isStaffBusiness], [isStaffComputerScience], [Position]) VALUES (N'00005', N'staffCS', N'CS', N'Taylor Switf', N'TS@gmail.com', N'USA', N'0123123432', CAST(N'2022-03-02T00:00:00.000' AS DateTime), N'lZT1OrZAAuQ=', NULL, 0, 0, NULL, 0, NULL, 1, N'PS05      ')
GO
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'00001/220309:092722543', N'I like it', N'00002', CAST(N'2022-03-09T21:29:25.420' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:120351103', N'tesst', N'00001', CAST(N'2022-03-11T17:20:15.247' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:120351103', N'hei', N'00001', CAST(N'2022-03-11T17:28:37.090' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:120351103', N'alooo', N'00001', CAST(N'2022-03-11T17:28:37.090' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'xin chào mn', N'00001', CAST(N'2022-03-12T12:46:05.047' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:113139037', N'', N'00004', CAST(N'2022-03-12T23:31:49.467' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:113139037', N'', N'00004', CAST(N'2022-03-12T23:32:43.427' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:113139037', N'aadsfasd', N'00004', CAST(N'2022-03-12T23:35:49.930' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'dfsa', N'00004', CAST(N'2022-03-13T10:03:13.737' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'fasd', N'00004', CAST(N'2022-03-13T10:05:45.983' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220313:110650280', N'xin chào', N'00003', CAST(N'2022-03-13T23:09:33.870' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'sdaf', N'00004', CAST(N'2022-03-13T10:02:23.373' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'adf', N'00004', CAST(N'2022-03-13T10:02:25.087' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'adf', N'00004', CAST(N'2022-03-13T10:02:26.460' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'adf', N'00004', CAST(N'2022-03-13T10:02:27.723' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220312:071812527', N'', N'00004', CAST(N'2022-03-13T10:02:29.670' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220313:110650280', N'hello', N'00001', CAST(N'2022-03-13T23:16:47.987' AS DateTime))
INSERT [dbo].[IdeaComment] ([IID], [Comment], [Crt_User], [Crt_Date]) VALUES (N'220313:060404337', N'good', N'00003', CAST(N'2022-03-13T18:06:56.767' AS DateTime))
GO
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'00001/220309:092722543', N'Update Entertament', N'Dear All,my name is Nguyen Tien Nam', N'00001', CAST(N'2022-03-09T21:29:25.420' AS DateTime), 1, 1, 100, CAST(N'2022-03-09T00:00:00.000' AS DateTime), CAST(N'2022-04-09T21:29:25.420' AS DateTime), 1, 1, NULL, NULL, 1, CAST(N'2022-03-11T16:55:09.903' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220311:115515760', N'tesst', N'estset', N'00002', CAST(N'2022-03-12T21:33:34.750' AS DateTime), 1, 0, 0, CAST(N'2022-03-11T16:55:09.903' AS DateTime), CAST(N'2022-04-09T21:29:25.420' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-11T16:55:09.903' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:071812527', N'xin chào', N'xin chào ', N'00002', CAST(N'2022-03-12T21:33:34.750' AS DateTime), 1, 1, 1, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-04-09T21:29:25.420' AS DateTime), 3, 0, N'', N'', 1, CAST(N'2022-03-12T00:00:00.000' AS DateTime), N'Tag01     ', N'00003;00001;00004;', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:093219890', N'nv4', N'nv4', N'00004', CAST(N'2022-03-12T21:32:22.437' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-04-09T21:29:25.420' AS DateTime), 0, 0, N'', N'', 1, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N' ', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:093334740', N'vn', N'dfsd', N'00004', CAST(N'2022-03-12T21:33:34.750' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-10T00:00:00.000' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:093731793', N'vc', N'dfasd', N'00005', CAST(N'2022-03-12T21:37:31.813' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-10T00:00:00.000' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:094000137', N'sdf', N'sdfa', N'00004', CAST(N'2022-03-12T21:40:00.153' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-10T00:00:00.000' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:094237030', N'dsfsd', N'dfsfsdfs', N'00004', CAST(N'2022-03-12T21:42:37.063' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-10T00:00:00.000' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:113139037', N'dfsdfsd', N'est', N'00004', CAST(N'2022-03-12T23:31:39.157' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-10T00:00:00.000' AS DateTime), 2, 0, N'', N'', 0, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N'00004;00003;', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:120059647', N'HelloWord', N'Hello', N'00001', CAST(N'2022-03-12T21:33:34.750' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-03-11T17:00:48.073' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-11T17:00:48.073' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:120116270', N'HelloWord', N'Hello', N'00001', CAST(N'2022-03-12T21:33:34.750' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-03-11T17:00:48.073' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-11T17:00:48.073' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220312:120351103', N'dsdfasdf', N'adfasfdasdfa', N'00001', CAST(N'2022-03-12T21:33:34.750' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-03-12T00:00:00.000' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-12T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:013258580', N'tes', N'tes', N'00004', CAST(N'2022-03-13T01:32:58.743' AS DateTime), 1, 1, 7, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 1, 0, N'', N'', 0, CAST(N'2022-03-13T00:00:00.000' AS DateTime), NULL, N'00004;', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:015829860', N'tesst', N'estse', N'00004', CAST(N'2022-03-13T01:58:46.510' AS DateTime), 1, 1, 1, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 0, 0, N'web nhóm.docx;', N'E:\New Project\WebApplication\WebApplication\Upload\220313015829860', 0, CAST(N'2022-03-13T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:060404337', N'Thông báo', N'xin chào', N'00001', CAST(N'2022-03-13T18:04:04.620' AS DateTime), 1, 1, 2, CAST(N'2022-02-13T18:04:04.623' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 0, 1, N'', N'', 0, CAST(N'2022-03-13T00:00:00.000' AS DateTime), N'Tag02     ', N'', N'00003;')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:095321330', N'àds', N'ádfa', N'00004', CAST(N'2022-03-13T09:53:32.260' AS DateTime), 1, 1, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 0, 0, N'', N'', 0, CAST(N'2022-03-13T00:00:00.000' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:110125693', N'test', N'etste', N'00003', CAST(N'2022-03-13T23:01:25.997' AS DateTime), 1, 0, 0, CAST(N'2022-02-11T00:00:00.000' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 0, 0, N'', N'', 1, CAST(N'2022-03-13T23:01:25.997' AS DateTime), NULL, N'', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:110650280', N'Xin chào', N'Xin chào', N'00003', CAST(N'2022-03-13T23:06:57.620' AS DateTime), 1, 1, 2, CAST(N'2022-02-11T00:00:00.000' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 1, 0, N'CTV THANG 022022.xlsx;web nhóm.docx;', N'E:\New Project\WebApplication\WebApplication\Upload\220313110650280', 1, CAST(N'2022-03-13T23:07:09.360' AS DateTime), N'Tag02     ', N'00003;', N'')
INSERT [dbo].[Ideas] ([IID], [Title], [Content], [Crt_User], [Crt_Date], [IsActive], [IsOnline], [View_numb], [StartDate], [EndDate], [LikeNumb], [DisLikeNumb], [FileName], [FilePath], [isOption], [Date_Online], [Tag], [UserLike], [UserDisLike]) VALUES (N'220313:112347000', N'hello World', N'hello World', N'00004', CAST(N'2022-03-13T23:23:47.220' AS DateTime), 1, 1, 1, CAST(N'2022-02-11T00:00:00.000' AS DateTime), CAST(N'2022-06-11T00:00:00.000' AS DateTime), 0, 0, N'', N'', 1, CAST(N'2022-03-13T23:24:06.463' AS DateTime), NULL, N'', N'')
GO
INSERT [dbo].[Position] ([ID], [PositionName], [isActive], [Crt_User]) VALUES (N'PS01      ', N'Admin', 1, NULL)
INSERT [dbo].[Position] ([ID], [PositionName], [isActive], [Crt_User]) VALUES (N'PS02      ', N'Quality Assurance Manager', 1, NULL)
INSERT [dbo].[Position] ([ID], [PositionName], [isActive], [Crt_User]) VALUES (N'PS03      ', N'Staff IT', 1, NULL)
INSERT [dbo].[Position] ([ID], [PositionName], [isActive], [Crt_User]) VALUES (N'PS04      ', N'Staff Business', 1, NULL)
INSERT [dbo].[Position] ([ID], [PositionName], [isActive], [Crt_User]) VALUES (N'PS05      ', N'Staff CS', 1, NULL)
GO
INSERT [dbo].[Tag] ([IDTag], [TagName], [Crt_User], [Crt_Date], [isActive]) VALUES (N'Tag01     ', N'Impotant', N'00001', NULL, 0)
INSERT [dbo].[Tag] ([IDTag], [TagName], [Crt_User], [Crt_Date], [isActive]) VALUES (N'Tag02     ', N'Good', N'00001', NULL, 0)
GO
/****** Object:  StoredProcedure [dbo].[DeleteIdeas]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteIdeas] 
	@IID nchar(30) = ''
AS
BEGIN
	delete Ideas
	where IID = @IID
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllUser]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[GetAllUser]
	
AS
BEGIN
	select * from BosUser
END
GO
/****** Object:  StoredProcedure [dbo].[getIdeasByID]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getIdeasByID]
@IID nvarchar(50) = '220312:071812527'
AS
BEGIN
	begin
		select top 1 a.*,b.TagName as TagName from Ideas  a left join Tag b on a.Tag = b.IDTag where IID = @IID
		select a.*,b.FullName as Crt_Name from IdeaComment a inner join BosUser b on a.Crt_User = b.UserCode where a.IID = @IID order by a.Crt_Date desc
	end
END
GO
/****** Object:  StoredProcedure [dbo].[getKeyEnCrypt]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getKeyEnCrypt] 
	@UserName nvarchar(50) = ''
AS
BEGIN
	select * from BosUser with(nolock) where UserName = @UserName
END
GO
/****** Object:  StoredProcedure [dbo].[GetListIdeas]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetListIdeas] 
	@isOption nvarchar(100)= 'MostView' --New/Offline/MostView/TopLike

AS
BEGIN
	begin
	if @isOption =  'New'
		begin
			select a.IID,a.Title,a.Content,a.IsActive,a.IsOnline,a.isOption,a.LikeNumb,a.DisLikeNumb,a.View_numb,a.Date_Online,a.Tag,b.TagName as TagName,c.FullName as CrtName
			from Ideas  a with(nolock)
			left join Tag b with(nolock) on a.Tag = b.IDTag 
			inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
			where a.isActive = 1 and a.IsOnline = 1 and a.Date_Online between a.StartDate and a.EndDate 
			order by a.Date_Online desc
		end
	end
	begin
	if @isOption =  'MostView'
		begin
			select a.IID,a.Title,a.Content,a.IsActive,a.IsOnline,a.isOption,a.LikeNumb,a.DisLikeNumb,a.View_numb,a.Date_Online,a.Tag,b.TagName as TagName,c.FullName as CrtName
			from Ideas  a with(nolock)
			left join Tag b with(nolock) on a.Tag = b.IDTag 
			inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
			where a.isActive = 1 and a.IsOnline = 1   and a.Date_Online between a.StartDate and a.EndDate  and a.View_numb <> 0
			order by a.View_numb desc
		end
	end
	begin
	if @isOption =  'Offline'
		begin
			select a.IID,a.Title,a.Content,a.IsActive,a.IsOnline,a.isOption,a.LikeNumb,a.DisLikeNumb,a.View_numb,a.Date_Online,a.Tag,b.TagName as TagName,c.FullName as CrtName
			from Ideas  a with(nolock)
			left join Tag b with(nolock) on a.Tag = b.IDTag 
			inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
			where a.isActive = 1 and a.IsOnline = 0  
			order by a.Date_Online desc
		end
	end
	begin
	if @isOption =  'TopLike'
		begin
			select a.IID,a.Title,a.Content,a.IsActive,a.IsOnline,a.isOption,a.LikeNumb,a.DisLikeNumb,a.View_numb,a.Date_Online,a.Tag,b.TagName as TagName,c.FullName as CrtName
			from Ideas  a with(nolock)
			left join Tag b with(nolock) on a.Tag = b.IDTag 
			inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
			where a.isActive = 1 and a.IsOnline = 1   and a.Date_Online between a.StartDate and a.EndDate  and a.LikeNumb <> 0
			order by a.LikeNumb desc
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[Like_Dis_View]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Like_Dis_View]
	@IID nvarchar(50) = '',
	@Option nvarchar(50) = 'LikeorDisLike',--LikeorDisLike,View
	@UserLike nvarchar(max)= '',
	@LikeNumb int = 0,
	@UserDisLike nvarchar(max)= '',
	@DisLikeNumb int = 0,
	@ViewNumb int = 0
AS
BEGIN
	if @Option = 'LikeorDisLike'
	begin
		update Ideas
		set LikeNumb = @LikeNumb,UserLike = @UserLike,DisLikeNumb = @DisLikeNumb,UserDisLike = @UserDisLike
		where IID = @IID
	end
	
	if @Option = 'View'
	begin
		if exists (select IID from Ideas  where IID = @IID and IsOnline = 1)
		begin
			update Ideas
			set View_numb = @ViewNumb
			where IID = @IID
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[LoginUser]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LoginUser] 
	@UserName nvarchar(50) = '',
	@Password varchar(50) = ''
AS
BEGIN
	select * from BosUser with(nolock) where UserName = @UserName and Password = @Password 
END
GO
/****** Object:  StoredProcedure [dbo].[QA_Update]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[QA_Update] 
	@Tag nvarchar(10) = '',
	@IID nchar(30) = ''
AS
BEGIN
	Update Ideas
	set Tag = @Tag,IsOnline = 1,Date_Online = Getdate()
	where IID = @IID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insertIdeaComments]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insertIdeaComments]
@IID		 varchar(30)= '',
@Comment	 nvarchar(MAX)= '',
@Crt_User	 varchar(5)= '',
@Crt_Date	 datetime= ''
AS
BEGIN
	begin
		insert into IdeaComment(IID, Comment, Crt_User, Crt_Date)
			values(
				@IID,	
				@Comment,
				@Crt_User,	
				@Crt_Date
			)
	end
	begin
		select a.*,b.FullName as Crt_Name from IdeaComment a inner join BosUser b on a.Crt_User = b.UserCode where a.IID = @IID order by a.Crt_Date desc
	end
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insertIdeas]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insertIdeas]
@IID		 varchar(30)= '',
@Title		 nvarchar(200)= '',
@Content	 nvarchar(MAX)= '',
@Crt_User	 varchar(5)= '',
@Crt_Date	 datetime= '',
@IsActive	 bit= 0,
@IsOnline	 bit= 0,
@View_numb	 int= 0,
@StartDate	 datetime= '',
@EndDate	 datetime= '',
@LikeNumb	 int= 0,
@DisLikeNumb int= 0,
@FileName	 nvarchar(500)= '',
@FilePath	 nvarchar(500)= '',
@isOption	 bit= 0,
@Date_Online datetime= ''
AS
BEGIN
	begin
		if not exists (select IID  from Ideas where IID = @IID)
		begin
			insert into Ideas(IID, Title, [Content], Crt_User, Crt_Date, IsActive, IsOnline, View_numb, StartDate, EndDate, LikeNumb, DisLikeNumb, FileName, FilePath, isOption,Date_Online,UserLike,UserDisLike)
			values(
				@IID,	
				@Title,		
				@Content,	
				@Crt_User,	
				@Crt_Date,	
				@IsActive,
				@IsOnline,
				@View_numb,	
				@StartDate,	
				@EndDate,	
				@LikeNumb,	
				@DisLikeNumb,
				@FileName,	
				@FilePath,	
				@isOption,
				@Date_Online,
				'',
				''
			)
		end
	else
		begin
			Update Ideas
			set
				Title=@Title,		
				Content=@Content,	
				Crt_User=@Crt_User,	
				StartDate=@StartDate,	
				EndDate=@EndDate,
				isOption=@isOption
			where IID = @IID
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[sp_oid]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_oid]
AS
BEGIN
	select FORMAT( CURRENT_TIMESTAMP,'yyMMdd:hhmmssfff') as ab
END
GO
/****** Object:  StoredProcedure [dbo].[statistical]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[statistical]
	
AS
declare @a int = 0
declare @b int = 0
declare @c int = 0
BEGIN
	--IT
	select @a = count(a.IID)
	from Ideas  a with(nolock)
	inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
	where a.isActive = 1 and a.IsOnline = 1 and a.Date_Online between a.StartDate and a.EndDate and c.Position = 'PS03'
	--Business
	select @b = count(a.IID)  
	from Ideas  a with(nolock)
	inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
	where a.isActive = 1 and a.IsOnline = 1 and a.Date_Online between a.StartDate and a.EndDate and c.Position = 'PS04'
	--Computer Science
	select @c =count(a.IID)
	from Ideas  a with(nolock)
	inner join BosUser c with(nolock) on a.Crt_User = c.UserCode
	where a.isActive = 1 and a.IsOnline = 1 and a.Date_Online between a.StartDate and a.EndDate and c.Position = 'PS05'

	select @a as IT,@b as Business,@c as CS
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateStaffInfo]    Script Date: 2022-03-14 10:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateStaffInfo]
@UserCode nvarchar(10)= '',
@Password	nvarchar(50) = '',
@FullName	nvarchar(50) = '',
@Email	nvarchar(50) = '',
@Address	nvarchar(100) = '',
@NumberPhone	nvarchar(10) = '',
@Position	nchar(10) = ''
AS
BEGIN
	update BosUser
	set Password=@Password,
		FullName=@FullName,
		Email=@Email,
		Address=@Address,
		NumberPhone=@NumberPhone,
		Position=@Position
	Where UserCode = @UserCode
END
GO
