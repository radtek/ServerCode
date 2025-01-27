#include "StdAfx.h"
#include "GamePropertyManager.h"

//////////////////////////////////////////////////////////////////////////////////

CGamePropertyManager* CGamePropertyManager::m_pInstance = NULL;

//构造函数
CGamePropertyManager::CGamePropertyManager()
{
	ASSERT(m_pInstance == NULL);
	m_pInstance = this;
}

//析构函数
CGamePropertyManager::~CGamePropertyManager()
{
	if (m_pInstance == this)
	{
		m_pInstance = NULL;
	}
}

//设置道具
bool CGamePropertyManager::SetGamePropertyInfo(tagPropertyInfo PropertyInfo[], WORD wPropertyCount)
{
	//设置变量
	m_PropertyInfoArray.SetSize(wPropertyCount);

	//拷贝数组
	CopyMemory(m_PropertyInfoArray.GetData(),PropertyInfo,sizeof(tagPropertyInfo)*wPropertyCount);

	return true;
}

//查找道具
tagPropertyInfo * CGamePropertyManager::SearchPropertyItem(WORD wPropertyIndex)
{
	//查找道具
	for (INT_PTR i=0;i<m_PropertyInfoArray.GetCount();i++)
	{
		if (m_PropertyInfoArray[i].wIndex==wPropertyIndex)
		{
			return &m_PropertyInfoArray[i];
		}
	}

	return NULL;
}

//////////////////////////////////////////////////////////////////////////////////
