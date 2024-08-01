function [ Gdist1, Gcorr1, Gk1, Gdist2, Gcorr2, Gk2, Gdist3, Gcorr3, Gk3 ] = getGraphs( G9 )
    %%
    Gdist1 = G9(:,:,1); 
    Gcorr1 = G9(:,:,2); 
    Gk1    = G9(:,:,3); 
    
    %%
    Gdist2 = G9(:,:,4); 
    Gcorr2 = G9(:,:,5); 
    Gk2    = G9(:,:,6); 
 
    %%
    Gdist3 = G9(:,:,7); 
    Gcorr3 = G9(:,:,8); 
    Gk3    = G9(:,:,9); 
end

