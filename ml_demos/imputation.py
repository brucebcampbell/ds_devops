

#  FCMI:   Feature   Correlation   based   Missing   Data  Imputation
# @misc{mishra2021fcmi,
#       title={FCMI: Feature Correlation based Missing Data Imputation},
#       author={Prateek Mishra and Kumar Divya Mani and Prashant Johri and Dikhsa Arya},
#       year={2021},
#       eprint={2107.00100},
#       archivePrefix={arXiv},
#       primaryClass={cs.LG}
# }
#  Algorithm   1:   Feature   Correlation   based   Missing   data   Imputation  
#  Input:
#     x:   columns   with   missing   values  
#     m:   dataset   with   no   missing   values  
#     n:   dataset   containing   only   missing   values  
#
# Output:
# m:   updated   dataset   with   missing   values   imputed.  
#
# 1. for    each   missing   column   ( i )   in    x    do   :  
# 2. for    each   column   ( j )   in   the    dataset    do   :                       Calculate    correlation   coefficient    between   (    m[i]   and   m[j]    )   and   store   it   in    P                  end  
# 3. Set    ‘ K ’   =    top   3   columns   names   whose   correlation   is   maximum   w.r.t    m[i]  
# 4. Build    a   linear   regression   model     and   train   it   on   predictor   variables    k1,   k2,   k3                  and   target   as    m[i].    [The   parameters   of   the   linear   regression   model   is   optimized using   loss   function   described   in   Algorithm   2   ]  
# 5. Predict    the   values   of    n[i]    using   the   model   trained   in   4 .  
# 6. end
