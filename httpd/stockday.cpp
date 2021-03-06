#include <iostream>
#include <fstream>
#include <string>
#include <boost/program_options.hpp>
#include "Logger.hpp"
#include "config_file.hpp"
#include "stock_inter.hpp"
#include "list_inter.hpp"
#include <boost/assign/list_of.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/date_time/gregorian/gregorian.hpp>
#include <boost/accumulators/accumulators.hpp>
#include <boost/accumulators/statistics/stats.hpp>
#include <boost/accumulators/statistics/mean.hpp>
#include <boost/accumulators/statistics/variance.hpp>
#include <boost/accumulators/statistics/rolling_mean.hpp>

#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/vector_proxy.hpp>

#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>

#include <boost/numeric/ublas/vector_expression.hpp>
#include <boost/numeric/ublas/matrix_expression.hpp>
#include <boost/numeric/ublas/io.hpp>
#include <list>
#include <algorithm>
#include "da.h"
#include "GLSFitting.h"

namespace po = boost::program_options;
using namespace boost::assign;
using namespace boost::accumulators;
using namespace boost::numeric::ublas;
using namespace Base;
static double lastval=0;
void OutStock(std::ostream &ost,StockPrice sp)
{
  double curval=log(sp.PriceValues["money"]/sp.PriceValues["volum"]);
  double deltaval=100*(curval-lastval);
		
  if(lastval!=0)
    {
      ost << sp.time<<","<<sp.PriceValues["open"]<<","<<sp.PriceValues["close"]<<","<<sp.PriceValues["high"]<<","<<sp.PriceValues["low"]<<","<<deltaval<<","<<sp.PriceValues["volum"]<<","<<sp.PriceValues["money"]<<std::endl;
    }
  lastval=curval;
}
class GetMatrix
{

private:
  int m_order;
  int m_curRow;
  std::list<double> curList;
  double m_last;
public:
  typedef void result_type;
  GetMatrix(int order)
    :m_curRow(0),
     m_last(0),
     m_order(order)
  {
	       
  }
  result_type operator ()(StockPrice sp,matrix<double> &x,vector<double> &y)
  {
    //double curval=log(sp.PriceValues["money"]/sp.PriceValues["volum"]);
    //double deltaval=100*(curval-m_last);
    double curval=sp.PriceValues["close"];
    double deltaval=100*(curval-m_last)/m_last;
    if(m_last==0)
      {
	m_last=curval;
	return;
      }else
      {
	m_last=curval;
      }
    if(fabs(deltaval)<10.1)
      {

	if(curList.size()<m_order)
	  {
	    curList.push_back(deltaval);
	  }else
	  {
	    x.resize(m_curRow+1,m_order+1);
	    y.resize(m_curRow+1);
			 
	    y(m_curRow)=deltaval;
	    x(m_curRow,0)=1;
	    int col=1;
	    for(std::list<double>::iterator it=curList.begin();it!=curList.end();++it)
	      {
		x(m_curRow,col)=*it;
		col++;
	      }	
			 
	    curList.push_back(deltaval);
	    curList.pop_front();
	    m_curRow++;
			 
	  }
      }
  }
};
template<typename ACC>
void AddtoAcc(ACC &acc,StockPrice sp )
{
  acc(sp.PriceValues["money"]/sp.PriceValues["volum"]);
}

void AddtoCont(std::list<double> &target,StockPrice sp)
{
  target.push_back(sp.PriceValues["money"]/sp.PriceValues["volum"]);
}
int main(int argc, char* argv[])
{
  using namespace boost::posix_time;
  using namespace boost::gregorian;
  try
    {
      std::string configFile("stock.conf");
      std::string cmd("yahoo");
      std::string slist("file");
      po::options_description desc("Allowed options");
      desc.add_options()
	("help,h", "usage message")
	("config,f", po::value(&configFile), "config file")
	("cmd,c", po::value(&cmd), "command")
	("list,l", po::value(&slist), "list")
	;
      po::variables_map vm;
      po::store(po::parse_command_line(argc, argv, desc), vm);
      po::notify(vm);
      if (vm.count("help")) {
	std::cout << desc << "\n";
	std::cout << "usage:httpd -f [config file] [-l list] [-c command]" << "\n";
	return 0;
      }
      std::cout<<"config file:"<<configFile<<std::endl;
      Configer* conf=Configer::Instance();
      conf->LoadIni(configFile);
      init_logs();
      std::map<std::string,std::string> stockList;
      list_inter *lp=conf->CreateObject<list_inter>(slist);
      lp->open("ss.csv","ss");
      std::map<std::string,std::string> &sslist=lp->GetList();
      stockList.insert(sslist.begin(),sslist.end());
      lp->open("sz.csv","sz");
	      
      std::map<std::string,std::string> &szlist=lp->GetList();
      stockList.insert(szlist.begin(),szlist.end());


      stock_inter *tp=conf->CreateObject<stock_inter>(cmd);
      if(tp!=NULL)
	{
	  //ptime from(date(2010,1,1),hours(0));
	  ptime now = second_clock::local_time();
	  greg_weekday wd = now.date().day_of_week();
	  now=now;
	  if(wd.as_number()<6)
	    {	
	      ptime from=now-days(100);
	      for(std::map<std::string,std::string>::iterator it=stockList.begin();it!=stockList.end();++it)
		{
		  std::cout<<"-------------1--"<<now<<std::endl;
		  std::list<StockPrice> &spList=tp->GetHisPrice(it->first,from, now,stock_inter::DAY);
		  std::cout<<"-------------2--"<<now<<std::endl;
		  //if(spList.size()>3*4&&spList.back().time.date()==now.date())
		    if(spList.size()>20)
		    {
		      GetMatrix getMatrix(10);
		      matrix<double> xs;
		      vector<double> ys;
		    

		      std::for_each(spList.begin(),spList.end(),boost::bind(getMatrix,_1,boost::ref(xs),boost::ref(ys)));
		    
		      		    
		      matrix_range<matrix<double> > x (xs, range (0, xs.size1()-1), range (0,  xs.size2()));
		      
		    
		      vector_range<vector<double> > y (ys, range (0, ys.size()-1));
		      
		    
		      matrix_column<matrix<double> > x1(xs, 1);
		      identity_matrix<double> l(x.size1());    
		      matrix<double> ll(x.size1(),x.size1());  
		      ll.assign(l);
		      for(int i=0;i<x.size1();i++)
			{
			  matrix_row<matrix<double> > xi(xs, i);
			  double quan=sqrt(inner_prod(xi,xi));
			  ll(i,i)=1/quan;
			}
		      lsf::GLSFitting<double> ls(x,y,ll);
		      ls.calcParams();
		      ls.calcVar();
		      
		    
		      //   lsf::LSFitting<double> ls(x,y);
		      //  ls.calcParams();
		      // ls.calcVar();
		      
		    
		      matrix_row<matrix<double> > xt (xs, xs.size1()-1);
		    

		      
		    
		      double yt=ys(ys.size()-1);
		      
		      matrix_row<matrix<double> > lxi(xs, xs.size1()-1);
		      double lquan=sqrt(inner_prod(lxi,lxi));
		      double yt_l=yt/lquan;
		      vector<double> xt_l=1/lquan*xt;
		      double ytt_l=inner_prod(ls.getParams(),xt_l);
		    

		      double delta=yt_l-ytt_l;
		      std::cout<< "delta: " << delta<<" var:"<<ls.getVar()<<std::endl;
		      
                      std::ofstream resof("result.txt",std::ios::app);
		      if(ls.getVar()<0.07)
		        resof<<it->second<<","<<spList.back().time<<","<<ls.getVar()<<","<<delta<<","<<yt<<","<<ytt_l*lquan<<std::endl;
		      resof.close();

		      // std::ofstream resof("result.txt",std::ios::app);
		      // if(fabs(delta)>3*ls.getVar()&&delta>0)
		      //   resof<<it->second<<","<<spList.back().time<<","<<ls.getParams()<<","<<ls.getVar()<<","<<delta<<","<<yt<<","<<ytt_l*lquan<<std::endl;
		      // resof.close();
		      // std::ofstream resof1("result1.txt",std::ios::app);
		      // if(ls.getVar()<0.1&&yt>3)
		      //   resof1<<it->second<<","<<spList.back().time<<","<<ls.getParams()<<","<<ls.getVar()<<","<<delta<<","<<yt<<","<<ytt_l*lquan<<std::endl;
		      // resof1.close();
		    }
		}
	    }
	}
    }
  catch (std::exception& e)
    {
      std::cout<< "exception: " << e.what()<<std::endl;
    }

  return 0;
}
