#ifndef __LOG_H_header
#define __LOG_H_header
#include <boost/logging/format_fwd.hpp>

// Step 1: Optimize : use a cache string, to make formatting the message faster
BOOST_LOG_FORMAT_MSG( optimize::cache_string_one_str<> ) 

#ifndef BOOST_LOG_COMPILE_FAST
#include <boost/logging/format.hpp>
#include <boost/logging/writer/ts_write.hpp>
#endif

// Step 3 : Specify your logging class(es)
typedef boost::logging::logger_format_write< > log_type;

// Step 4: declare which filters and loggers you'll use
BOOST_DECLARE_LOG_FILTER(g_l_filter, boost::logging::level::holder)
BOOST_DECLARE_LOG(g_l, log_type)

// Step 5: define the macros through which you'll log
#define LOG_DBG BOOST_LOG_USE_LOG_IF_LEVEL(g_l(), g_l_filter(), debug ) << "[dbg] "
#define LOG_ERR BOOST_LOG_USE_LOG_IF_LEVEL(g_l(), g_l_filter(), error ) << "[ERR] "
#define LOG_APP BOOST_LOG_USE_LOG_IF_LEVEL(g_l(), g_l_filter(), info )  << "[INFO] "

// initialize thy logs..
void init_logs(std::string filename);
void init_logs();
#endif
