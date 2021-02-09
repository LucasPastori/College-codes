////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_cpu_bdf_type_H
#define H_Work_cpu_bdf_type_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_cpu_bdf_type: public HSim__s6 {
public:

    HSim__s1 SE[5];

    HSim__s1 SA[26];
  char *t3;
    Work_cpu_bdf_type(const char * name);
    ~Work_cpu_bdf_type();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_cpu_bdf_type(const char *name);

#endif
