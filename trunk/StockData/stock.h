#ifndef _TDX_STOCK_H_
#define _TDX_STOCK_H_

#include <fstream>
#include <set>
#include <vector>
#include <boost/date_time/gregorian/gregorian.hpp>
#include <boost/date_time/posix_time/posix_time_types.hpp>
namespace StockMarket
{

using namespace std;
using namespace boost;

enum CmdId
{
    CMD_STOCKHOLD_CHANGE = 0x000f,
    CMD_STOCK_LIST = 0x0524,
    CMD_INSTANT_TRANS = 0x0fc5,	// 0x0fc5, 0x0faf
    CMD_HIS_TRANS = 0x0fb5,
    CMD_HEART_BEAT = 0x0523,
    CMD_STOCK_KLINE = 0x0538
};
const static unsigned char  KLINE_FLAG= 0x4d;
typedef set<string> StringSet;
struct MarketInfo
{
    enum MarketType
    {
        MARKET_FIRST,
        MARKET_SHANGHAI_A = MARKET_FIRST,
        MARKET_SHANGHAI_B,
        MARKET_SHENZHEN_A,
        MARKET_SHENZHEN_B,
        MARKET_MAX,
        MARKET_UNKNOWN = MARKET_MAX,
    };
    static char get_block_from_market_type(MarketType t)
    {
        switch(t)
        {
        case MARKET_SHANGHAI_A:
            return 0;
        case MARKET_SHANGHAI_B:
            return 1;
        case MARKET_SHENZHEN_A:
            return 2;
        case MARKET_SHENZHEN_B:
            return 3;
        default:
            throw 0;
        }
    }
    const static int StocksCodeLen = 6;
    const static int StocksPerHand = 100;	// 100  ��һ��.
    const static float tax=0.003;				// 0.3 %
    static const int max_stocks_a_request = 30;
    static MarketInfo::MarketType get_market_type_from_code(const char* pCode)
    {
        if(pCode[0] == '0')
        {
            if(pCode[1] == '0')
                return MARKET_SHENZHEN_A;
        }
        else if(pCode[0] == '2')
            return MARKET_SHENZHEN_B;
        else if(pCode[0] == '6')
            return MARKET_SHANGHAI_A;
        else if(pCode[0] == '9')
        {
            if(pCode[1] == '0')
                return MARKET_SHANGHAI_B;	// 90xxxx
        }
        else
            return MARKET_UNKNOWN;
    }
    static short get_market_from_code(const char* pCode)
    {
        if(pCode[0] == '0')
        {
            if(pCode[1] == '0')
                return 0;
        }
        else if(pCode[0] == '2')
            return 0;
        else if(pCode[0] == '6')
            return 1;
        else if(pCode[0] == '9')
        {
            if(pCode[1] == '0')
                return 1;	// 90xxxx
        }
        else
            return -1;
    }

    static short get_market_type(const char* pCode)
    {
        return get_market_type_from_code(pCode);
    }

    static short get_market_type(const string& stock_code)
    {
        const char* pCode = stock_code.c_str();
        return get_market_type_from_code(pCode);
    }

    static char get_market_location_from_code(const char* pCode)
    {
        if(pCode[0] <= '4')
            return 0;					// ���� 00xxxx, 03xxxx, 02xxxx, 3xxxxx(����ָ��)
        else
            return 1;					//�Ϻ� 60xxxxx, 58xxxx, 99xxxx (�Ϻ�ָ��)
    }

    static char get_market_location(const char* pCode)
    {
        return get_market_location_from_code(pCode);
    }

    static char get_market_location(const string& stock_code)
    {
        const char* pCode = stock_code.c_str();
        return get_market_location_from_code(pCode);
    }

};
struct KLine
{
    int     date;
    int		open;
    int		close;
    int 	high;
    int 	low;
    int		mount;
};
struct Transact
{
    short		minute;
    int			price;
    int 			vol;
    int 			count;	// �˱ʳɽ����ĳɽ������� 0: ��ʾδ֪
    char		bs;		// ��ʾ��ɽ����������ɽ���0:buy, 1:sell
    bool operator == (const Transact& t)
    {
        minute=t.minute;
        price=t.price;
        vol=t.vol;
        count=t.count;
        bs=t.bs;
    }
};
struct Bid			// �̿�
{
public:
    Bid()
    {
    }
    Bid(std::vector<long> number)
    {
        posix_time::ptime now(posix_time::second_clock::local_time());
        posix_time::time_duration td(now.time_of_day());
        minute = (uint)(td.hours() * 60 + td.minutes());
        if(minute > 15 * 60)
            minute = 15 * 60;
        else if(11 * 60 + 30 < minute && minute < 13 * 60)
            minute = 11 * 60 + 30;
        price=number[0];
        y_close=price+number[1];
        open=price+number[2];
        high=price+number[3];
        low=price+number[4];

        total_vol=number[7];
        avail_vol=number[8];
        inner_vol=number[9];
        outer_vol=number[10];

        updown=number[11];

        buy_price1=price+number[12];
        sell_price1=price+number[13];
        buy_vol1=number[14];
        sell_vol1=number[15];
        buy_price2=price+number[16];
        sell_price2=price+number[17];
        buy_vol2=number[18];
        sell_vol2=number[19];
        buy_price3=price+number[20];
        sell_price3=price+number[21];
        buy_vol3=number[22];
        sell_vol3=number[23];
        buy_price4=price+number[24];
        sell_price4=price+number[25];
        buy_vol4=number[26];
        sell_vol4=number[27];
        buy_price5=price+number[28];
        sell_price5=price+number[29];
        buy_vol5=number[30];
        sell_vol5=number[31];
    }
    void print()
    {
        std::cout<<"minute:"<<minute<<"\n";
        std::cout<<"price:"<<price<<"\n";
        std::cout<<"y_close:"<<y_close<<"\n";
        std::cout<<"open:"<<open<<"\n";
        std::cout<<"high:"<<high<<"\n";
        std::cout<<"low:"<<low<<"\n";

        std::cout<<"total_vol:"<<total_vol<<"\n";
        std::cout<<"avail_vol:"<<avail_vol<<"\n";
        std::cout<<"inner_vol:"<<inner_vol<<"\n";
        std::cout<<"outer_vol:"<<outer_vol<<"\n";

        std::cout<<"updown:"<<updown<<"\n";

        std::cout<<"buy_price1:"<<buy_price1<<"\n";
        std::cout<<"sell_price1:"<<sell_price1<<"\n";
        std::cout<<"buy_vol1:"<<buy_vol1<<"\n";
        std::cout<<"sell_vol1:"<<sell_vol1<<"\n";
        std::cout<<"buy_price2:"<<buy_price2<<"\n";
        std::cout<<"sell_price2:"<<sell_price2<<"\n";
        std::cout<<"buy_vol2:"<<buy_vol2<<"\n";
        std::cout<<"sell_vol2:"<<sell_vol2<<"\n";
        std::cout<<"buy_price3:"<<buy_price3<<"\n";
        std::cout<<"sell_price3:"<<sell_price3<<"\n";
        std::cout<<"buy_vol3:"<<buy_vol3<<"\n";
        std::cout<<"sell_vol3:"<<sell_vol3<<"\n";
        std::cout<<"buy_price4:"<<buy_price4<<"\n";
        std::cout<<"sell_price4:"<<sell_price4<<"\n";
        std::cout<<"buy_vol4:"<<buy_vol4<<"\n";
        std::cout<<"sell_vol4:"<<sell_vol4<<"\n";
        std::cout<<"buy_price5:"<<buy_price5<<"\n";
        std::cout<<"sell_price5:"<<sell_price5<<"\n";
        std::cout<<"buy_vol5:"<<buy_vol5<<"\n";
        std::cout<<"sell_vol5:"<<sell_vol5<<"\n";
    }
    int			minute;
    int			price;			// �ּ�
    int			y_close;			// ����
    int			open;			// ����
    int			high;			// ���
    int			low;				// ���
//    int			buy;			// ����
//    int			sell;			// ����

    int			total_vol;		// ���֣��Թ�������
    int			avail_vol;		// ���֣��Թ�������
    int			inner_vol;		// ����
    int			outer_vol;		// ����

    int			updown;			// ��������

    int			buy_price1;	// ���1
    int			sell_price1;
    int			buy_vol1;	// ����1
    int			sell_vol1;
    int			buy_price2;
    int			sell_price2;
    int			buy_vol2;
    int			sell_vol2;
    int			buy_price3;
    int			sell_price3;
    int			buy_vol3;
    int			sell_vol3;
    int			buy_price4;
    int			sell_price4;
    int			buy_vol4;
    int			sell_vol4;
    int			buy_price5;
    int			sell_price5;
    int			buy_vol5;
    int			sell_vol5;

};

struct BaseInfo
{
    string			stock_code;
    uint				update_time;
    double			ttl_amount;			// �ܹɱ�
    double			state_own_amount;	// ���ҹ�
    double			init_amount;			// ����ɱ�
    double			corp_amount;		// ���˹ɱ�
    double			b_amount;			// B �ɱ�
    double			h_amount;			// H �ɱ�
    double			cir_amount;			// ��ͨ �ɱ�
    double			empl_amount;		// ְ�� �ɱ�
    double			unknown1;			//
    double			ttl_asset;			// ���ʲ�
    double			varible_asset;		// ���� �ʲ�
    double			firm_asset;			// �̶� �ʲ�
    double			invisible_asset;		// ���� �ʲ�
    double			long_term_invest;	// ����Ͷ��
    double			varible_debt;		// ������ծ
    double			long_term_debt;		// ���ڸ�ծ
    double			accu_fund;			// ������
    double			net_asset;			// ���ʲ�
    double			major_income;		// ��Ӫ����
    double			major_profit;		// ��Ӫ����
    double			unknown2;			//
    double			bussiness_income;	// Ӫҵ����
    double			invest_income;		// Ӫҵ����
    double			allowance;			// ��������
    double			non_bussiness_income;	// ҵ������
    double			income_adjustment;	// �������
    double			ttl_profit;			// �����ܶ�
    double			unknown3;			//
    double			net_profit;			// ˰������
    double			undist_profit;		// δ��������
    double			per_net_assert2;	// ÿ�ɾ��ʲ�2
    static const int		record_len;
};
struct GBBQ
{
    string			code;
    char			chg_type;
// �������
// 1: ����
// 2: ��1��صĳ�Ȩ��Ϣ�չɱ��仯
// 3:�ɱ����ʱ仯(����ְ��������)
// 6: ����.
// 8: ��������
    union
    {
        struct
        {
            float				cash;	 			// ÿ10 �ֺ�
            float				sell_price;			// ÿ�����ۼ۸�
            float				give_count;			// ÿ10 ���͹���
            float				sell_count;			// ÿ10 ��������
        } bonus;
        struct
        {
            float				old_cir;	 			// ����ͨ��
            float				old_ttl;				// ���ܹɱ�
            float				new_cir;			// ����ͨ��
            float				new_ttl;				// ���ܹɱ�
        } gb;
    } data;
};
}

#endif

