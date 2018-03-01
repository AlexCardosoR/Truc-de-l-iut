

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


/**
 *
 * @author ardelain
 */
public class Main {
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Traitement t = new Traitement(args[0]);
        t.traitement(t.charger(),Integer.parseInt(args[1]));//
    }
    
}

class Traitement{
    public String fileName;
    public int resultat;
    public int valeur;
    public int i;
    
    public Traitement(String s) {
        this.fileName = s;
    }

    public byte[] charger(){ //sinon untiliser un scanner 
        InputStream flux; 
        InputStreamReader lecture;
        BufferedReader buff;
        byte[] tableau =  null;
        try{
            int i = 1;
            flux=new FileInputStream(fileName); 
            lecture=new InputStreamReader(flux);
            buff=new BufferedReader(lecture);
            String ligne ;
            String taille = buff.readLine();
            tableau = new byte[Integer.parseInt(taille)+1];
            while ((ligne=buff.readLine())!=null){
                tableau[i] = (byte)Integer.parseInt(ligne);
                i++;
            }
            buff.close();
            return tableau;
        } catch(FileNotFoundException e){
                System.err.println("FileNotFoundException");
        }catch(IOException e){
            	System.out.println("IOException");
        } finally {   
             return tableau; 
        }
    }
    public  void traitement(byte[] tableau, int nb ){
        int taille = tableau.length;
        int res = 0;
        byte[] tableIndex ;
        int tabInt[];

        ExecutorService es = Executors.newSingleThreadExecutor();
        List<ProcessI> lpI = new ArrayList<>();
        ProcessI pI ;
        System.out.println("\nprocess: "+nb);

        for(int j=1; j<=nb;j++){
            pI = new ProcessI(j,tableau,nb);

            lpI.add(pI);

            pI.start();
	    }
        es.shutdown();//attente des processus

        for(ProcessI pi : lpI){
            System.out.println("Thread "+pi.num+" fini" + " valeur: "+pi.res);
            resultat += pi.res;
        }
        System.out.println("\nresultat "+fileName+": "+ resultat);
    }
}

class  ProcessI implements Runnable{
    int num;
    Thread thisThread;
    private byte[] tableau;
//    public int i;// a definir
    public int valeur=0;// a definir
    int res = 0;
    int nb;

    public ProcessI(int num,byte[] tableau, int nb) {
        this.nb = nb;
        this.num = num;
        this.tableau = tableau;
        //start();
    }

    
    public void start() {
        if (thisThread != null) {
            return;
        }
        thisThread = new Thread(this);
        thisThread.start();
    }


    public int stop() {
        thisThread = null;
        System.out.println("Thread "+num+" fini" + " valeur: "+res);
        return res;
    }

    public void run() {
        int i;
        int taille = tableau.length;
        //int tailleInt = tabInt.length ;

        for(i = 1; i < taille-i;i = i) {
                valeur = tableau[i];
                for (int j = i ; j < taille - i; j++) {
                    if (tableau[j] == valeur && i <= j && i + j < taille) {
                        if (tableau[i + j] == valeur) {
                            res++;
                            //System.out.println("Traitement Thread "+num+" fini" + " valeur: "+res);
                        }
                    }
                }
        i = i + nb;
        }
        this.stop();
    }

}

