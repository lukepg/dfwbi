/**
 * @file scws.h (core include)
 * @author Hightman Mar
 * @editor set number ; syntax on ; set autoindent ; set tabstop=4 (vim)
 * $Id: scws.h,v 1.6 2009/07/16 14:16:03 hightman Exp $
 */

#ifndef	_SCWS_LIBSCWS_20070531_H_
#define	_SCWS_LIBSCWS_20070531_H_

#ifdef __cplusplus
extern "C" {
#endif

#ifdef HAVE_CONFIG_H
#	include "config.h"
#endif

#include "scws_version.h"
#include "rule.h"
#include "xdict.h"

#define	SCWS_IGN_SYMBOL		0x01
#define	SCWS_SEG_MULTI		0x02
#define	SCWS_XDB_USAGE		0x04
#define	SCWS_DEBUG			0x08
#define	SCWS_DUALITY		0x10

/* hightman.070901: multi segment policy */
#define SCWS_MULTI_NONE     0x0000		// nothing
#define	SCWS_MULTI_SHORT	0x1000		// split long words to short words from left to right
#define	SCWS_MULTI_DUALITY	0x2000		// split every long words(3 chars?) to two chars
#define SCWS_MULTI_ZMAIN    0x4000		// split to main single chinese char atr = j|a|n?|v?
#define	SCWS_MULTI_ZALL		0x8000		// attr = ** , all split to single chars
#define	SCWS_MULTI_MASK		0xff000		// mask check for multi set

#define	SCWS_ZIS_USED		0x8000000

#define	SCWS_YEA			(1)
#define	SCWS_NA				(0)

/* data structures */
typedef struct scws_result *scws_res_t;
struct scws_result
{
	int off;
	float idf;
	unsigned char len;
	char attr[3];
	scws_res_t next;
};

typedef struct scws_topword *scws_top_t;
struct scws_topword
{
	char *word;
	float weight;
	short times;
	char attr[3];
	scws_top_t next;
};

struct scws_zchar
{
	int start;
	int end;
};

typedef struct
{
	xdict_t d;
	rule_t r;
	unsigned char *mblen;
	unsigned int mode;
	unsigned char *txt;
	int zis;
	int len;
	int off;
	int wend;
	scws_res_t res0;
	scws_res_t res1;
	word_t **wmap;
	struct scws_zchar *zmap;
}	scws_st, *scws_t;

/* api: init the scws handler */
scws_t scws_new();	
void scws_free(scws_t s);

/* mode = SCWS_XDICT_XDB | SCWS_XDICT_MEM */
void scws_set_dict(scws_t s, const char *fpath, int mode);
void scws_set_charset(scws_t s, const char *cs);
void scws_set_rule(scws_t s, const char *fpath);

/* set ignore symbol or multi segments */
void scws_set_ignore(scws_t s, int yes);
void scws_set_multi(scws_t s, int mode);
void scws_set_debug(scws_t s, int yes);
void scws_set_duality(scws_t s, int yes);

void scws_send_text(scws_t s, const char *text, int len);
scws_res_t scws_get_result(scws_t s);
void scws_free_result(scws_res_t result);

scws_top_t scws_get_tops(scws_t s, int limit, char *xattr);
void scws_free_tops(scws_top_t tops);

#ifdef __cplusplus
}
#endif

#endif
