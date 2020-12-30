import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Properties;

/*-------------------------------------------------------------------------------
 * METODI PER SERIALIZZARE OGGETTI SU FILE
 * A.R. 25/05/2009 
 *-------------------------------------------------------------------------------*/

public static class UtilitySerialization {

  public static void salvaObj(Object obj, String filePath) {
    try {
      FileOutputStream fos = new FileOutputStream(filePath);
      ObjectOutputStream oos = new ObjectOutputStream(fos);
      oos.writeObject(obj);
      oos.close();
      fos.close();
    } 
    catch (Exception e) {
      println("UtilitySerialization - Errore in salvaObj():" + e);
    }
  } // salvaObj()


  public static Object caricaObj(String filePath) {
    Object result = null;
    try {
      FileInputStream fis = new FileInputStream(filePath);
      ObjectInputStream ois = new ObjectInputStream(fis);
      result = ois.readObject();
      ois.close();
      fis.close();
    } 
    catch (Exception e) {
      System.out.println("UtilitySerialization - Errore in caricaObj():" + e);
    }
    return result;
  } // caricaObj()


  public static void salvaObjXml(Object obj, String filePath) {
    try {
      FileOutputStream fos = new FileOutputStream(filePath);
      BufferedOutputStream bos = new BufferedOutputStream(fos);
      XMLEncoder e = new XMLEncoder(bos);

      e.writeObject(obj);
      e.close();
      bos.close();
      fos.close();
    } 
    catch (Exception e) {
      System.out.println("UtilitySerialization - Errore in salvaObjXml():" + e);
    }
  } // salvaObjXml()


  public static Object caricaObjXml(String filePath) {
    Object result = null;
    try {
      FileInputStream fis = new FileInputStream(filePath);
      BufferedInputStream bis = new BufferedInputStream(fis);
      XMLDecoder d = new XMLDecoder(bis);
      result = d.readObject();
      bis.close();
      fis.close();
    } 
    catch (Exception e) {
      System.out.println("UtilitySerialization - Errore in caricaObjXml():" + e);
    }
    return result;
  } // caricaObjXml()

  /* 
   * costruisce il percorso del file in/da cui vengono salvati/letti gli oggetti sequenzializzati
   */
  public static String getCacheFilePath (Properties cfgProp, String nomeFile) {

    String separator = System.getProperty("file.separator");
    String result = cfgProp.getProperty("tabelleCachePath");
    if (result != null && ! result.endsWith(separator)) {
      result += separator;
    }
    result += nomeFile;

    return result;
  } // getCacheFilePath()
}  // class