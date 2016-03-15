#include "stdafx.h"
#include <iostream>
#include <vector>

template <typename T>
class LinkedNode
{
public:
	T value;
	LinkedNode* m_pPrevious = nullptr;
	LinkedNode* m_pNext = nullptr;

	LinkedNode<T>(T p_value)
	{
		value = p_value;
	}

	void SetPrevious(LinkedNode* p_node)
	{
		m_pPrevious = p_node;
		p_node->m_pNext = this;
	}

	void SetNext(LinkedNode* p_node)
	{
		m_pNext = p_node;
		p_node->m_pPrevious = this;
	}

	bool DetectCirculation()
	{
		std::vector<LinkedNode*> checkList{ this };

		LinkedNode* node = m_pPrevious;
		while (node != nullptr)
		{
			for (LinkedNode* visited : checkList)
			{
				if (node == visited)
					return true;
			}
			checkList.push_back(node);
			node = node->m_pPrevious;
		}

		node = m_pNext;
		while (node != nullptr)
		{
			for (LinkedNode* visited : checkList)
			{
				if (node == visited)
					return true;
			}
			checkList.push_back(node);
			node = node->m_pNext;
		}

		return false;
	}
};

void main()
{
	// insert code here...
	LinkedNode<std::string> node1("Luna");
	LinkedNode<std::string> node2("Star");
	LinkedNode<std::string> node3("Dev");
	LinkedNode<std::string> node4("Luna");

	node1.SetNext(&node2);
	node3.SetNext(&node4);
	node3.SetPrevious(&node2);

	std::cout << node3.DetectCirculation() << std::endl;

	node4.SetNext(&node2);

	std::cout << node1.DetectCirculation() << std::endl;
}