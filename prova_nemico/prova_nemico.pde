final int N = 100;

int nNemici = 100;
Nemico nemici[] = new Nemico[N];

void setup() {
  size(1200, 800);
  for(int i=0; i<nNemici; i++)
   {
     nemici[i] = new Nemico(random(width), random(height));
   }
}

void draw() {
    background(150);
    
    for(int i=0; i<nNemici; i++)
    {
      nemici[i].calcolaTarget();
      nemici[i].punta();
      nemici[i].seguiB();
      nemici[i].disegna();
    }//for
    
    
    
  }