#include "Stdafx.h"
#include "GameOption.h"
#include "GameClient.h"
#include "GameClientEngine.h"

//////////////////////////////////////////////////////////////////////////

//定时器标识
#define IDI_NULLITY					200									//无效定时器
#define IDI_START_GAME				201									//开始定时器
#define IDI_CALL_BANKER				202									//开始定时器

//定时器标识
#define IDI_TIME_USER_ADD_SCORE		1									//加注定时器
#define IDI_TIME_OPEN_CARD			2									//摊牌定时器

//时间标识
#ifdef _DEBUG
#define TIME_USER_CALL_BANKER		30									//叫庄定时器
#define TIME_USER_START_GAME		30									//开始定时器
#define TIME_USER_ADD_SCORE			30									//放弃定时器
#define TIME_USER_OPEN_CARD			30									//摊牌定时器
#else
#define TIME_USER_CALL_BANKER		30									//叫庄定时器
#define TIME_USER_START_GAME		30									//开始定时器
#define TIME_USER_ADD_SCORE			30									//放弃定时器
#define TIME_USER_OPEN_CARD			30									//摊牌定时器

#endif

//////////////////////////////////////////////////////////////////////////

BEGIN_MESSAGE_MAP(CGameClientEngine, CGameFrameEngine)

	ON_MESSAGE(IDM_HINT_OX,OnHintOx)
	ON_MESSAGE(IDM_START,OnStart)
	ON_MESSAGE(IDM_ADD_SCORE,OnAddScore)
	ON_MESSAGE(IDM_OX,OnOx)
	ON_MESSAGE(IDM_SHORTCUT_KEY,OnShortcut)
	ON_MESSAGE(IDM_READY,OnOpenCard)
	ON_MESSAGE(IDM_SEND_CARD_FINISH,OnSendCardFinish)
	ON_MESSAGE(IDM_SHOW_VALUE,OnSetUserOxValue)
	ON_MESSAGE(IDM_SHOW_INFO,OnShowInfo)
	ON_MESSAGE(IDM_OX_ENABLE,OnOxEnable)
	ON_MESSAGE(IDM_SORT,OnSortCard)
	ON_MESSAGE(IDM_RESORT,OnReSortCard)
	ON_MESSAGE(IDM_BANKER,OnBanker)
	ON_MESSAGE(IDM_CLICK_CARD,OnClickCard)
	ON_WM_TIMER()

END_MESSAGE_MAP()

//////////////////////////////////////////////////////////////////////////

//构造函数
CGameClientEngine::CGameClientEngine()
{
	//配置变量
	m_dwCardHSpace=DEFAULT_PELS;

	//加注信息
	m_lTurnMaxScore=0L;
	//m_lTurnLessScore=0L;
	ZeroMemory(m_lTableScore,sizeof(m_lTableScore));
	ZeroMemory(m_cbHandCardData,sizeof(m_cbHandCardData));
	ZeroMemory(m_bUserOxCard,sizeof(m_bUserOxCard));

	//状态变量
	m_wBankerUser=INVALID_CHAIR;
	ZeroMemory(m_szNickNames,sizeof(m_szNickNames));
	ZeroMemory(m_cbPlayStatus,sizeof(m_cbPlayStatus));

	return;
}

//析构函数
CGameClientEngine::~CGameClientEngine()
{
}

//初始函数
bool CGameClientEngine::OnInitGameEngine()
{
	//全局对象
	CGlobalUnits * m_pGlobalUnits=(CGlobalUnits *)CGlobalUnits::GetInstance();
	ASSERT(m_pGlobalUnits!=NULL);

	//设置图标
	HICON hIcon=LoadIcon(AfxGetInstanceHandle(),MAKEINTRESOURCE(IDR_MAINFRAME));
	m_pIClientKernel->SetGameAttribute(KIND_ID,GAME_PLAYER,VERSION_CLIENT,hIcon,GAME_NAME);
	SetIcon(hIcon,TRUE);
	SetIcon(hIcon,FALSE);

	//读取配置
	m_dwCardHSpace=AfxGetApp()->GetProfileInt(TEXT("GameOption"),TEXT("CardSpace"),DEFAULT_PELS);

	//调整参数
	if ((m_dwCardHSpace>MAX_PELS)||(m_dwCardHSpace<LESS_PELS)) m_dwCardHSpace=18;

	//配置控件
	for (int i=0;i<GAME_PLAYER;i++)
	{
		m_GameClientView.m_CardControlOx[i].SetDisplayFlag(true);
		m_GameClientView.m_CardControlOx[i].SetCardSpace(m_dwCardHSpace);
		m_GameClientView.m_CardControl[i].SetCardSpace(m_dwCardHSpace);
	}

	//测试代码
#ifdef _DEBUG
	

	//m_GameClientView.m_btShortcut.ShowWindow(SW_SHOW);
	//BYTE bTemp[]={1,2,3,4,5};
	//for (BYTE i=0;i<GAME_PLAYER;i++)
	//{
	//	m_GameClientView.m_CardControl[i].SetDisplayFlag(true);
	//	m_GameClientView.m_CardControl[i].SetCardData(bTemp,5);
	//	//m_GameClientView.m_CardControlOx[i].SetDisplayFlag(true);
	//	//m_GameClientView.m_CardControlOx[i].SetCardData(bTemp,2);
	//}
	//m_GameClientView.m_CardControl[2].SetPositively(true);

#endif
	return true;
}

//重置框架
bool CGameClientEngine::OnResetGameEngine()
{
	//加注信息
	m_lTurnMaxScore=0L;
	//m_lTurnLessScore=0L;
	ZeroMemory(m_lTableScore,sizeof(m_lTableScore));
	ZeroMemory(m_cbHandCardData,sizeof(m_cbHandCardData));
	ZeroMemory(m_bUserOxCard,sizeof(m_bUserOxCard));

	//状态变量
	m_wBankerUser=INVALID_CHAIR;
	ZeroMemory(m_szNickNames,sizeof(m_szNickNames));
	ZeroMemory(m_cbPlayStatus,sizeof(m_cbPlayStatus));

	return true;
}

//游戏设置
void CGameClientEngine::OnGameOptionSet()
{
	//构造数据
	CGameOption GameOption;
	GameOption.m_dwCardHSpace=m_dwCardHSpace;
	GameOption.m_bEnableSound= m_pGlobalUnits->m_bAllowSound;
	GameOption.m_bAllowLookon= m_pGlobalUnits->m_bAllowLookon;

	//配置数据
	if (GameOption.DoModal()==IDOK)
	{
		//设置扑克
		m_dwCardHSpace=GameOption.m_dwCardHSpace;
		for (int i=0;i<GAME_PLAYER;i++) 
		{
			m_GameClientView.m_CardControl[i].SetCardSpace(m_dwCardHSpace);
			m_GameClientView.m_CardControlOx[i].SetCardSpace(m_dwCardHSpace);
		}

		//设置配置
		m_pGlobalUnits->m_bAllowSound = GameOption.m_bEnableSound;
		m_pGlobalUnits->m_bAllowLookon = GameOption.m_bAllowLookon;

		//保存配置
		AfxGetApp()->WriteProfileInt(TEXT("GameOption"),TEXT("CardSpace"),m_dwCardHSpace);
	}

	return;
}

//时钟删除
bool CGameClientEngine::OnEventGameClockKill(WORD wChairID)
{
	return true;
}

//时间消息
bool CGameClientEngine::OnEventGameClockInfo(WORD wChairID, UINT nElapse, WORD wClockID)
{
	switch (wClockID)
	{
	case IDI_START_GAME:		//开始定时器
		{
			//中止判断
			if (nElapse==0)
			{
				AfxGetMainWnd()->PostMessage(WM_CLOSE,0,0);
				return false;
			}

			//警告通知
			if (nElapse<=5) PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_WARN"));

			return true;
		}
	case IDI_NULLITY:			//过滤时器
		{
			//中止判断
			if (nElapse==0)
			{
				KillGameClock(IDI_NULLITY);
				return false;
			}

			//警告通知
			if (nElapse<=5) PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_WARN"));
			return true;
		}
	case IDI_CALL_BANKER:		//叫庄定时
		{
			//中止判断
			if (nElapse==0)
			{
				//测试代码
				//放弃做庄
				OnBanker(0,0);
				return false;
			}

			//警告通知
			if (nElapse<=5) PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_WARN"));
			return true;			
		}
	}

	return false;
}

//旁观状态
bool CGameClientEngine::OnEventLookonMode(VOID * pData, WORD wDataSize)
{
     return true;
}

//网络消息
bool CGameClientEngine::OnEventGameMessage(WORD wSubCmdID, VOID * pData, WORD wDataSize)
{
	switch (wSubCmdID)
	{
	case SUB_S_CALL_BANKER:	//用户叫庄
		{
			//消息处理
			return OnSubCallBanker(pData,wDataSize);
		}
	case SUB_S_GAME_START:	//游戏开始
		{
			//消息处理
			return OnSubGameStart(pData,wDataSize);
		}
	case SUB_S_ADD_SCORE:	//用户下注
		{
			//消息处理
			return OnSubAddScore(pData,wDataSize);
		}
	case SUB_S_SEND_CARD:	//发牌消息
		{
			//消息处理
			return OnSubSendCard(pData,wDataSize);
		}
	case SUB_S_OPEN_CARD:	//用户摊牌
		{
			//消息处理
			return OnSubOpenCard(pData,wDataSize);
		}
	case SUB_S_PLAYER_EXIT:	//用户强退
		{
			//消息处理
			return OnSubPlayerExit(pData,wDataSize);
		}
	case SUB_S_GAME_END:	//游戏结束
		{
			//结束动画
			m_GameClientView.FinishDispatchCard();

			//消息处理
			return OnSubGameEnd(pData,wDataSize);
		}
	}

	return false;
}

//游戏场景
bool CGameClientEngine::OnEventSceneMessage(BYTE cbGameStatus, bool bLookonUser, VOID * pData, WORD wDataSize)
{
	if(IsLookonMode())m_GameClientView.m_bLookOnUser=true;
	switch (cbGameStatus)
	{
	case GAME_STATUS_FREE:		//空闲状态
		{
			//效验数据
			if (wDataSize!=sizeof(CMD_S_StatusFree)) return false;
			CMD_S_StatusFree * pStatusFree=(CMD_S_StatusFree *)pData;

			//设置控件
			if (IsLookonMode()==false && GetMeUserItem()->GetUserStatus()!=US_READY)
			{
				SetGameClock(GetMeChairID(),IDI_START_GAME,TIME_USER_START_GAME);
				m_GameClientView.m_btStart.ShowWindow(SW_SHOW);
				m_GameClientView.m_btStart.SetFocus();
			}

			return true;
		}
	case GS_TK_CALL:	// 叫庄状态
		{
			//效验数据
			if (wDataSize!=sizeof(CMD_S_StatusCall)) return false;
			CMD_S_StatusCall * pStatusCall=(CMD_S_StatusCall *)pData;

			//游戏信息
			CopyMemory(m_cbPlayStatus,pStatusCall->cbPlayStatus,sizeof(m_cbPlayStatus));

			//用户信息
			for (WORD i=0;i<GAME_PLAYER;i++)
			{
				//视图位置
				m_wViewChairID[i]=SwitchViewChairID(i);
				m_GameClientView.SetUserPlayingStatus(m_wViewChairID[i],m_cbPlayStatus[i]);

				//桌面筹码
				if(m_lTableScore[i]>0L)m_GameClientView.SetUserTableScore(m_wViewChairID[i],m_lTableScore[i]);
				
				//获取用户
				IClientUserItem * pUserData=GetTableUserItem(i);
				if (pUserData==NULL) continue;
				
				//用户名字
				lstrcpyn(m_szNickNames[i],pUserData->GetNickName(),CountArray(m_szNickNames[i]));
			}
			
			//始叫用户
			if(!IsLookonMode() && pStatusCall->wCallBanker==GetMeChairID())
			{
				//控件显示
				//ActiveGameFrame();
				m_GameClientView.m_btBanker.ShowWindow(SW_SHOW);
				m_GameClientView.m_btIdler.ShowWindow(SW_SHOW);
			}

			//等待标志
			WORD wViewID=m_wViewChairID[pStatusCall->wCallBanker];
			m_GameClientView.SetWaitCall((BYTE)wViewID);
			

			//实际定时器
			if(pStatusCall->wCallBanker==GetMeChairID())
			{
				SetGameClock(pStatusCall->wCallBanker,IDI_CALL_BANKER,TIME_USER_CALL_BANKER);
			}
			else 
			{
				SetGameClock(pStatusCall->wCallBanker,IDI_NULLITY,TIME_USER_CALL_BANKER);
			}

			return true;
		}
	case GS_TK_SCORE:	//下注状态
		{
			//效验数据
			if (wDataSize!=sizeof(CMD_S_StatusScore)) return false;
			CMD_S_StatusScore * pStatusScore=(CMD_S_StatusScore *)pData;

			//设置变量
			m_lTurnMaxScore=pStatusScore->lTurnMaxScore;
			m_wBankerUser=pStatusScore->wBankerUser;
			CopyMemory(m_lTableScore,pStatusScore->lTableScore,sizeof(m_lTableScore));
			CopyMemory(m_cbPlayStatus,pStatusScore->cbPlayStatus,sizeof(m_cbPlayStatus));

			for (WORD i=0;i<GAME_PLAYER;i++)
			{
				//视图位置
				m_wViewChairID[i]=SwitchViewChairID(i);
				m_GameClientView.SetUserPlayingStatus(m_wViewChairID[i],m_cbPlayStatus[i]);

				//桌面筹码
				if(m_lTableScore[i]>0L)m_GameClientView.SetUserTableScore(m_wViewChairID[i],m_lTableScore[i]);
				
				//获取用户
				IClientUserItem * pUserData=GetTableUserItem(i);
				if (pUserData==NULL) continue;
				
				
				//用户名字
				lstrcpyn(m_szNickNames[i],pUserData->GetNickName(),CountArray(m_szNickNames[i]));
			}

			//设置筹码
			if (!IsLookonMode() && pStatusScore->lTurnMaxScore>0L && m_lTableScore[GetMeChairID()]==0L)
			{
				LONGLONG lUserMaxScore[GAME_PLAYER];
				ZeroMemory(lUserMaxScore,sizeof(lUserMaxScore));
				LONGLONG lTemp=m_lTurnMaxScore;
				for (WORD i=0;i<GAME_PLAYER;i++)
				{
					if(i>0)lTemp/=2;
					lUserMaxScore[i]=__max(lTemp,1L);
				}

				//更新控件
				UpdateScoreControl(lUserMaxScore,SW_SHOW);

				//实际定时器
				SetTimer(IDI_TIME_USER_ADD_SCORE,(TIME_USER_ADD_SCORE)*1000,NULL);
			}

			//庄家标志
			WORD wID=m_wViewChairID[m_wBankerUser];
			m_GameClientView.SetBankerUser(wID);

			//等待标志
			m_GameClientView.SetWaitInvest(true);


			//辅助显示中心时钟
			SetGameClock(GetMeChairID(),IDI_NULLITY,TIME_USER_ADD_SCORE);

			return true;
		}
	case GS_TK_PLAYING:	//游戏状态
		{
			//效验数据
			if (wDataSize!=sizeof(CMD_S_StatusPlay)) return false;
			CMD_S_StatusPlay * pStatusPlay=(CMD_S_StatusPlay *)pData;

			//设置变量
			m_lTurnMaxScore=pStatusPlay->lTurnMaxScore;
			m_wBankerUser=pStatusPlay->wBankerUser;
			CopyMemory(m_lTableScore,pStatusPlay->lTableScore,sizeof(m_lTableScore));
			CopyMemory(m_bUserOxCard,pStatusPlay->bOxCard,sizeof(m_bUserOxCard));
			CopyMemory(m_cbPlayStatus,pStatusPlay->cbPlayStatus,sizeof(m_cbPlayStatus));

			for (WORD i=0;i<GAME_PLAYER;i++)
			{
				//视图位置
				m_wViewChairID[i]=SwitchViewChairID(i);
				m_GameClientView.SetUserPlayingStatus(m_wViewChairID[i],m_cbPlayStatus[i]);

				//桌面筹码
				if(m_lTableScore[i]>0L)m_GameClientView.SetUserTableScore(m_wViewChairID[i],m_lTableScore[i]);
				
				//获取用户
				IClientUserItem * pUserData=GetTableUserItem(i);
				if (pUserData==NULL) continue;				

				//扑克数据
				CopyMemory(m_cbHandCardData[i],pStatusPlay->cbHandCardData[i],MAX_COUNT);

				//用户名字
				lstrcpyn(m_szNickNames[i],pUserData->GetNickName(),CountArray(m_szNickNames[i]));
			}

			//庄家标志
			WORD wID=m_wViewChairID[m_wBankerUser];
			m_GameClientView.SetBankerUser(wID);

			//左上信息
			//m_GameClientView.SetScoreInfo(m_lTurnMaxScore,0);

			//设置界面
			LONGLONG lTableScore=0L;
			for (WORD i=0;i<GAME_PLAYER;i++)
			{
				//设置位置
				WORD wViewChairID=m_wViewChairID[i];

				//设置扑克
				if (m_cbPlayStatus[i]==USEX_PLAYING) 
				{
					m_GameClientView.m_CardControl[wViewChairID].SetCardData(pStatusPlay->cbHandCardData[i],MAX_COUNT);
				}
			}

			WORD wMeChiarID=GetMeChairID();
			WORD wViewChairID=m_wViewChairID[wMeChiarID];
			if(!IsLookonMode())m_GameClientView.m_CardControl[wViewChairID].SetPositively(true);
			if(IsAllowLookon() || !IsLookonMode())
			{				
				m_GameClientView.m_CardControl[wViewChairID].SetDisplayFlag(true);
			}

			//摊牌标志
			for (WORD i=0;i<GAME_PLAYER;i++)
			{
				if (m_cbPlayStatus[i]!=USEX_PLAYING) continue;
				if(m_bUserOxCard[i]!=0xff)
				{
					m_GameClientView.ShowOpenCard(m_wViewChairID[i]);
				}
			}

			//控件处理
			if(!IsLookonMode())
			{
				//显示控件
				if(m_bUserOxCard[wMeChiarID]==0xff)
				{
					OnSendCardFinish(0,0);
				}
				else 
				{
					m_GameClientView.m_CardControl[wViewChairID].SetPositively(false);
					if(m_bUserOxCard[wMeChiarID]==TRUE)//牛牌分类
					{
						//设置变量
						BYTE bTemp[MAX_COUNT];
						CopyMemory(bTemp,m_cbHandCardData[wMeChiarID],sizeof(bTemp));

						//获取牛牌
						m_GameLogic.GetOxCard(bTemp,MAX_COUNT);

						BYTE bCardValue=m_GameLogic.GetCardType(bTemp,MAX_COUNT);
						ASSERT(bCardValue>0);

						if(bCardValue<OX_THREE_SAME)
						{
							//设置控件
							m_GameClientView.m_CardControl[wViewChairID].SetCardData(bTemp,3);
							m_GameClientView.m_CardControlOx[wViewChairID].SetCardData(&bTemp[3],2);	
						}

						//显示点数
						m_GameClientView.SetUserOxValue(wViewChairID,bCardValue);
					}
					else 
					{
						//无牛
						m_GameClientView.SetUserOxValue(wViewChairID,0);
					}					
				}
			}
			return true;
		}
	}

	return false;
}

//用户叫庄
bool CGameClientEngine::OnSubCallBanker(const void * pBuffer, WORD wDataSize)
{
	//效验数据
	if (wDataSize!=sizeof(CMD_S_CallBanker)) return false;
	CMD_S_CallBanker * pCallBanker=(CMD_S_CallBanker *)pBuffer;

	//首次叫庄
	if(pCallBanker->bFirstTimes)
	{
		//用户信息
		for (WORD i=0;i<GAME_PLAYER;i++)
		{
			//视图位置
			m_wViewChairID[i]=SwitchViewChairID(i);

			//获取用户
			IClientUserItem * pUserData=GetTableUserItem(i);
			if (pUserData==NULL)
			{
				m_cbPlayStatus[i]=USEX_NULL;
			}
			else
			{
				m_cbPlayStatus[i]=USEX_PLAYING;

				//用户名字
				lstrcpyn(m_szNickNames[i],pUserData->GetNickName(),CountArray(m_szNickNames[i]));
			}			

			//设置界面
			m_GameClientView.SetUserPlayingStatus(m_wViewChairID[i],m_cbPlayStatus[i]);
		}

		//旁观者清理数据
		if (IsLookonMode()) OnStart(0,0);
	}

	//删除定时器/按钮
	if(m_GameClientView.m_btIdler.IsWindowVisible()==TRUE)
	{
		KillGameClock(IDI_CALL_BANKER);
		m_GameClientView.m_btIdler.ShowWindow(SW_HIDE);
		m_GameClientView.m_btBanker.ShowWindow(SW_HIDE);
	}

	//用户控件显示
	if(IsCurrentUser(pCallBanker->wCallBanker))
	{
		m_GameClientView.m_btBanker.ShowWindow(SW_SHOW);
		m_GameClientView.m_btIdler.ShowWindow(SW_SHOW);
	}

	//等待标志
	WORD wViewID=m_wViewChairID[pCallBanker->wCallBanker];
	m_GameClientView.SetWaitCall((BYTE)wViewID);

	//实际定时器
	if(pCallBanker->wCallBanker==GetMeChairID())
	{
		SetGameClock(pCallBanker->wCallBanker,IDI_CALL_BANKER,TIME_USER_CALL_BANKER);
	}
	else SetGameClock(pCallBanker->wCallBanker,IDI_NULLITY,TIME_USER_CALL_BANKER);

	return true;
}

//游戏开始
bool CGameClientEngine::OnSubGameStart(const void * pBuffer, WORD wDataSize)
{
	//效验数据
	if (wDataSize!=sizeof(CMD_S_GameStart)) return false;
	CMD_S_GameStart * pGameStart=(CMD_S_GameStart *)pBuffer;

	//删除定时器/按钮
	if(m_GameClientView.m_btIdler.IsWindowVisible()==TRUE)
	{
		KillGameClock(IDI_CALL_BANKER);
		m_GameClientView.m_btIdler.ShowWindow(SW_HIDE);
		m_GameClientView.m_btBanker.ShowWindow(SW_HIDE);
	}

	//设置变量
	m_lTurnMaxScore=pGameStart->lTurnMaxScore;
	m_wBankerUser=pGameStart->wBankerUser;
	m_GameClientView.SetWaitCall(0xff);

	//设置界面
	m_GameClientView.m_btStart.ShowWindow(SW_HIDE);

	//设置筹码
	if (!IsLookonMode() && pGameStart->lTurnMaxScore>0)
	{
		LONGLONG lUserMaxScore[GAME_PLAYER];
		ZeroMemory(lUserMaxScore,sizeof(lUserMaxScore));
		LONGLONG lTemp=m_lTurnMaxScore;
		for (WORD i=0;i<GAME_PLAYER;i++)
		{
			if(i>0)lTemp/=2;
			lUserMaxScore[i]=__max(lTemp,1L);
		}

		//更新控件
		//ActiveGameFrame();
		UpdateScoreControl(lUserMaxScore,SW_SHOW);

		//实际定时器
		SetTimer(IDI_TIME_USER_ADD_SCORE,(TIME_USER_ADD_SCORE)*1000,NULL);
	}

	//庄家标志
	WORD wID=m_wViewChairID[m_wBankerUser];
	m_GameClientView.SetBankerUser(wID);

	//等待标志
	m_GameClientView.SetWaitInvest(true);

	//辅助显示中心时钟
	SetGameClock(GetMeChairID(),IDI_NULLITY,TIME_USER_ADD_SCORE);

	//环境设置
	PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_START"));

	return true;
}

//用户下注
bool CGameClientEngine::OnSubAddScore(const void * pBuffer, WORD wDataSize)
{
	//效验数据
	if (wDataSize!=sizeof(CMD_S_AddScore)) return false;
	CMD_S_AddScore * pAddScore=(CMD_S_AddScore *)pBuffer;

	//删除定时器/控制按钮
	if(IsCurrentUser(pAddScore->wAddScoreUser) && m_GameClientView.m_btOneScore.IsWindowVisible()==TRUE)
	{
		KillTimer(IDI_TIME_USER_ADD_SCORE);
		UpdateScoreControl(NULL,SW_HIDE);
	}

	//变量定义
	WORD wAddScoreUser=pAddScore->wAddScoreUser;
	WORD wViewChairID=m_wViewChairID[wAddScoreUser];

	//加注界面
	m_lTableScore[pAddScore->wAddScoreUser]=pAddScore->lAddScoreCount;
	m_GameClientView.SetUserTableScore(wViewChairID,pAddScore->lAddScoreCount);

	//播放声音
	if (!IsCurrentUser(pAddScore->wAddScoreUser) && m_cbPlayStatus[wAddScoreUser]==USEX_PLAYING)
		PlayGameSound(AfxGetInstanceHandle(),TEXT("ADD_SCORE"));

	return true;
}

//发牌消息
bool CGameClientEngine::OnSubSendCard(const void * pBuffer, WORD wDataSize)
{
	//效验数据
	if (wDataSize!=sizeof(CMD_S_SendCard)) return false;
	CMD_S_SendCard * pSendCard=(CMD_S_SendCard *)pBuffer;

	//删除定时器
	KillGameClock(IDI_NULLITY);

	m_GameClientView.SetWaitInvest(false);

	CopyMemory(m_cbHandCardData,pSendCard->cbCardData,sizeof(m_cbHandCardData));

	WORD wMeChiarID=GetMeChairID();
	WORD wViewChairID=m_wViewChairID[wMeChiarID];
	if((IsAllowLookon() || !IsLookonMode()) && m_cbPlayStatus[wMeChiarID]==USEX_PLAYING)
	{
		m_GameClientView.m_CardControl[wViewChairID].SetDisplayFlag(true);
	}

	//派发扑克
	for(WORD i=0;i<MAX_COUNT;i++)
	{
		for (WORD j=m_wBankerUser;j<m_wBankerUser+GAME_PLAYER;j++)
		{
			WORD w=j%GAME_PLAYER;
			if (m_cbPlayStatus[w]==USEX_PLAYING)
			{
				WORD wViewChairID=m_wViewChairID[w];
				if(pSendCard->cbCardData[w][i]!=0)
				{
					m_GameClientView.DispatchUserCard(wViewChairID,m_cbHandCardData[w][i]);
				}
			}
		}
	}

	return true;
}

//用户摊牌
bool CGameClientEngine::OnSubOpenCard(const void * pBuffer, WORD wDataSize)
{
	//效验数据
	if (wDataSize!=sizeof(CMD_S_Open_Card)) return false;
	CMD_S_Open_Card * pOpenCard=(CMD_S_Open_Card *)pBuffer;

	//设置变量
	WORD wMeChairID=GetMeChairID();
	WORD wID=pOpenCard->wPlayerID;
	WORD wViewChairID=m_wViewChairID[wID];
	m_bUserOxCard[wID]=pOpenCard->bOpen;
	m_GameClientView.ShowOpenCard(wViewChairID);

	//摊牌标志
	if(!IsCurrentUser(wID))
	{
		PlayGameSound(AfxGetInstanceHandle(),TEXT("OPEN_CARD"));
	}
	else if(m_GameClientView.m_btOpenCard.IsWindowVisible()==TRUE)
	{
		//删除时间/控件
		KillTimer(IDI_TIME_OPEN_CARD);
		m_GameClientView.m_btOx.ShowWindow(SW_HIDE);
		m_GameClientView.m_btOpenCard.ShowWindow(SW_HIDE);
		m_GameClientView.m_btHintOx.ShowWindow(SW_HIDE);
		m_GameClientView.m_btReSort.ShowWindow(SW_HIDE);
		m_GameClientView.m_btShortcut.ShowWindow(SW_HIDE);

		//显示不构成牛牛
		if(m_bUserOxCard[wID]==FALSE)
		{
			m_GameClientView.m_CardControl[wViewChairID].ShootAllCard(false);
			m_GameClientView.SetUserOxValue(wViewChairID,0);
		}
		else
		{
			//提示再分类牛牌
			OnHintOx(0,0);
			m_GameClientView.m_CardControl[wViewChairID].SetOX(true);
			OnSortCard(0,0);
		}
		m_GameClientView.m_CardControl[wViewChairID].SetPositively(false);
	}

	return true;
}

//用户强退
bool CGameClientEngine::OnSubPlayerExit(const void * pBuffer, WORD wDataSize)
{
	//效验数据
	if (wDataSize!=sizeof(CMD_S_PlayerExit)) return false;
	CMD_S_PlayerExit * pPlayerExit=(CMD_S_PlayerExit *)pBuffer;

	WORD wID=pPlayerExit->wPlayerID;

	//游戏信息
	ASSERT(m_cbPlayStatus[wID]!=USEX_NULL);
	m_cbPlayStatus[wID]=USEX_NULL;

	//用户名字
	for(WORD i=0;i<32;i++)m_szNickNames[wID][i]=0;
	m_szNickNames[wID][0] = '#';

	BYTE bCount=0;
	for(WORD i=0;i<GAME_PLAYER;i++)if(m_cbPlayStatus[i]==USEX_PLAYING)bCount++;
	if(bCount==1)m_GameClientView.SetBankerUser(INVALID_CHAIR);

	return true;

}

//游戏结束
bool CGameClientEngine::OnSubGameEnd(const void * pBuffer, WORD wDataSize)
{
	//效验参数
	if (wDataSize!=sizeof(CMD_S_GameEnd)) return false;
	CMD_S_GameEnd * pGameEnd=(CMD_S_GameEnd *)pBuffer;

	//删除定时器
	KillGameClock(IDI_NULLITY);
	KillGameClock(IDI_CALL_BANKER);
	KillTimer(IDI_TIME_USER_ADD_SCORE);
	KillTimer(IDI_TIME_OPEN_CARD);

	//清理数据
	for(WORD i=0;i<GAME_PLAYER;i++)
	{
		m_GameClientView.ShowOpenCard(i,FALSE);
	}	
	m_GameClientView.SetWaitInvest(false);
	UpdateScoreControl(NULL,SW_HIDE);
	m_GameClientView.m_btOx.ShowWindow(SW_HIDE);
	m_GameClientView.m_btHintOx.ShowWindow(SW_HIDE);
	m_GameClientView.m_btOpenCard.ShowWindow(SW_HIDE);
	m_GameClientView.m_btReSort.ShowWindow(SW_HIDE);
	m_GameClientView.m_btShortcut.ShowWindow(SW_HIDE);
	m_GameClientView.m_btBanker.ShowWindow(SW_HIDE);
	m_GameClientView.m_btIdler.ShowWindow(SW_HIDE);
	m_GameClientView.SetWaitCall(0xff);
	m_GameClientView.m_bOpenCard=false;

	//状态设置
	SetGameStatus(GAME_STATUS_FREE);

	//播放声音
	if (IsLookonMode()==false)
	{
		if (pGameEnd->lGameScore[GetMeChairID()]>0L) PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_WIN"));
		else PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_LOST"));
	}
	else PlayGameSound(GetModuleHandle(NULL),TEXT("GAME_END"));

	//显示积分
	for (WORD i=0;i<GAME_PLAYER;i++)
	{
		if(GetTableUserItem(i)!=NULL)m_GameClientView.ShowScore(m_wViewChairID[i],true);
		m_GameClientView.SetUserTableScore(m_wViewChairID[i],pGameEnd->lGameScore[i]);
	}
	m_GameClientView.m_ScoreView.ResetScore();
	for (WORD i=0;i<GAME_PLAYER;i++)
	{
		//设置信息
		if (pGameEnd->lGameScore[i]!=0L || i==m_wBankerUser)
		{
			m_GameClientView.m_ScoreView.SetGameTax(pGameEnd->lGameTax[i],i);
			if (m_szNickNames[i][0]=='#') m_GameClientView.m_ScoreView.SetGameScore(i,TEXT("已离开"),pGameEnd->lGameScore[i]);
			else m_GameClientView.m_ScoreView.SetGameScore(i,m_szNickNames[i],pGameEnd->lGameScore[i]);
		}
	}


	//显示牌型
	bool bOxSound=false;
	for (WORD i=0;i<GAME_PLAYER;i++)
	{
		WORD wViewChairID=m_wViewChairID[i];
		if(i==GetMeChairID() && !IsLookonMode())continue;
		m_GameClientView.m_CardControl[wViewChairID].SetDisplayFlag(true);

		//牛牛牌型
		if(m_cbHandCardData[i][0]>0)
		{
			if(m_bUserOxCard[i]==TRUE)
			{
				//扑克数据
				BYTE bCardData[MAX_COUNT];
				CopyMemory(bCardData,m_cbHandCardData[i],sizeof(bCardData));

				//获取牛牛数据
				m_GameLogic.GetOxCard(bCardData,MAX_COUNT);

				BYTE bCardValue=m_GameLogic.GetCardType(bCardData,MAX_COUNT);
				ASSERT(bCardValue>0);

				//加载数据
				if(bCardValue<OX_THREE_SAME)
				{
					m_GameClientView.m_CardControl[wViewChairID].SetCardData(bCardData,3);
					m_GameClientView.m_CardControlOx[wViewChairID].SetCardData(&bCardData[3],2);
				}

				//显示点数
				if(bCardValue>=10)bOxSound=true;
				m_GameClientView.SetUserOxValue(wViewChairID,bCardValue);
			}
			else
			{
				//无牛
				m_GameClientView.SetUserOxValue(wViewChairID,0);
			}
		}
	}
	//m_GameClientView.DisplayType(true);

	//牛牛声音
	if(bOxSound)
	{
		PlayGameSound(AfxGetInstanceHandle(),TEXT("GAME_OXOX"));
	}

	//开始按钮
	if (IsLookonMode()==false)
	{
		m_GameClientView.m_btStart.ShowWindow(SW_SHOW);
		SetGameClock(GetMeChairID(),IDI_START_GAME,TIME_USER_START_GAME);
	}

	//成绩显示在即时聊天对话框
	if(m_pIStringMessage!=NULL)
	{
		TCHAR szBuffer[512]=TEXT("");
		_sntprintf(szBuffer,CountArray(szBuffer),TEXT("本局结束,成绩统计:"));
		m_pIStringMessage->InsertSystemString(szBuffer);
		for (WORD i=0;i<GAME_PLAYER;i++)
		{
			if(m_cbPlayStatus[i]!=USEX_PLAYING) continue;

			//变量定义
			IClientUserItem * pUserData=GetTableUserItem(i);
			//成绩输出
			if (pUserData!=NULL)
			{
				_sntprintf(szBuffer,CountArray(szBuffer),TEXT("\n%s:")SCORE_STRING,pUserData->GetNickName(),pGameEnd->lGameScore[i]);
				m_pIStringMessage->InsertNormalString(szBuffer);
			}
			else if(m_szNickNames[i][0]=='#')
			{
				_sntprintf(szBuffer,CountArray(szBuffer),TEXT("\n%s:")SCORE_STRING,TEXT("用户离开"),pGameEnd->lGameScore[i]);
				m_pIStringMessage->InsertNormalString(szBuffer);
			}
		}
	}
	m_GameClientView.m_ScoreView.ShowWindow(SW_SHOW);
	//状态变量
	m_wBankerUser=INVALID_CHAIR;
	ZeroMemory(m_szNickNames,sizeof(m_szNickNames));
	ZeroMemory(m_cbPlayStatus,sizeof(m_cbPlayStatus));

	return true;
}

//更新控制
void CGameClientEngine::UpdateScoreControl(LONGLONG lScore[],BOOL bShow)
{
	if(lScore!=NULL)
	{
		TCHAR tsz[GAME_PLAYER][LEN_ACCOUNTS];
		ZeroMemory(tsz,sizeof(tsz));
		for(BYTE i=0;i<GAME_PLAYER;i++)
		{
			_sntprintf(tsz[i],sizeof(tsz[i]),SCORE_STRING,lScore[i]);
		}
		m_GameClientView.m_btOneScore.SetWindowText(tsz[0]);
		m_GameClientView.m_btTwoScore.SetWindowText(tsz[1]);
		m_GameClientView.m_btThreeScore.SetWindowText(tsz[2]);
		m_GameClientView.m_btFourScore.SetWindowText(tsz[3]);
	}

	m_GameClientView.m_btOneScore.ShowWindow(bShow);
	m_GameClientView.m_btTwoScore.ShowWindow(bShow);
	m_GameClientView.m_btThreeScore.ShowWindow(bShow);
	m_GameClientView.m_btFourScore.ShowWindow(bShow);

	return ;
}

//提示按钮
LRESULT	CGameClientEngine::OnHintOx(WPARAM wParam, LPARAM lParam)
{
	if(m_GameLogic.GetOxCard(m_cbHandCardData[GetMeChairID()],MAX_COUNT))
	{
		m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].SetShootCard(m_cbHandCardData[GetMeChairID()],3);
		if(m_GameClientView.m_btOx.IsWindowVisible()==FALSE)OnShortcut(0,0);
		OnOxEnable(1,1);
	}
	else 
	{
		m_GameClientView.SetUserOxValue(MY_VIEW_CHAIRID,0);
	}

	return 0;
}

//开始按钮
LRESULT	CGameClientEngine::OnStart(WPARAM wParam, LPARAM lParam)
{
	//删除定时器
	if(!IsLookonMode())KillGameClock(IDI_START_GAME);

	//设置界面
//	m_GameClientView.DisplayType(false);
	m_GameClientView.SetBankerUser(INVALID_CHAIR);
	m_GameClientView.m_btStart.ShowWindow(SW_HIDE);
	m_GameClientView.m_ScoreView.ShowWindow(SW_HIDE);
	m_GameClientView.SetUserTableScore(INVALID_CHAIR,0L);
	m_GameClientView.SetUserPlayingStatus(INVALID_CHAIR,USEX_NULL);

	for (WORD i=0;i<GAME_PLAYER;i++)
	{
		m_GameClientView.ShowScore(i,false);
		m_GameClientView.m_CardControl[i].SetOX(false);
		m_GameClientView.SetUserOxValue(i,0xff);
		m_GameClientView.m_CardControl[i].SetCardData(NULL,0);
		if(i!=m_wViewChairID[GetMeChairID()])m_GameClientView.m_CardControl[i].SetDisplayFlag(false);
		m_GameClientView.m_CardControlOx[i].SetCardData(NULL,0);
	}

	//加注信息
	m_lTurnMaxScore=0L;
	ZeroMemory(m_lTableScore,sizeof(m_lTableScore));
	ZeroMemory(m_bUserOxCard,sizeof(m_bUserOxCard));
	ZeroMemory(m_cbHandCardData,sizeof(m_cbHandCardData));	

	//发送消息
	if(!IsLookonMode())SendUserReady(NULL,0);

	return 0;
}

//加注按钮
LRESULT	CGameClientEngine::OnAddScore(WPARAM wParam, LPARAM lParam)
{
	//删除定时器
	KillTimer(IDI_TIME_USER_ADD_SCORE);

	//获取筹码
	WORD wMeChairID=GetMeChairID();

	BYTE bTemp=(BYTE)wParam;
	LONGLONG lCurrentScore=0;
	if(bTemp==1)lCurrentScore=__max(m_lTurnMaxScore/8,1L);
	else if(bTemp==2)lCurrentScore=__max(m_lTurnMaxScore/4,1L);
	else if(bTemp==3)lCurrentScore=__max(m_lTurnMaxScore/2,1L);
	else if(bTemp==4)lCurrentScore=__max(m_lTurnMaxScore,1L);

	//控制按钮
	UpdateScoreControl(NULL,SW_HIDE);

	//界面设置
	m_lTableScore[wMeChairID]=lCurrentScore;
	m_GameClientView.SetUserTableScore(m_wViewChairID[wMeChairID],m_lTableScore[wMeChairID]);
	PlayGameSound(AfxGetInstanceHandle(),TEXT("ADD_SCORE"));

	//发送消息
	CMD_C_AddScore AddScore;
	AddScore.lScore=lCurrentScore;
	SendSocketData(SUB_C_ADD_SCORE,&AddScore,sizeof(AddScore));

	return 0;
}

//快捷键按钮 
LRESULT CGameClientEngine::OnShortcut(WPARAM wParam, LPARAM lParam)
{
	//WORD wViewChairID=m_wViewChairID[GetMeChairID()];

	//if(m_GameClientView.m_btOx.IsWindowVisible()==FALSE)
	//{
	//	m_GameClientView.m_CardControl[wViewChairID].SetKey(false);
	//	m_GameClientView.m_btOx.ShowWindow(SW_SHOW);
	//}
	//else
	//{
	//	m_GameClientView.m_CardControl[wViewChairID].SetKey(true);
	//	m_GameClientView.m_btOx.ShowWindow(SW_HIDE);
	//}
	//m_GameClientView.m_btOx.EnableWindow(FALSE);

	return 0;
}

//牛牛按钮
LRESULT	CGameClientEngine::OnOx(WPARAM wParam, LPARAM lParam)
{
	//牛牛
	m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].SetOX(true);

	//取消响应
	m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].SetPositively(false);

	//分类牛牌
	OnSortCard(0,0);

	//显示点数
	OnSetUserOxValue(0,0);

	m_GameClientView.m_btOx.EnableWindow(FALSE);

	//直接开牌
	OnOpenCard(0,0);

	return 0;
}

//发牌完成
LRESULT CGameClientEngine::OnSendCardFinish(WPARAM wParam, LPARAM lParam)
{
	//响应扑克
	WORD wMeChairID=GetMeChairID();
	if(!IsLookonMode())m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].SetPositively(true);

	//设置时间
	SetGameClock(wMeChairID,IDI_NULLITY,TIME_USER_OPEN_CARD);

	//过虑观看
	if (IsLookonMode())return 0;

	//特殊牌型
	BYTE bCardType = m_GameLogic.GetCardType(m_cbHandCardData[wMeChairID],MAX_COUNT);
	if(bCardType >= OX_THREE_SAME)
	{
		//提示信息
		m_GameClientView.SetUserAction(true);

		//用户信息
		WORD wViewChairID=m_wViewChairID[wMeChairID];
		m_GameClientView.m_CardControl[wViewChairID].ShootAllCard(false);

		//发送消息
		CMD_C_OxCard OxCard;
		OxCard.bOX=TRUE;
		SendSocketData(SUB_C_OPEN_CARD,&OxCard,sizeof(OxCard));

		//预先处理
		m_GameClientView.ShowOpenCard(wViewChairID);
		m_GameClientView.m_CardControl[wViewChairID].SetPositively(false);

		//显示牌型
		m_GameClientView.SetUserOxValue(wViewChairID,bCardType);

		//保存牛信息
		m_bUserOxCard[wMeChairID]=OxCard.bOX;

		return 0;
	}

	//控件处理
	if(!m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].GetKey())
	{
		m_GameClientView.m_btOx.EnableWindow(FALSE);
	}

	if(m_cbPlayStatus[wMeChairID]==USEX_PLAYING)
	{
		m_GameClientView.m_btOpenCard.ShowWindow(SW_SHOW);
		m_GameClientView.m_btHintOx.ShowWindow(SW_SHOW);
	}

	//等待标志
	m_GameClientView.m_bOpenCard=true;

	//时间设置
	SetTimer(IDI_TIME_OPEN_CARD,TIME_USER_OPEN_CARD*1000,NULL);

	return 0;
}

//摊牌按钮
LRESULT	CGameClientEngine::OnOpenCard(WPARAM wParam, LPARAM lParam)
{
	if(m_GameClientView.m_btOx.IsWindowEnabled()==TRUE)
	{
		//牛牛
		m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].SetOX(true);

		//取消响应
		m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].SetPositively(false);

		//分类牛牌
		OnSortCard(0,0);

		m_GameClientView.m_btOx.EnableWindow(FALSE);
	}

	//删除时间
	KillTimer(IDI_TIME_OPEN_CARD);

	//处理控件
	m_GameClientView.m_btOx.ShowWindow(SW_HIDE);
	m_GameClientView.m_btOpenCard.ShowWindow(SW_HIDE);
	m_GameClientView.m_btHintOx.ShowWindow(SW_HIDE);
	m_GameClientView.m_btReSort.ShowWindow(SW_HIDE);
	m_GameClientView.m_btShortcut.ShowWindow(SW_HIDE);

	WORD wViewChairID=MY_VIEW_CHAIRID;

	//发送消息
	CMD_C_OxCard OxCard;
	OxCard.bOX=(m_GameClientView.m_CardControl[wViewChairID].GetOX())?TRUE:FALSE;
	SendSocketData(SUB_C_OPEN_CARD,&OxCard,sizeof(OxCard));

	//预先处理
	if(OxCard.bOX==FALSE)
	{
		//显示不构成牛牛
		m_GameClientView.m_CardControl[wViewChairID].ShootAllCard(false);
		m_GameClientView.SetUserOxValue(wViewChairID,0);
	}
	m_GameClientView.ShowOpenCard(wViewChairID);
	m_GameClientView.m_CardControl[wViewChairID].SetPositively(false);

	//保存牛信息
	m_bUserOxCard[GetMeChairID()]=OxCard.bOX;

	PlayGameSound(AfxGetInstanceHandle(),TEXT("OPEN_CARD"));

	return 0;
}

//显示点数
LRESULT CGameClientEngine::OnSetUserOxValue(WPARAM wParam, LPARAM lParam)
{
	WORD wViewChairID=m_wViewChairID[GetMeChairID()];

	//获取数据
	BYTE bCardData[MAX_COUNT],bCardCount=0;
	ZeroMemory(bCardData,sizeof(bCardData));
	bCardCount=(BYTE)m_GameClientView.m_CardControlOx[wViewChairID].GetCardCount();
	ASSERT(bCardCount==2);
	m_GameClientView.m_CardControlOx[wViewChairID].GetCardData(bCardData,bCardCount);

	//显示点数
	BYTE bSum=m_GameLogic.GetCardLogicValue(bCardData[0])+m_GameLogic.GetCardLogicValue(bCardData[1]);
	if(bSum>10)bSum-=10;
	m_GameClientView.SetUserOxValue(wViewChairID,bSum);

	return 0;
}

//提示信息
LRESULT CGameClientEngine::OnShowInfo(WPARAM wParam, LPARAM lParam)
{
	//变量定义
	TCHAR szBuffer[64];
	_sntprintf(szBuffer,lstrlen(szBuffer),TEXT("［提示信息］:不能构成牛"));
	if(m_pIStringMessage!=NULL)
		m_pIStringMessage->InsertCustomString(szBuffer,RGB(255,128,0),true);

	return 0;
}

//牛BT为真
LRESULT CGameClientEngine::OnOxEnable(WPARAM wParam, LPARAM lParam)
{
	BYTE bEnable=BYTE(wParam);
	m_GameClientView.m_btOx.EnableWindow(bEnable);
	if(bEnable==TRUE)
	{
		bool bShoot = ((BYTE(lParam)==TRUE)?false:true);
		BYTE cbCardData[MAX_COUNT];
		m_GameClientView.m_CardControl[MY_VIEW_CHAIRID].GetShootCard(cbCardData,bShoot);
		BYTE cbValue=m_GameLogic.GetCardLogicValue(cbCardData[0]);
		cbValue+=m_GameLogic.GetCardLogicValue(cbCardData[1]);
		if(cbValue>10)cbValue-=10;
		m_GameClientView.SetUserOxValue(MY_VIEW_CHAIRID,cbValue);
	}
	else 
	{
		BYTE cbValue=m_GameClientView.GetValue(MY_VIEW_CHAIRID);
		if(cbValue!=0xff && cbValue!=0)
			m_GameClientView.SetUserOxValue(MY_VIEW_CHAIRID,0xff);
	}

	return 0;
}

//扑克分类
LRESULT CGameClientEngine::OnSortCard(WPARAM wParam, LPARAM lParam)
{
	//隐藏控件
	m_GameClientView.m_btHintOx.ShowWindow(SW_HIDE);

	//设置变量
	WORD wViewChairID=m_wViewChairID[GetMeChairID()];

	//弹起数目
	BYTE bCardCount=(BYTE)m_GameClientView.m_CardControl[wViewChairID].GetShootCount();

	//设置变量
	BYTE bCardOxData[MAX_COUNT];
	BYTE bCardValueData[MAX_COUNT];
	ZeroMemory(bCardOxData,sizeof(bCardOxData));
	ZeroMemory(bCardValueData,sizeof(bCardValueData));

	//获取牛牌&点数牌
	if(bCardCount==2)
	{
		BYTE bCount=(BYTE)m_GameClientView.m_CardControl[wViewChairID].GetShootCard(bCardOxData,false);
		ASSERT(bCount==3);
		bCount=(BYTE)m_GameClientView.m_CardControl[wViewChairID].GetShootCard(bCardValueData);
		ASSERT(bCount==2);
	}
	else
	{
		BYTE bCount=(BYTE)m_GameClientView.m_CardControl[wViewChairID].GetShootCard(bCardValueData,false);
		ASSERT(bCount==2);
		bCount=(BYTE)m_GameClientView.m_CardControl[wViewChairID].GetShootCard(bCardOxData);
		ASSERT(bCount==3);
	}

	//设置扑克
	m_GameClientView.m_CardControlOx[wViewChairID].SetCardData(bCardValueData,MAX_COUNT-3);
	m_GameClientView.m_CardControl[wViewChairID].SetCardData(bCardOxData,3);

	return 0;
}

//重排按钮
LRESULT CGameClientEngine::OnReSortCard(WPARAM wParam, LPARAM lParam)
{
	WORD wMeChiarID=GetMeChairID();
	WORD wViewChairID=m_wViewChairID[wMeChiarID];

	//取消牛牛
	if(m_GameClientView.m_CardControl[wViewChairID].GetOX())
	{
		m_GameClientView.m_CardControlOx[wViewChairID].SetCardData(NULL,0);
		m_GameClientView.m_CardControl[wViewChairID].SetCardData(m_cbHandCardData[wMeChiarID],MAX_COUNT);
		m_GameClientView.m_CardControl[wViewChairID].SetPositively(true);
		m_GameClientView.m_CardControl[wViewChairID].SetOX(false);

		//取消显示点数
		m_GameClientView.SetUserOxValue(wViewChairID,0xff);
	}

	return 0;
}

//做庄信息
LRESULT CGameClientEngine::OnBanker(WPARAM wParam, LPARAM lParam)
{
	//删除定时器
	KillGameClock(IDI_CALL_BANKER);

	//控件处理
	m_GameClientView.m_btBanker.ShowWindow(SW_HIDE);
	m_GameClientView.m_btIdler.ShowWindow(SW_HIDE);

	//设置变量
	CMD_C_CallBanker CallBanker;
	CallBanker.bBanker = (BYTE)wParam;

	//发送信息
	SendSocketData(SUB_C_CALL_BANKER,&CallBanker,sizeof(CallBanker));

	return 0;
}

//点击消息
LRESULT CGameClientEngine::OnClickCard(WPARAM wParam, LPARAM lParam)
{
	PlayGameSound(AfxGetInstanceHandle(),TEXT("CLICK_CARD"));
	
	return 0;
}

//定时操作
void CGameClientEngine::OnTimer(UINT nIDEvent)
{
	switch(nIDEvent)
	{
	case IDI_TIME_USER_ADD_SCORE:
		{
			//测试代码
			//m_GameClientView.m_btOpenCard.ShowWindow(SW_SHOW);
			//删除定时器
			KillTimer(IDI_TIME_USER_ADD_SCORE);

			//获取位置
			WORD wMeChairID=GetMeChairID();
			WORD wViewChairID=m_wViewChairID[wMeChairID];

			//控制按钮
			UpdateScoreControl(NULL,SW_HIDE);

			//发送消息
			CMD_C_AddScore AddScore;
			AddScore.lScore=__max(m_lTurnMaxScore/8,1L);
			SendSocketData(SUB_C_ADD_SCORE,&AddScore,sizeof(AddScore));

			//界面设置
			m_lTableScore[wMeChairID]=AddScore.lScore;
			m_GameClientView.SetUserTableScore(wViewChairID,m_lTableScore[wMeChairID]);
			PlayGameSound(AfxGetInstanceHandle(),TEXT("ADD_SCORE"));

			return;
		}
	case IDI_TIME_OPEN_CARD:
		{
			//删除定时器
			KillTimer(IDI_TIME_OPEN_CARD);

			//摊牌
			OnOpenCard(0,0);

			return;
		}
	}

	CGameFrameEngine::OnTimer(nIDEvent);
}
//////////////////////////////////////////////////////////////////////////

