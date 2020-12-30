int nCelle = 6;
int dimCelle = 40;
int distCelle = 14;
int celle[][] = new int[nCelle][nCelle];
int i,j;
int turno = 1;

void setup()
{
   size(dimCelle*nCelle+distCelle*(nCelle+1), dimCelle*nCelle+distCelle*(nCelle+1));
   for(i=0; i<nCelle; i++)
   {
      for(j=0; j<nCelle; j++)
      {
         celle[i][j] = 0;
      }//for
   }//for
}//setup

void draw()
{
  background(0,150,200);
   for(i=0; i<nCelle; i++)
   {
      for(j=0; j<nCelle; j++)
      {
         ellipseMode(CORNER);
         noStroke();
         ellipse(j*dimCelle+distCelle*(j+1), i*dimCelle+distCelle*(i+1), dimCelle, dimCelle);
      }//for
   }//for
}

void mouseClicked()
{
   for(j=0; j<nCelle; j++)
   {
     if(mouseX>=j*dimCelle+distCelle*(j+1) && mouseX<=j*dimCelle*2+distCelle*(j+1))
     {
        if (turno==1)
        {
           for(i=0; i<nCelle; i++)
           celle[i][j]=turno;
           turno=2;
        }
        else
        {
           turno=1;
        }
         println(j);
     }
   }//for
}//mouseClicked


