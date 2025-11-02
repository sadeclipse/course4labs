function plotsimplex_f(figno,simpl,c, flagtext, flagp)
  fpt = fun5_(simpl);
  figure(figno)
  plot3([simpl(:,1);simpl(1,1)],[simpl(:,2);simpl(1,2)],[fpt;fpt(1)],c)
  hold on
  plot3([simpl(:,1);simpl(1,1)],[simpl(:,2);simpl(1,2)],0*[fpt;fpt(1)],c)
  hold on
  if flagp==1,
  pause(1)
  end
end


