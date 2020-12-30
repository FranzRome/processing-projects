int dimfx=600, dimfy=600;
int x=0, y=0;
int n=30;
int c=0;


void setup()
{
   size(dimfx,dimfy);
}

void draw()
{
   while(c<n)
   {
      line(0,y*dimfx/n,x*dimfx/n,dimfy);
      x++;
      y++;
      c++;
   }
}
