public class TVector{
      public int x;
      public int y;
      
      public TVector () {
         this.x=0;
         this.y=0;
      }
      
      public TVector (int x, int y) {
         this.x= x;
         this.y= y;
      }
      
      @Override
      public String toString(){
        return  x +", " + y ;
      }
}