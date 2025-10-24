function plotsimplex(figno,simpl, c,flagtext, flagp)
  fpt = fun5_(simpl);
  figure(figno)
  plot([simpl(:,1);simpl(1,1)],[simpl(:,2);simpl(1,2)],c)
  hold on
  if flagtext ==1,
  dtext=0.1;
  for i=1:length(fpt),
   text(simpl(i,1)+dtext ,simpl(i,2)+dtext,num2str(fpt(i)));
  end
  end
  if flagp==1,
  pause(3)
  end
