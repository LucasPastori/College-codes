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

#ifndef H_Work_prom_behv_H
#define H_Work_prom_behv_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_prom_behv: public HSim__s6 {
public:

    HSim__s1 SE[5];

  HSimArrayType Rom_typebase;
  HSimArrayType Rom_type;
    HSim__s1 SA[1];
    Work_prom_behv(const char * name);
    ~Work_prom_behv();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_prom_behv(const char *name);

#endif
