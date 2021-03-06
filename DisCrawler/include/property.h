#ifndef __PROPERTY_H__
#define __PROPERTY_H__
#include <string>
#include <iostream>
#include <fstream>
#define LINUX_SUSE          1
#define OS                  LINUX_SUSE



/*-----------------------------------------------------------
		Page Analysis Macro Define
  -----------------------------------------------------------*/
#define LOG_LEVEL 1
#define LOG				if(LOG_LEVEL<=1) std::cout<<"LOG------------------------------LOG\n"
#define DEBUG				if(LOG_LEVEL<=1) std::cout
#define INFO				if(LOG_LEVEL<=2) std::cout
#define ERROR				if(LOG_LEVEL<=3) std::cout

/*
   每个blocknode最大的权重
   */
#define BLOCK_MAX_WEIGHT		100

/*
   每个cluster最多有多少个blocklist对象
   */
#define BLOCK_NUMBER_IN_A_CLUSTER	10

/*
   如果blocks之间的相似度大于此值，则两个blocks是同一个类
   */
#define SIMILAR_THRESHOLD		0.97
#define WRAP_SIMILAR_THRESHOLD		0.9

/*
   如果同一个cluster中，各个blocklists之间相似度如果大于此值，则此cluster无效
   */
#define SIMILAR_CONTENT_THRESHOLD	0.6

/*
   如果一个cluster中的链接文字比大于此值，则此cluster为链接块
   */
#define LINK_BLOCK_THRESHOLD		0.7

/*
   如果一个cluster中的文字权重大于此值，则此cluster为内容块
   */
#define MIN_CONTENT_LENGTH		50

/*
   如果一个cluster中的，相同blocknodes之间相似度如果大于此值，则此blocknode为广告节点
   */
#define SIMILAR_NODE_THRESHOLD		SIMILAR_CONTENT_THRESHOLD

/*
   如果一个页面的content比例大于此值，则此页面为内容页
   */
#define CONTENT_PAGE_THRESHOLD		0.3

/*
   title length (unit:byte; encode:utf8)
   */
#define AVERAGE_TITLE_LENGTH		54

#define RULE_SEPARATOR			"->"
#define RULE_LINE_SEPARATOR		"\\n"
#define RULE_TITLE                      "title"
#define RULE_AUTHOR_SOURCE              "a&s"
#define RULE_AUTHOR                     "author"
#define RULE_SOURCE                     "source"
#define RULE_DATE                       "date"
#define RULE_MAIN_NODE                  "mn"
#define RULE_AD_NODE                    "ad"

#define XPATH_WITH_ATTRIBUTE		true

#define CONTENT_BLOCK			1
#define LINK_BLOCK			2
#define CHANNEL_BLOCK			4
#define INVALID_BLOCK			0

#endif
