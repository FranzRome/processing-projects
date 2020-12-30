import de.timpulver.ghost.*;

int nCelle=4;  //numero di celle per ogni riga e colonna
int dimCelle;  //dimensione delle celle
int spigoloCelle=3;  //arrotondamento delle celle
int distCelle=15;  //distanza delle celle tra loro
float casuale;  //numero di celle in gioco
int flag;  //usato per determinare le celle attive all'inizio
int i,c;
boolean mossa=false;  //verifica se ogni volta che viene premuto un tasto si muove almeno una cella
int celle [][] = new int [nCelle][nCelle];  //quanto vale una singola cella
PFont testo[][] = new PFont[nCelle][nCelle];  //testo che mostra il valore di ogni casella
String direzione="";
boolean unito= false;
int posXPunti=15, posYPunti=15, dimXPunti, dimYPunti;
int punti=0;
PFont testoPunti;
//-----------------------------------------------------------------
void setup()
{
   //viene creata una finestra senza decorazioni
   new FullscreenGhost(this);
   /*size(nCelle*dimCelle+distCelle*(nCelle+1),
        nCelle*dimCelle+distCelle*(nCelle+1));*/
        dimCelle=displayHeight/nCelle-(distCelle*nCelle+1);
        dimXPunti=dimCelle;
        dimYPunti=dimCelle/2;
   frameRate(10);
   testoPunti= createFont("Arial Bold", 32, true);
   
   //porta a 0 le celle
   for(i=0; i<nCelle; i++)
   {
      for(c=0; c<nCelle; c++)
      {  
         celle[i][c]=0;
         testo[i][c] = createFont("Arial Bold", 32, true);
      }  //end for
   }  //end for
  
  
   //genera le prime celle
   flag=2;
   while(flag>0)
   {
      casuale=random(nCelle-1);
      casuale=round(casuale);
      i=int(casuale);
      casuale=random(nCelle-1);
      casuale=round(casuale);
      c=int(casuale);
      if (celle[i][c]==0)
      {
         celle[i][c]=2;
         flag--;
      }
            
   }  //while
   
}  //end setup
//--------------------------------------------------------------
void draw()
{
   background(187,173,160);  //sfondo
   
   //disegno celle vuote
   for(i=0; i<nCelle; i++)
   {
      for(c=0; c<nCelle; c++)
      {
         noStroke();
         fill(205,192,180);
         rect(dimCelle*c+distCelle*(c+1),
              dimCelle*i+distCelle*(i+1)+posYPunti+dimYPunti,
              dimCelle, dimCelle,
              spigoloCelle);
         //disegna celle piene
         if(celle[i][c]>0)
         {
            switch(celle[i][c])
            {
               case 2:
               fill(238,228,218);
               break;
               
               case 4:
               fill(237,224,200);
               break;
            
               case 8:
               fill(242,177,121);
               break;
               
               case 16:
               fill(254,149,99);
               break;
            
               case 32:
               fill(246,124,95);
               break;
               
               case 64:
               fill(246,94,59);
               break;
            }//switch
            
            if(celle[i][c]>=128)
               {
               fill(237,207,114);
               }//if
               
            rect(dimCelle*c + distCelle*(c+1),
                 dimCelle*i + distCelle*(i+1)+posYPunti+dimYPunti,
                 dimCelle, dimCelle, spigoloCelle);
                 
                 textFont(testo[i][c],dimCelle/2);
                 textAlign(CENTER,CENTER);
                 if(celle[i][c]<=4)
                 {
                    fill(119, 110, 101);
                 }  //if
                 else
                 {
                    fill(249, 246, 242);
                 }  //else
                 if(celle[i][c]>0)
                 {
                    text(celle[i][c],
                    dimCelle*c + distCelle*(c+1)+(dimCelle/2),
                    dimCelle*i + distCelle*(i+1)+(dimCelle/2)+posYPunti+dimYPunti);    
                 }//if
         }//if
      }//for
   }//for
   fill(205,192,180);
   rect(posXPunti,posYPunti, dimXPunti, dimYPunti);
   textFont(testoPunti,dimYPunti/2);
   textAlign(CENTER,CENTER);
   fill(249, 246, 242);
   text(punti, posXPunti+(dimXPunti/2), posYPunti+(dimYPunti/2));
}//draw
//--------------------------------------------------------------
//mappatura tasti
void keyPressed()
{
   if(keyCode== UP)
   {
      direzione="su";
      println("su");
      mossa=false;
      for(c=0; c<nCelle; c++)
      {
         unito=false;
         for(i=1; i<nCelle; i++)
         {
            //individua una cella con del contenuto
            if(celle[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(celle[i-1][c]==0 )
               {
                  celle[i-1][c]+=celle[i][c];
                  celle[i][c]=0;
                  i=0;
                  mossa=true;
               }  //if
               else
               {
                  if(celle[i-1][c] == celle[i][c] && unito==false)
                  {
                     celle[i-1][c]+=celle[i][c];
                     celle[i][c]=0;
                     punti+=celle[i-1][c];
                     i=0;
                     unito=true;
                     mossa=true;
                  }  //if
               }  //else
            }  //if
         }  //for
      }  //for
      //genera una nuova cella
      if(mossa==true)
      {
         flag=1;
         while(flag>0)
         {
            casuale=random(nCelle-1);
            casuale=round(casuale);
            i=int(casuale);
            casuale=random(nCelle-1);
            casuale=round(casuale);
            c=int(casuale);
            if (celle[i][c]==0)
            {
               celle[i][c]=2;
               flag--;
            }    
         }  //while
      }  //if
   }  //if
   
//.......................................................................................................
  
   if(keyCode== DOWN)
   {
      direzione="giu";
      println("giu");
      mossa=false;
      for(c=0; c<nCelle; c++)
      {
         unito=false;
         for(i=nCelle-2; i>=0; i--)
         {
            //individua una cella con del contenuto
            if(celle[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(celle[i+1][c]==0 )
               {
                  celle[i+1][c]+=celle[i][c];
                  celle[i][c]=0;
                  i=nCelle-1;
                  mossa=true;
               }  //if
               else
               {
                  if(celle[i+1][c]==celle[i][c] && unito==false)
                  {
                     celle[i+1][c]+=celle[i][c];
                     celle[i][c]=0;
                     punti+=celle[i+1][c];
                     i=nCelle-1;       
                     unito=true;
                     mossa=true;
                  }  //if
               }  //else
            }  //if
         }  //for
      }  //for
      
      
      //genera una nuova cella
     if(mossa==true)
      {
         flag=1;
         while(flag>0)
         {
            casuale=random(nCelle-1);
            casuale=round(casuale);
            i=int(casuale);
            casuale=random(nCelle-1);
            casuale=round(casuale);
            c=int(casuale);
            if (celle[i][c]==0)
            {
               celle[i][c]=2;
               flag--;
            }    
         }  //while
      }  //if
  }  //if
  
//.......................................................................................................

   if(keyCode== RIGHT)
   {
      direzione="dx";
      println("desra");
      mossa=false;
      for(i=0; i<nCelle; i++)
      {
         unito=false;
         for(c=nCelle-2; c>=0; c--)
         {
            //individua una cella con del contenuto
            if(celle[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(celle[i][c+1]==0)
               {
                  celle[i][c+1]+=celle[i][c];
                  celle[i][c]=0;
                  c=nCelle-1;
                  mossa=true;
               }  //if
               else
               {
                  if(celle[i][c+1]==celle[i][c] && unito==false)
                  {
                     celle[i][c+1]+=celle[i][c];
                     celle[i][c]=0;
                     punti+=celle[i][c+1];
                     c=nCelle-1;
                     unito=true;
                     mossa=true;
                  }
               }
            }  //if
         }  //for
      }  //for
      //genera una nuova cella
     if(mossa==true)
      {
         flag=1;
         while(flag>0)
         {
            casuale=random(nCelle-1);
            casuale=round(casuale);
            i=int(casuale);
            casuale=random(nCelle-1);
            casuale=round(casuale);
            c=int(casuale);
            if (celle[i][c]==0)
            {
               celle[i][c]=2;
               flag--;
            }    
         }  //while
      }  //if
      
   }  //if
   
//.......................................................................................................
  
   if(keyCode== LEFT)
   {
     direzione="sinistra";
      println("sinistra");
      mossa=false;
      for(i=0; i<nCelle; i++)
      {
         unito=false;
         for(c=1; c<nCelle; c++)
         {
            //individua una cella con del contenuto
            if(celle[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(celle[i][c-1]==0)
               {
                  celle[i][c-1]+=celle[i][c];
                  celle[i][c]=0;
                  c=0;
                  mossa=true;
               }  //if
               else
               {
                  if(celle[i][c-1] == celle[i][c]  && unito==false)
                  {
                     celle[i][c-1]+=celle[i][c];
                     celle[i][c]=0;
                     punti+=celle[i][c-1];
                     c=0;
                     unito=true;
                     mossa=true;
                  }
               }
            }  //if
         }  //for
      }  //for
      //genera una nuova cella
      if(mossa==true)
      {
         flag=1;
         while(flag>0)
         {
            casuale=random(nCelle-1);
            casuale=round(casuale);
            i=int(casuale);
            casuale=random(nCelle-1);
            casuale=round(casuale);
            c=int(casuale);
            if (celle[i][c]==0)
            {
               celle[i][c]=2;
               flag--;
            }    
         }  //while
      }  //if
     
   }  //if
}  //keyPressed
