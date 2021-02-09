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

#ifndef H_Work_controle_fsm_H
#define H_Work_controle_fsm_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_controle_fsm: public HSim__s6 {
public:

    HSim__s1 SE[21];

  HSimEnumType State_type;
    HSim__s1 SA[1];
    Work_controle_fsm(const char * name);
    ~Work_controle_fsm();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_controle_fsm(const char *name);

#endif
