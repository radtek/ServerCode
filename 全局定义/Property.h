#ifndef PROPERTY_HEAD_FILE
#define PROPERTY_HEAD_FILE

#pragma pack(1)

//////////////////////////////////////////////////////////////////////////////////

//发行范围
#define PT_ISSUE_AREA_WEB			0x01								//商城道具
#define PT_ISSUE_AREA_GAME			0x02								//游戏道具
#define PT_ISSUE_AREA_SERVER		0x04								//房间道具

//使用范围
#define PT_SERVICE_AREA_MESELF		0x0001								//自己范围
#define PT_SERVICE_AREA_PLAYER		0x0002								//玩家范围
#define PT_SERVICE_AREA_LOOKON		0x0004								//旁观范围

//道具类型
#define PT_TYPE_ERROR               0                                   //道具类型 
#define PT_TYPE_PROPERTY            1	                                //道具类型  
#define PT_TYPE_PRESENT             2                                   //道具类型

#define PROPERTY_ID_VIP1_CARD		22									//月会员道具
#define PROPERTY_ID_VIP2_CARD		23									//季度会员道具
#define PROPERTY_ID_VIP3_CARD		24  								//半年会员道具 

//////////////////////////////////////////////////////////////////////////////////

//道具信息
struct tagPropertyInfo
{
	//道具信息
	WORD							wIndex;								//道具标识
	WORD							wDiscount;							//会员折扣
	WORD							wIssueArea;							//发布范围

	//销售价格
	SCORE							lPropertyGold;						//道具金币
	DOUBLE							dPropertyCash;						//道具价格

	//赠送魅力
	SCORE							lSendLoveLiness;					//赠送魅力
	SCORE							lRecvLoveLiness;					//接受魅力
};


//道具属性
struct tagPropertyAttrib
{
	WORD							wIndex;								//道具标识
	WORD                            wPropertyType;                      //道具类型
	WORD							wServiceArea;						//使用范围
	TCHAR                           szMeasuringunit[8];					//计量单位 
	TCHAR							szPropertyName[32];					//道具名字
	TCHAR							szRegulationsInfo[256];				//使用信息
};

//道具子项
struct tagPropertyItem
{
	tagPropertyInfo					PropertyInfo;						//道具信息
	tagPropertyAttrib				PropertyAttrib;						//道具属性
};

//////////////////////////////////////////////////////////////////////////////////

#pragma pack()

#endif