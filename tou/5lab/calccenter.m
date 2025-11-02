function pt_0 = calccenter(simpl)
  [ms, ns] = size(simpl);

 pt_0 = 0*simpl(1,:);
 for i=1:ms,  
   pt_0 = pt_0 + simpl(i,:);
 end
 pt_0 = pt_0/ms;

end
