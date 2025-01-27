#ifndef SERVER_USER_MANAGER_HEAD_FILE
#define SERVER_USER_MANAGER_HEAD_FILE

#pragma once

#include "AfxTempl.h"
#include "GameServiceHead.h"

//////////////////////////////////////////////////////////////////////////////////

//用户信息
class GAME_SERVICE_CLASS CServerUserItem : public IServerUserItem, public IServerUserService
{
	//友元定义
	friend class CServerUserManager;

	//属性变量
protected:
	tagUserInfo						m_UserInfo;							//用户信息
	tagUserRule						m_UserRule;							//用户规则
	tagUserScore					m_ScoreFormer;						//先前分数
	//tagUserProperty                 m_UserProperty;                     //玩家道具
	CYSArray<tagUserProperty>		m_UserProperty;

	//变更记录
protected:
	tagVariationInfo				m_RecordInfo;						//记录信息
	tagVariationInfo				m_VariationInfo;					//变更信息

	//附加变量
protected:
	DWORD							m_dwUserRight;						//用户权限
	DWORD							m_dwMasterRight;					//管理权限

	//托管变量
protected:
	SCORE	 						m_lTrusteeScore;					//托管积分(身上剩余积分)
	SCORE							m_lRestrictScore;					//限制积分
	SCORE	 						m_lFrozenedScore;					//冻结积分

	//带入设置
	SCORE							m_lDefPutScore;						//默认一次带入多少积分
	SCORE							m_lLowPutScore;						//低于多少带入积分
	SCORE							m_lNextPutScore;					//下次带入金额
	//int								m_iExchangeRatio;					//兑换比例

protected:
	//牌库变量
	DWORD							m_dwCardLibIndex;					//使用牌库索引
	DWORD							m_dwStartLibTime;					//牌库开始使用时间
	DWORD							m_dwStopLibTime;					//牌库结束使用时间
	BYTE							m_cbCardLibEnabled;					//牌库有效标志

	//登录信息
protected:
	DWORD							m_dwDBQuestID;						//请求标识
	DWORD							m_dwLogonTime;						//登录时间
	DWORD							m_dwInoutIndex;						//进出索引

	//最大牌型
protected:
	BYTE							m_cbMaxCardType;
	BYTE							m_aryCardData[MAX_CARD_DATA_COUNT];

	//客户类型
protected:
	bool							m_bAndroidUser;						//机器用户
	bool							m_bCheatUser;						//作弊用户

	//比赛信息
protected:
	DWORD							m_dwSignUpTime;						//报名时间
	BYTE							m_cbSignUpStatus;					//报名状态	
	VOID *							m_pMatchData;						//比赛数据

	//辅助变量
protected:
	bool							m_bTrusteeUser;						//系统托管
	bool							m_bClientReady;						//连接标志
	bool							m_bModifyScore;						//修改标志
	TCHAR							m_szLogonPass[LEN_PASSWORD];		//用户密码
	BYTE							m_cbReUserStatus;					//还原状态

	//系统属性
protected:
	WORD							m_wBindIndex;						//绑定索引
	DWORD							m_dwClientAddr;						//连接地址
	TCHAR							m_szMachineID[LEN_MACHINE_ID];		//机器标识

	//组件接口
protected:
	IServerUserItemSink *			m_pIServerUserItemSink;				//回调接口

	//牌库信息;
public:
	static	DWORD					g_dwCardLibCount;					//牌库总数;
	static	BYTE					g_cbCardLibEnable;					//牌库是否可以使用;
	static	DWORD					g_dwLibStartDateTime;				//牌库开始使用开始时间;
	static	DWORD					g_dwLibEndDateTime;					//牌库结束使用开始时间;
	static	DWORD					g_dwCardLibCustomCount;				//牌库自定义数量;

	//函数定义
protected:
	//构造函数
	CServerUserItem();
	//析构函数
	virtual ~CServerUserItem();

	//基础接口
public:
	//释放对象
	virtual VOID Release() { delete this; }
	//接口查询
	virtual VOID * QueryInterface(REFGUID Guid, DWORD dwQueryVer);

	//属性信息
public:
	//绑带索引
	virtual WORD GetBindIndex() { return m_wBindIndex; }
	//用户地址
	virtual DWORD GetClientAddr() { return m_dwClientAddr; }
	//机器标识
	virtual LPCTSTR GetMachineID() { return m_szMachineID; }
	//是否在线
	virtual bool IsOnline() { return m_wBindIndex!=INVALID_WORD; }

	//登录信息
public:
	//请求标识
	virtual DWORD GetDBQuestID() { return m_dwDBQuestID++; }
	//登录时间
	virtual DWORD GetLogonTime() { return m_dwLogonTime; }
	//记录索引
	virtual DWORD GetInoutIndex() { return m_dwInoutIndex; }

	//用户信息
public:
	//用户信息
	virtual tagUserInfo * GetUserInfo() { return &m_UserInfo; }
	//用户规则
	virtual tagUserRule * GetUserRule() { return &m_UserRule; }
	//道具信息
	virtual CYSArray<tagUserProperty> & GetUserProperty() { return m_UserProperty; }
	//设置道具
	virtual void SetUserProperty(tagUserProperty &Property);
	//增加道具
	virtual void AddUserProperty(tagUserProperty &Property);
	//使用道具
	virtual EN_PROPERTY_ERROR UsedProperty(CMD_GR_C_Property *pProperty, SYSTEMTIME &SystemTime, DWORD &dwPropDBID);
	//时间信息
	virtual tagTimeInfo * GetTimeInfo() { return &m_UserInfo.TimerInfo; }

	//属性信息
public:
	//用户性别
	virtual BYTE GetGender() { return m_UserInfo.cbGender; }
	//用户标识
	virtual DWORD GetUserID() { return m_UserInfo.dwUserID; }
	//用户昵称
	virtual LPCTSTR GetNickName() { return m_UserInfo.szNickName; }
	//用户密码
	virtual LPCTSTR GetPassword() { return	m_szLogonPass; }

	//状态接口
public:
	//桌子号码
	virtual WORD GetTableID() { return m_UserInfo.wTableID; }
	//桌子号码
	virtual WORD GetLastTableID() { return m_UserInfo.wLastTableID; }
	//椅子号码
	virtual WORD GetChairID() { return m_UserInfo.wChairID; }
	//用户状态
	virtual BYTE GetUserStatus() { return m_UserInfo.cbUserStatus; }

	//权限信息
public:
	//用户权限
	virtual DWORD GetUserRight() { return m_dwUserRight; } 
	//管理权限
	virtual DWORD GetMasterRight() { return m_dwMasterRight; } 

	//等级信息
public:
	//用户权限
	virtual BYTE GetMemberOrder() { return m_UserInfo.cbMemberOrder; } 
	//管理权限
	virtual BYTE GetMasterOrder() { return m_UserInfo.cbMasterOrder; } 

	//积分信息
public:
	//用户金币
	virtual SCORE GetUserGold() { return m_UserInfo.lGold; }
	//用户积分
	virtual SCORE GetUserScore() { return m_UserInfo.lScore; }
	//用户钻石
	virtual SCORE GetUserDiamond() { return m_UserInfo.lDiamond; }
	//用户银行
	virtual SCORE GetUserInsure() { return m_UserInfo.lInsure; }

	//玩家最大牌型
	virtual BYTE GetMaxCardData(BYTE* pData, BYTE cbCount);

	//救济金信息
public:
	//领取次数
	virtual BYTE GetBenefitTimes() { return m_UserInfo.cbBenefitTimes; }
	//上次领取时间
	virtual SYSTEMTIME GetLastBenefitTime() { return m_UserInfo.LastBenefitTime; }
	//设置领取信息
	virtual	VOID SetBenefitInfo(tagSendBenefitSuc* pbenefit);

	//托管信息
public:
	//托管积分
	virtual SCORE GetTrusteeScore() { return m_lTrusteeScore; }
	//冻结积分
	virtual SCORE GetFrozenedScore() { return m_lFrozenedScore; }
	//带入积分
	virtual SCORE TakeGold(SCORE lScore, bool isAtOnce = true);
	//其他积分消费
	virtual bool WriteOtherScore(SCORE lScore, BYTE cbType);

	//积分信息
public:
	//用户胜率
	virtual WORD GetUserWinRate();
	//用户输率
	virtual WORD GetUserLostRate();
	//用户和率
	virtual WORD GetUserDrawRate();
	//用户逃率
	virtual WORD GetUserFleeRate();
	//游戏局数
	virtual DWORD GetUserPlayCount() { return m_UserInfo.dwWinCount+m_UserInfo.dwLostCount+m_UserInfo.dwDrawCount+m_UserInfo.dwFleeCount; }

	//效验接口
public:
	//对比帐号
	virtual bool ContrastNickName(LPCTSTR pszNickName);
	//对比密码
	virtual bool ContrastLogonPass(LPCTSTR pszPassword);

	//托管状态
public:
	//判断状态
	virtual bool IsTrusteeUser() { return m_bTrusteeUser; }
	//设置状态
	virtual VOID SetTrusteeUser(bool bTrusteeUser) { m_bTrusteeUser=bTrusteeUser; }

	//游戏状态
public:
	//连接状态
	virtual bool IsClientReady() { return m_bClientReady; };
	//设置连接
	virtual VOID SetClientReady(bool bClientReady) { m_bClientReady=bClientReady; }
	//还原状态;
	virtual BYTE GetReUserStatus(){ return m_cbReUserStatus; }
	//设置还原状态;
	virtual void SetReUserStatus(BYTE cbReUserStatus) { m_cbReUserStatus = cbReUserStatus; }

	//控制用户
public:
	//控制状态
	virtual bool IsAndroidUser() { return m_bAndroidUser; }
	//设置控制
	virtual VOID SetAndroidUser(bool bAndroidUser) { m_bAndroidUser=bAndroidUser; }
	//作弊用户
	virtual bool IsCheatUser() { return m_bCheatUser; }
	//设置作弊用户
	virtual void SetCheatUser(bool bFlag) { m_bCheatUser = bFlag; }

	//比赛接口
public:
	//报名数据
	virtual VOID * GetMatchData() { return m_pMatchData; }
	//报名数据
	virtual VOID SetMatchData(VOID * pMatchData) { m_pMatchData=pMatchData; }
	//报名时间
	virtual DWORD GetSignUpTime() { return m_dwSignUpTime; }
	//报名时间
	virtual VOID SetSignUpTime(DWORD dwSignUpTime) { m_dwSignUpTime=dwSignUpTime; }
	//报名状态
	virtual BYTE GetSignUpStatus() { return m_cbSignUpStatus; }
	//报名状态
	virtual VOID SetSignUpStatus(BYTE cbSignUpStatus) { m_cbSignUpStatus=cbSignUpStatus; }

	//记录接口
public:
	//变更判断
	virtual bool IsVariation() { return m_bModifyScore; }
	//查询记录
	virtual bool QueryRecordInfo(tagVariationInfo & RecordInfo);
	//提取变更
	virtual bool DistillVariation(tagVariationInfo & VariationInfo);

	//管理接口
public:
	//设置状态
	virtual bool SetUserStatus(BYTE cbUserStatus, WORD wTableID, WORD wChairID);
	//写入积分
    virtual bool WriteUserScore(SCORE lScore, SCORE lGrade, SCORE lRevenue, SCORE lIngot, BYTE cbScoreType, DWORD dwPlayTimeCount,DWORD dwWinExperience);

	//冻结接口
public:
	//冻结积分
	virtual bool FrozenedUserScore(SCORE lScore);
	//解冻积分
	virtual bool UnFrozenedUserScore(SCORE lScore);

	//修改接口
public:
	//修改信息
	virtual bool ModifyUserProperty(SCORE lScore, LONG lLoveLiness);
	//玩家最大牌型
	virtual bool ModifyMaxCardType(BYTE cbCurType, BYTE aryData[], BYTE cbPokerCount);

	//参数接口
public:
	//解除绑定
	virtual bool DetachBindStatus();
	//银行操作
	virtual bool ModifyUserInsure(SCORE lScore, SCORE lInsure, SCORE lRevenue);
	//设置参数
	virtual bool SetUserParameter(DWORD dwClientAddr, WORD wBindIndex, TCHAR szMachineID[LEN_MACHINE_ID], bool bAndroidUser, bool bClientReady);
	//修改权限
	virtual VOID ModifyUserRight( DWORD dwAddRight, DWORD dwRemoveRight, BYTE cbRightKind=UR_KIND_GAME);

	//牌库接口
public:
	//是否可以使用牌库
	virtual bool canUseCardLib();
	//获取牌库索引
	virtual DWORD getCardLibIndex();
	//设置牌库索引
	virtual void setCardLibIndex(DWORD dwCardLibIndex);
	//累加牌库索引
	virtual void addCardLibIndex();
	//设置牌库可用性
	virtual void setCardLibEnabled(bool bEnabled);
	//设置牌库使用时间段
	virtual void setUseCardLibTime(DWORD dwStartTime, DWORD dwEndTime);

	//辅助函数
private:
	//重置数据
	VOID ResetUserItem();
};

//////////////////////////////////////////////////////////////////////////////////

//用户索引类
typedef CYSArray<CServerUserItem *> CServerUserItemArray;
typedef CMap<DWORD,DWORD,CServerUserItem *,CServerUserItem *> CServerUserItemMap;

//用户管理类
class GAME_SERVICE_CLASS CServerUserManager : public IServerUserManager
{
	//用户变量
protected:
	CServerUserItemMap				m_UserIDMap;						//用户索引
	CServerUserItemArray			m_UserItemArray;					//用户数组
	CServerUserItemArray			m_UserItemStore;					//存储用户

	//组件接口
protected:
	IServerUserItemSink *			m_pIServerUserItemSink;				//回调接口

	//函数定义
public:
	//构造函数
	CServerUserManager();
	//析构函数
	virtual ~CServerUserManager();

	//基础接口
public:
	//释放对象
	virtual VOID Release() { return; }
	//接口查询
	virtual VOID * QueryInterface(REFGUID Guid, DWORD dwQueryVer);

	//配置函数
public:
	//设置接口
	virtual bool SetServerUserItemSink(IUnknownEx * pIUnknownEx);

	//查找函数
public:
	//枚举用户
	virtual IServerUserItem * EnumUserItem(WORD wEnumIndex);
	//查找用户
	virtual IServerUserItem * SearchUserItem(DWORD dwUserID);
	//查找用户
	virtual IServerUserItem * SearchUserItem(LPCTSTR pszNickName);

	//统计函数
public:
	//机器人数
	virtual DWORD GetAndroidCount();
	//在线人数
	virtual DWORD GetUserItemCount() { return (DWORD)m_UserItemArray.GetCount(); }

	//管理函数
public:
	//删除用户
	virtual bool DeleteUserItem();
	//删除用户
	virtual bool DeleteUserItem(IServerUserItem * pIServerUserItem);
	//插入用户
	virtual bool InsertUserItem(IServerUserItem * * pIServerUserResult, tagUserInfo & UserInfo,tagUserInfoPlus & UserInfoPlus);
};

//////////////////////////////////////////////////////////////////////////////////

#endif