public class Animazione{
 private float durata, tempo, valoreIniz, valoreFin, valore, variazione;
 private boolean esecuzione;
  
  public Animazione()
  {
    tempo = 0;
    esecuzione = false;
  }
  
  void setta(float t, float vIn, float vFin)
  {
    tempo = 0;
    durata = t;
    valoreIniz = vIn;
    valoreFin = vFin;
    variazione = (valoreFin - valoreIniz)/durata;
    esecuzione = true;
  }
  
  float anima()
  {
    if(tempo<durata)
    {
      tempo += 1/frameRate;
      valore = tempo*variazione+valoreIniz;
    }
    else
    {
      esecuzione = false;
    }
    return valore;
  }
}
