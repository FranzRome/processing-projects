//import de.timpulver.ghost.*;

int nCelle=4;  //numero di celle per ogni riga e colonna
int dimCelle = 120;  //dimensione delle celle
int spigoloCelle=3;  //arrotondamento delle celle
int distCelle=15;  //distanza delle celle tra loro
float casuale;  //numero di celle in gioco
boolean mossa=false;  //verifica se ogni volta che viene premuto un tasto si muove almeno una cella
int matrice [][] = new int [nCelle][nCelle];  //quanto vale una singola cella
Cella[][] celle = new Cella[nCelle][nCelle];
//PFont testo[][] = new PFont[nCelle][nCelle];  //testo che mostra il valore di ogni casella
boolean unito= false;
int posXPunti=15, posYPunti=15, dimXPunti, dimYPunti;
int punti=0;
//-----------------------------------------------------------------
void setup()
{
   //viene creata una finestra senza decorazioni
   //new FullscreenGhost(this);
   size(nCelle*dimCelle+distCelle*(nCelle+1),
        (nCelle+1)*dimCelle+distCelle*(nCelle+1) + posYPunti+ dimYPunti);
        //dimCelle=displayHeight/nCelle-(distCelle*nCelle+1);
        dimXPunti=dimCelle;
        dimYPunti=dimCelle/2;
   frameRate(40);
   
   //porta a 0 le celle
   for(int i=0; i<nCelle; i++)
   {
      for(int c=0; c<nCelle; c++)
      {  
         matrice[i][c]=0;
      }  //end for
   }  //end for 
   
   for(int i=0; i<2; i++)
   {
     genera();  //genera le prime celle
   }

   for(int i=0; i<nCelle; i++)
   {
     for(int c=0; c<nCelle; c++)
     {
       celle[i][c] = new Cella(0,0,dimCelle,dimCelle,0,2);
     }
   }
   disegnaMatrice();
}  //setup
//--------------------------------------------------------------
void draw()
{
   background(187,173,160);  //sfondo
   
   //disegna griglia vuota
   noStroke();
   fill(205, 193, 180);
   for(int i=0; i<nCelle; i++)
   {
     for(int c=0; c<nCelle; c++)
     {
       rect(c*(dimCelle+distCelle)+distCelle,
       i*(dimCelle+distCelle)+posYPunti+dimYPunti+distCelle,
       dimCelle, dimCelle, spigoloCelle);
     }
   }
   
   for(int i=0; i<nCelle; i++)
   {
      for(int c=0; c<nCelle; c++)
      {
        celle[i][c].animazioni[0].anima();
        celle[i][c].animazioni[1].anima();
        celle[i][c].disegna();
      }
   }//for
   fill(205,192,180);
   rect(posXPunti,posYPunti, dimXPunti, dimYPunti);
   textSize(dimYPunti/2);
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
      mossa=false;
      for(int c=0; c<nCelle; c++)
      {
         unito=false;
         for(int i=1; i<nCelle; i++)
         {
            //individua una cella con del contenuto
            if(matrice[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(matrice[i-1][c]==0 )
               {
                  celle[i][c].animazioni[0].setta(1, celle[i][c].pX, celle[i][c].pY-dimCelle-distCelle );
                  matrice[i-1][c]+=matrice[i][c];
                  matrice[i][c]=0;
                  i=0;
                  mossa=true;
               }  //if
               else if(matrice[i-1][c] == matrice[i][c] && unito==false)
                  {
                     matrice[i-1][c]+=matrice[i][c];
                     matrice[i][c]=0;
                     punti+=matrice[i-1][c];
                     i=0;
                     unito=true;
                     mossa=true;

                  }  //if
            }  //if
         }  //for
      }  //for
      //genera una nuova cella
      if(mossa==true)
      {
         genera();
      }  //if
      
   }  //if
   
//.......................................................................................................
  
   if(keyCode== DOWN)
   {
      mossa=false;
      for(int c=0; c<nCelle; c++)
      {
         unito=false;
         for(int i=nCelle-2; i>=0; i--)
         {
            //individua una cella con del contenuto
            if(matrice[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(matrice[i+1][c]==0 )
               {
                  matrice[i+1][c]+=matrice[i][c];
                  matrice[i][c]=0;
                  i=nCelle-1;
                  mossa=true;
               }  //if
               else
               {
                  if(matrice[i+1][c]==matrice[i][c] && unito==false)
                  {
                     matrice[i+1][c]+=matrice[i][c];
                     matrice[i][c]=0;
                     punti+=matrice[i+1][c];
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
         genera();
      }  //if
  }  //if
  
//.......................................................................................................

   if(keyCode== RIGHT)
   {
      mossa=false;
      for(int i=0; i<nCelle; i++)
      {
         unito=false;
         for(int c=nCelle-2; c>=0; c--)
         {
            //individua una cella con del contenuto
            if(matrice[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(matrice[i][c+1]==0)
               {
                  matrice[i][c+1]+=matrice[i][c];
                  matrice[i][c]=0;
                  c=nCelle-1;
                  mossa=true;
               }  //if
               else
               {
                  if(matrice[i][c+1]==matrice[i][c] && unito==false)
                  {
                     matrice[i][c+1]+=matrice[i][c];
                     matrice[i][c]=0;
                     punti+=matrice[i][c+1];
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
        genera();
      }  //if
      
   }  //if
   
//.......................................................................................................
  
   if(keyCode== LEFT)
   {
      mossa=false;
      for(int i=0; i<nCelle; i++)
      {
         unito=false;
         for(int c=1; c<nCelle; c++)
         {
            //individua una cella con del contenuto
            if(matrice[i][c]>0)
            {
               //sposta il contenuto della cella in quella davanti se è 0
               if(matrice[i][c-1]==0)
               {
                 matrice[i][c-1]+=matrice[i][c];
                 matrice[i][c]=0;
                  c=0;
                  mossa=true;
               }  //if
               else if(matrice[i][c-1] == matrice[i][c]  && unito==false)
               {
                 matrice[i][c-1]+=matrice[i][c];
                 matrice[i][c]=0;
                 punti+=matrice[i][c-1];
                 c=0;
                 unito=true;
                 mossa=true;
               }
            }  //if
         }  //for
      }  //for
      //genera una nuova cella
      if(mossa==true)
      {
         genera();
      }  //if
     
   }  //if
   disegnaMatrice();
}  //keyPressed

void genera()
{
  int x,y;
  boolean generato = false;
 
  while(!generato)
  {  
    x=round(random(nCelle-2));
    y=round(random(nCelle-2));
    if (matrice[y][x]==0)
    {
       matrice[x][y]=2;
       
       /** modifiche **/
       Cella c=null;
       if(celle[x][y]!=null){
         c=(Cella)celle[x][y];
         c.setValore(2);
        c.pX = x*dimCelle+x*(distCelle+1);
        celle[x][y]=c;
     } // end modifiche
     
       //celle[x][y].setValore(2);
       //celle[x][y].pX = x*dimCelle+x*(distCelle+1);
       generato = true;
    }  //if
  }  //while

}

void disegnaMatrice()
{
  for(int i=0; i<nCelle; i++)
  {
    for(int c=0; c<nCelle; c++)
    {
      print(matrice[i][c] + "\t");
    }
    print("\n\n");
  }
  print("\n");
}
