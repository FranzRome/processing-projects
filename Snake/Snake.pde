int dimfx=800, dimfy=800;  //dimensioni finestra
int nr=10, nc=10;  //numero righe e colonne
int n=500;  //lunghezza massima vettori
int pgx[]= new int[n]; 
int pgy[]= new int[n];
int i;  //indice vettori
String direz="destra";  //direzione serpente
int lg=3;  //lunghezza serpente
int punti=0;  //punti accumulati
int c=0;  //conta prima che cambi il livello
float pox, poy;  //posizioni oggetto da raccogliere
PFont testo;
int livello=4;  //livello di difficoltà
PImage img;



void setup()
{
   size(1000,1000);
   img = loadImage("mela.jpg");
   
   //viene inizializzata la posizione della testa del serpente
   pgx[0]=lg-1;
   pgy[0]=0;
   
   //viene inizializzata la posizione delle parti del serpente
   for(i=1; i<lg; i++)
   {
      pgx[i]=pgx[i-1]-1;
      pgy[i]=0;
   }
   
   //viene inizializzata la posizione dell'oggetto
   pox=random(0,nc-1);
   pox=round(pox);
   poy=random(0,nr-1);
   poy=round(poy);
   frameRate(2*livello);
   
   //viene inizializzato il testo
   testo=createFont("Arial",16,true);
   textFont(testo,30);
}

void draw()
{
   background(100);
   
   //viene disegnata la griglia
   stroke(0);
   for(i=1; i<nr; i++)
   {
      line(0,i*dimfy/nr,dimfx,i*dimfy/nr); 
   }
   for(i=1; i<nc; i++)
   {
      line(i*dimfx/nc,0,i*dimfx/nc,dimfy);    
   }
   
   //shift dei vettori delle posizioni per far seguire la testa del serpente dalle varie parti
   for(i=lg; i>0; i--)
      {
         pgx[i]=pgx[i-1];
         pgy[i]=pgy[i-1];
      }
      
      //muove la testa del serpente in base alla direzione
      if(direz=="destra")
      {
         pgx[0]+=1;
      }
      if(direz=="sinistra")
      {
         pgx[0]-=1;
      }
      if(direz=="su")
      {
         pgy[0]-=1;
      }
      if(direz=="giu")
      {
         pgy[0]+=1;
      }

   //se il serpente supera il bordo appare dalla parte opposta   
   if(pgx[0]>=nc)
   {
      pgx[0]=0;
   }
   if(pgx[0]<0)
   {
      pgx[0]=nc-1;
   }
   if(pgy[0]>=nr)
   {
      pgy[0]=0;
   }
   if(pgy[0]<0)
   {
      pgy[0]=nr-1;
   }
   
   //controllo della collisione della testa con le altre parti
   for(i=1; i<lg; i++)
   {
      if(pgx[i]==pgx[0] && pgy[i]==pgy[0])
      {
         lg=0;
         println("hai perso!!");
      }
   }
   
   //controllo della collisione della testa con l'oggetto da raccogliere
   if(pgx[0]==pox  &&  pgy[0]==poy)
   {
      punti++;
      lg++;
      pox=random(0,nc-1);
      pox=round(pox);
      poy=random(0,nr-1);
      poy=round(poy);
      c++;
      if(c>=5)
      {
         livello++;
         c=0;
         println("livello aumentato!!");
      }
   }
   
   //viene disegnato il serpente
   fill(255);
   for(i=0; i<lg; i++)
   { 
      rect(pgx[i]*dimfx/nc,pgy[i]*dimfx/nr,dimfx/nc,dimfy/nr);
   }
   
   //viene disegnato l'oggetto da raccogliere
   fill(255,170,0);
   image(img,pox*dimfx/nc,poy*dimfx/nr,dimfx/nc,dimfy/nr);
   //rect(pox*dimfx/nc,poy*dimfx/nr,dimfx/nc,dimfy/nr);
    
   //viene disegnato il testo che mostra il punteggio
   fill(0,255,150);
   text("Punteggio: "+punti,10,50);
}

//mappatura dei tasti
void keyPressed()
{
   if(key=='d' && direz!="sinistra")
   {
      direz="destra";
   }
   else
   {
      if(key=='a' && direz!="destra")
      {
         direz="sinistra";
      }
      else
      {
         if(key=='w' && direz!="giu")
         {
            direz="su";
         }
         else
         {
            if(key=='s' && direz!="su")
            {
               direz="giu";
            }
         }
      }
   }
}