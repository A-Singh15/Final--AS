// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1374, EBLK  * I1369, U  I719);
void  hsG_0__0 (struct dummyq_struct * I1374, EBLK  * I1369, U  I719)
{
    U  I1635;
    U  I1636;
    U  I1637;
    struct futq * I1638;
    struct dummyq_struct * pQ = I1374;
    I1635 = ((U )vcs_clocks) + I719;
    I1637 = I1635 & ((1 << fHashTableSize) - 1);
    I1369->I764 = (EBLK  *)(-1);
    I1369->I765 = I1635;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1369);
    }
    if (I1635 < (U )vcs_clocks) {
        I1636 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1369, I1636 + 1, I1635);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I719 == 1)) {
        I1369->I767 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I764 = I1369;
        peblkFutQ1Tail = I1369;
    }
    else if ((I1638 = pQ->I1277[I1637].I787)) {
        I1369->I767 = (struct eblk *)I1638->I785;
        I1638->I785->I764 = (RP )I1369;
        I1638->I785 = (RmaEblk  *)I1369;
    }
    else {
        sched_hsopt(pQ, I1369, I1635);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
