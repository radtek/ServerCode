USE [QPGameMatchDB]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchWebShow](
	[MatchID] [int] NOT NULL,
	[MatchNo] [smallint] NOT NULL,
	[SmallImageUrl] [nvarchar](512) NOT NULL CONSTRAINT [DF_MatchInfo_ImageUrl]  DEFAULT (''),
	[BigImageUrl] [nvarchar](512) NOT NULL CONSTRAINT [DF_MatchInfo_ImageUrl_1]  DEFAULT (''),
	[MatchSummary] [nvarchar](256) NOT NULL CONSTRAINT [DF_MatchTypeInfo_TypeSummary]  DEFAULT (''),
	[MatchContent] [ntext] NOT NULL,
	[IsRecommend] [bit] NOT NULL CONSTRAINT [DF_MatchInfo_IsRecommend]  DEFAULT ((1)),
 CONSTRAINT [PK_GameMatchInfo] PRIMARY KEY CLUSTERED 
(
	[MatchID] ASC,
	[MatchNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛场次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'SmallImageUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'BigImageUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛摘要' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'MatchSummary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'MatchContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否推荐至首页' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchWebShow', @level2type=N'COLUMN',@level2name=N'IsRecommend'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDrawInfo](
	[DrawID] [int] IDENTITY(1,1) NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[UserCount] [int] NOT NULL,
	[AndroidCount] [int] NOT NULL,
	[Waste] [bigint] NOT NULL,
	[Revenue] [bigint] NOT NULL,
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_RecordDrawInfo_UserMedal]  DEFAULT ((0)),
	[StartTime] [datetime] NOT NULL,
	[ConcludeTime] [datetime] NOT NULL,
	[InsertTime] [datetime] NOT NULL CONSTRAINT [DF_RecordDrawInfo_InsertTime]  DEFAULT (getdate()),
	[DrawCourse] [image] NULL,
 CONSTRAINT [PK_RecordDrawInfo_DrawID] PRIMARY KEY CLUSTERED 
(
	[DrawID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'局数标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'DrawID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'桌子号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'TableID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'UserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'AndroidCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'损耗数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'Waste'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'ConcludeTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'InsertTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏过程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawInfo', @level2type=N'COLUMN',@level2name=N'DrawCourse'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemStreamInfo](
	[DateID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[LogonCount] [int] NOT NULL CONSTRAINT [DF_TABLE1_LogonCount]  DEFAULT ((0)),
	[RegisterCount] [int] NOT NULL CONSTRAINT [DF_GameEnterInfo_LogonCount1]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_TABLE1_RecordDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_SystemStreamInfo] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[KindID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'LogonCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemStreamInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameScoreInfo](
	[UserID] [int] NOT NULL,
	[UserRight] [int] NOT NULL CONSTRAINT [DF_GameScoreInfo_UserRight]  DEFAULT ((0)),
	[MasterRight] [int] NOT NULL CONSTRAINT [DF_GameScoreInfo_MasterRight]  DEFAULT ((0)),
	[MasterOrder] [tinyint] NOT NULL CONSTRAINT [DF_GameScoreInfo_MasterOrder]  DEFAULT ((0)),
	[AllLogonTimes] [int] NOT NULL CONSTRAINT [DF_GameScore_AllLogonTimes]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_GameScore_PlayTimeCount_1]  DEFAULT ((0)),
	[OnLineTimeCount] [int] NOT NULL CONSTRAINT [DF_GameScore_OnLineTimeCount]  DEFAULT ((0)),
	[LastLogonIP] [nvarchar](15) NOT NULL,
	[LastLogonDate] [datetime] NOT NULL CONSTRAINT [DF_GameScore_LastLogonDate]  DEFAULT (getdate()),
	[LastLogonMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameScoreInfo_LastLogonMachine]  DEFAULT ('------------'),
 CONSTRAINT [PK_GameScoreInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'MasterRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'MasterOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总登陆次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'AllLogonTimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'OnLineTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上次登陆 IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LastLogonIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上次登陆时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LastLogonDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreInfo', @level2type=N'COLUMN',@level2name=N'LastLogonMachine'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameColumnItem](
	[SortID] [int] NOT NULL,
	[ColumnName] [nvarchar](15) NOT NULL,
	[ColumnWidth] [tinyint] NOT NULL,
	[DataDescribe] [tinyint] NOT NULL,
 CONSTRAINT [PK_GameColumnItem_SortID] PRIMARY KEY CLUSTERED 
(
	[SortID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排列标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列头名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'ColumnName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列表宽度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'ColumnWidth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameColumnItem', @level2type=N'COLUMN',@level2name=N'DataDescribe'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameProperty](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](31) NOT NULL,
	[Cash] [decimal](18, 2) NOT NULL,
	[Gold] [bigint] NOT NULL,
	[Discount] [smallint] NOT NULL CONSTRAINT [DF_GameProperty_Discount]  DEFAULT ((90)),
	[IssueArea] [smallint] NOT NULL CONSTRAINT [DF_GameProperty_SellArea]  DEFAULT ((3)),
	[ServiceArea] [smallint] NOT NULL,
	[SendLoveLiness] [bigint] NOT NULL,
	[RecvLoveLiness] [bigint] NOT NULL,
	[RegulationsInfo] [nvarchar](255) NOT NULL,
	[Nullity] [tinyint] NOT NULL CONSTRAINT [DF_GameProperty_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameProperty] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Cash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Gold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员折扣' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Discount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发行范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'IssueArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ServiceArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增加魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'SendLoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增加魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'RecvLoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'RegulationsInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'禁止标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchLockTime](
	[MatchID] [int] NOT NULL,
	[MatchNo] [smallint] NOT NULL,
	[StartTime] [datetime] NOT NULL CONSTRAINT [DF_MatchLockTime_StartTime]  DEFAULT (getdate()),
	[EndTime] [datetime] NOT NULL CONSTRAINT [DF_MatchLockTime_EndTime]  DEFAULT (getdate()),
	[InitScore] [bigint] NOT NULL CONSTRAINT [DF_MatchLockTime_InitScore]  DEFAULT ((0)),
	[CullScore] [bigint] NOT NULL CONSTRAINT [DF_MatchLockTime_CullScore]  DEFAULT ((0)),
	[MinPlayCount] [int] NOT NULL CONSTRAINT [DF_MatchLockTime_MinPlayCount]  DEFAULT ((0)),
 CONSTRAINT [PK_LockTimeMatch] PRIMARY KEY CLUSTERED 
(
	[MatchID] ASC,
	[MatchNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛场次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'EndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'初始积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'InitScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'淘汰积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'CullScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchLockTime', @level2type=N'COLUMN',@level2name=N'MinPlayCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDrawScore](
	[DrawID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ChairID] [int] NOT NULL CONSTRAINT [DF_RecordDrawScore_ChairID]  DEFAULT ((0)),
	[Score] [bigint] NOT NULL,
	[Grade] [bigint] NOT NULL,
	[Revenue] [bigint] NOT NULL,
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_RecordDrawScore_UserMedal]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_RecordDrawScore_PlayTimeCount]  DEFAULT ((0)),
	[DBQuestID] [int] NOT NULL,
	[InoutIndex] [int] NOT NULL,
	[InsertTime] [datetime] NOT NULL CONSTRAINT [DF_RecordDrawScore_InsertTime]  DEFAULT (getdate())
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'局数标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'DrawID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'椅子号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'ChairID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户成绩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'Grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'请求标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'DBQuestID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进出索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'InoutIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDrawScore', @level2type=N'COLUMN',@level2name=N'InsertTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineAddress](
	[AddrString] [nvarchar](15) NOT NULL,
	[EnjoinLogon] [bit] NOT NULL CONSTRAINT [DF_AddrConfineRule_EnjoinLogon]  DEFAULT ((0)),
	[EnjoinOverDate] [datetime] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_AddrConfineRule_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](32) NOT NULL CONSTRAINT [DF_AddrConfineRule_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_ConfineAddress_AddrString] PRIMARY KEY CLUSTERED 
(
	[AddrString] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址字符' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'AddrString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制登陆' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinLogon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过期时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'EnjoinOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输入备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineAddress', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchPublic](
	[MatchID] [int] NOT NULL,
	[MatchNo] [smallint] NOT NULL CONSTRAINT [DF_MatchInfo_MatchNumber]  DEFAULT ((1)),
	[KindID] [int] NOT NULL CONSTRAINT [DF_MatchPublic_KindID]  DEFAULT ((0)),
	[MatchName] [nvarchar](50) NOT NULL CONSTRAINT [DF_MatchInfo_MatchName]  DEFAULT (''),
	[MatchType] [tinyint] NOT NULL CONSTRAINT [DF_MatchInfo_MatchType]  DEFAULT ((0)),
	[MatchFeeType] [tinyint] NOT NULL,
	[MatchFee] [bigint] NOT NULL,
	[MemberOrder] [tinyint] NOT NULL CONSTRAINT [DF_MatchInfo_JoinMemberType]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_MatchInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_MatchPublic] PRIMARY KEY CLUSTERED 
(
	[MatchID] ASC,
	[MatchNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛场次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MatchName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛类型 0:定时赛 1:即时赛' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MatchType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扣费类型 0:金币 1:元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MatchFeeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扣费数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MatchFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参加条件 会员类型大于或等于该值的玩家可参加' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'MemberOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchPublic', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfineMachine](
	[MachineSerial] [nvarchar](32) NOT NULL,
	[EnjoinLogon] [bit] NOT NULL CONSTRAINT [DF_MachineConfineRule_EnjoinLogon]  DEFAULT ((0)),
	[EnjoinRegister] [bit] NOT NULL CONSTRAINT [DF_MachineConfineRule_EnjoinRegister]  DEFAULT ((0)),
	[EnjoinOverDate] [datetime] NOT NULL,
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_MachineConfineRule_CollectDate]  DEFAULT (getdate()),
	[CollectNote] [nvarchar](32) NOT NULL CONSTRAINT [DF_MachineConfineRule_CollectNote]  DEFAULT (''),
 CONSTRAINT [PK_MachineConfineRule_MachineSerial] PRIMARY KEY CLUSTERED 
(
	[MachineSerial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器序列' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'MachineSerial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制登录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinLogon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'限制注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinRegister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过期时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'EnjoinOverDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输入备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfineMachine', @level2type=N'COLUMN',@level2name=N'CollectNote'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameScoreLocker](
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[EnterID] [int] NOT NULL,
	[EnterIP] [nvarchar](15) NOT NULL CONSTRAINT [DF_GameScoreLocker_EnterIP]  DEFAULT (N''),
	[EnterMachine] [nvarchar](32) NOT NULL CONSTRAINT [DF_GameScoreLocker_RegisterMachine]  DEFAULT (N''),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_GameScoreLocker_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_GameScoreLocker_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进出索引' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'EnterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'EnterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'EnterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameScoreLocker', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordUserInout](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[EnterTime] [datetime] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterTime]  DEFAULT (getdate()),
	[EnterScore] [bigint] NOT NULL,
	[EnterInsure] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterInsure]  DEFAULT ((0)),
	[EnterUserMedal] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterUserMedal_1]  DEFAULT ((0)),
	[EnterLoveliness] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_EnterLoveliness]  DEFAULT ((0)),
	[EnterMachine] [nvarchar](33) NOT NULL CONSTRAINT [DF_RecordUserInout_EnterMachine]  DEFAULT (N''),
	[EnterClientIP] [nvarchar](15) NOT NULL,
	[LeaveTime] [datetime] NULL,
	[LeaveReason] [int] NULL,
	[LeaveMachine] [nvarchar](32) NULL,
	[LeaveClientIP] [nvarchar](15) NULL,
	[Score] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Score]  DEFAULT ((0)),
	[Insure] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Insure_1]  DEFAULT ((0)),
	[Revenue] [bigint] NOT NULL CONSTRAINT [DF_RecordUserInout_Revenue_1]  DEFAULT ((0)),
	[WinCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_WinCount]  DEFAULT ((0)),
	[LostCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_LostCount]  DEFAULT ((0)),
	[DrawCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_DrawCount]  DEFAULT ((0)),
	[FleeCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_FleeCount]  DEFAULT ((0)),
	[UserMedal] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_UserMedal_1]  DEFAULT ((0)),
	[LoveLiness] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_LoveLiness]  DEFAULT ((0)),
	[Experience] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_Experience]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_PlayTimeCount]  DEFAULT ((0)),
	[OnLineTimeCount] [int] NOT NULL CONSTRAINT [DF_RecordUserInout_OnLineTimeCount]  DEFAULT ((0)),
 CONSTRAINT [PK_RecordUserInout_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'索引标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入银行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterInsure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterUserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入魅力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterLoveliness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'EnterClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离开原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进入机器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveMachine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LeaveClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Insure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'胜局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'WinCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LostCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'和局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'DrawCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'逃局变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'FleeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖牌数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'UserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'魅力变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'LoveLiness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经验变更' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'Experience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordUserInout', @level2type=N'COLUMN',@level2name=N'OnLineTimeCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchScoreInfo](
	[UserID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[MatchID] [int] NOT NULL,
	[MatchNo] [int] NOT NULL,
	[Score] [bigint] NOT NULL CONSTRAINT [DF_MatchScoreInfo_Score]  DEFAULT ((0)),
	[WinCount] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_WinCount]  DEFAULT ((0)),
	[LostCount] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_LostCount]  DEFAULT ((0)),
	[DrawCount] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_DrawCount]  DEFAULT ((0)),
	[FleeCount] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_FleeCount]  DEFAULT ((0)),
	[UserRight] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_UserRight]  DEFAULT ((0)),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_PlayTimeCount]  DEFAULT ((0)),
	[OnlineTime] [int] NOT NULL CONSTRAINT [DF_MatchScoreInfo_OnlineTime]  DEFAULT ((0)),
	[SignupTime] [datetime] NOT NULL CONSTRAINT [DF_MatchScoreInfo_UpdateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_MatchScoreInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ServerID] ASC,
	[MatchID] ASC,
	[MatchNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'场次编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛分数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'胜利局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'WinCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'失败局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'LostCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'打平局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'DrawCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'逃跑局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'FleeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'OnlineTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报名时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchScoreInfo', @level2type=N'COLUMN',@level2name=N'SignupTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchImmediate](
	[MatchID] [int] NOT NULL,
	[MatchNo] [smallint] NOT NULL CONSTRAINT [DF_MatchImmediate_MatchNo]  DEFAULT ((0)),
	[StartUserCount] [int] NOT NULL CONSTRAINT [DF_MatchImmediate_StartUserCount]  DEFAULT ((0)),
	[AndroidUserCount] [int] NOT NULL CONSTRAINT [DF_MatchImmediate_AndroidUserCount]  DEFAULT ((0)),
	[InitialBase] [int] NOT NULL CONSTRAINT [DF_MatchImmediate_InitBase]  DEFAULT ((1)),
	[InitialScore] [int] NOT NULL CONSTRAINT [DF_MatchImmediate_InitScore]  DEFAULT ((0)),
	[MinEnterGold] [int] NOT NULL CONSTRAINT [DF_MatchImmediate_EnterGold]  DEFAULT ((0)),
	[PlayCount] [tinyint] NOT NULL CONSTRAINT [DF_MatchImmediate_PlayCount]  DEFAULT ((1)),
	[SwitchTableCount] [tinyint] NOT NULL CONSTRAINT [DF_MatchImmediate_SwitchTableCount]  DEFAULT ((0)),
	[PrecedeTimer] [int] NOT NULL CONSTRAINT [DF_MatchImmediate_PrecedeTimer]  DEFAULT ((1)),
 CONSTRAINT [PK_MatchImmediate] PRIMARY KEY CLUSTERED 
(
	[MatchID] ASC,
	[MatchNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开赛人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'StartUserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'一组比赛中最大机器人数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'AndroidUserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'初始基数(即初始游戏底分)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'InitialBase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'初始比赛分(为0时 表示使用当前金币为比赛分)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'InitialScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少进入金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'MinEnterGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'PlayCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'换桌局数(为0时 表示不换桌)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'SwitchTableCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'能得到优先分配的等待时间(单位 秒)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchImmediate', @level2type=N'COLUMN',@level2name=N'PrecedeTimer'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchReward](
	[MatchID] [int] NOT NULL,
	[MatchNo] [smallint] NOT NULL,
	[MatchRank] [smallint] NOT NULL,
	[RewardGold] [bigint] NOT NULL CONSTRAINT [DF_MatchAward_AwardGold]  DEFAULT ((0)),
	[RewardMedal] [int] NOT NULL CONSTRAINT [DF_MatchAward_AwardMedal]  DEFAULT ((0)),
	[RewardExperience] [int] NOT NULL CONSTRAINT [DF_MatchAward_AwardExperience]  DEFAULT ((0)),
	[RewardDescibe] [nvarchar](128) NULL,
 CONSTRAINT [PK_MatchAward] PRIMARY KEY CLUSTERED 
(
	[MatchID] ASC,
	[MatchNo] ASC,
	[MatchRank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛场次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchReward', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励的游戏币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchReward', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励的元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchReward', @level2type=N'COLUMN',@level2name=N'RewardMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励的经验值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchReward', @level2type=N'COLUMN',@level2name=N'RewardExperience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MatchReward', @level2type=N'COLUMN',@level2name=N'RewardDescibe'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StreamMatchHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[MatchID] [int] NOT NULL,
	[MatchNo] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_TypeID]  DEFAULT ((0)),
	[MatchType] [tinyint] NOT NULL CONSTRAINT [DF_StreamMatchHistory_MatchType]  DEFAULT ((0)),
	[ServerID] [int] NOT NULL,
	[RankID] [smallint] NOT NULL,
	[MatchScore] [int] NOT NULL,
	[UserRight] [int] NOT NULL,
	[RewardGold] [int] NOT NULL,
	[RewardMedal] [int] NOT NULL,
	[RewardExperience] [int] NOT NULL,
	[WinCount] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_WinCount]  DEFAULT ((0)),
	[LostCount] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_LostCount]  DEFAULT ((0)),
	[DrawCount] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_DrawCount]  DEFAULT ((0)),
	[FleeCount] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_FleeCount]  DEFAULT ((0)),
	[MatchStartTime] [datetime] NOT NULL CONSTRAINT [DF_StreamMatchHistory_FristStartTime]  DEFAULT (getdate()),
	[MatchEndTime] [datetime] NOT NULL CONSTRAINT [DF_StreamMatchHistory_LastEndTime]  DEFAULT (getdate()),
	[PlayTimeCount] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_PlayDureation]  DEFAULT ((0)),
	[OnlineTime] [int] NOT NULL CONSTRAINT [DF_StreamMatchHistory_OnlineDuration]  DEFAULT ((0)),
	[Machine] [nvarchar](32) NOT NULL CONSTRAINT [DF_StreamMatchHistory_Machine]  DEFAULT (''),
	[ClientIP] [nvarchar](15) NOT NULL,
	[RecordDate] [datetime] NOT NULL CONSTRAINT [DF_StreamMatchHistory_RecordDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_StreamMatchHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛场次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'MatchType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛名次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'RankID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛得分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'MatchScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户权限 如：有进入下一论的权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'UserRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'RewardMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励经验' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'RewardExperience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赢的局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'WinCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'输的局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'LostCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平的局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'DrawCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'逃跑局数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'FleeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛第一局开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'MatchStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛最后一句结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'MatchEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长 单位:秒' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'在线时长 单位:秒' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'OnlineTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'机器码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'Machine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchHistory', @level2type=N'COLUMN',@level2name=N'RecordDate'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StreamMatchFeeInfo](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[MatchID] [int] NOT NULL,
	[MatchNo] [int] NOT NULL CONSTRAINT [DF_StreamMatchFeeInfo_MacthNo]  DEFAULT ((0)),
	[MatchType] [smallint] NOT NULL CONSTRAINT [DF_StreamMatchFeeInfo_MatchType]  DEFAULT ((0)),
	[MatchFeeType] [smallint] NOT NULL,
	[MatchFee] [bigint] NOT NULL,
	[Effective] [tinyint] NOT NULL CONSTRAINT [DF_StreamMatchFeeInfo_IsValidate]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_StreamMatchFeeInfo_CollectDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_StreamMatchFeeInfo] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'MatchID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'MatchNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报名费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'MatchFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效标识（0为有效 1为无效）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'Effective'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StreamMatchFeeInfo', @level2type=N'COLUMN',@level2name=N'CollectDate'
