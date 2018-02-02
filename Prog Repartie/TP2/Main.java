
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Main implements Runnable {

    private int debut, fin;
    private long l;
    private static byte V[] = null;
    public long cpt;

    public Main(int debut, int fin) {
        this.debut = debut;
        this.fin = fin;
    }

    public void run() {
        int x;
        cpt = 0;
        for (int i = debut; i < fin; i++) {
            x = V[i];
            for (int j = i; j <= V.length - i; j++) {
                if (V[j] == x) {
                    if (V[i + j] == x) {
                        cpt++;
                    }
                }
            }
        }
    }

    public static void main(String[] args) {
        int nbThreads, pas, w, size = 0;
        int x = 0;

        Thread[] allThreads;
        Main[] allM;

        if (args.length != 2) {
            System.err.println("Arguments invalides");
            return;
        }

        //lecture du fichier
        try {
            InputStream flux = new FileInputStream(args[0]);
            InputStreamReader reader = new InputStreamReader(flux);
            BufferedReader buff = new BufferedReader(reader);

            size = Integer.parseInt(buff.readLine());
            V = new byte[size + 1];

            for (int i = 1; i <= size; i++) {
                V[i] = Byte.parseByte(buff.readLine());
            }

            flux.close();
            reader.close();
            buff.close();
        } catch (Exception e) {
            System.err.println(e);
            System.exit(1);
        }

        //creation des threads
        nbThreads = Integer.parseInt(args[2]);
        pas = size / 2 / nbThreads;
        allThreads = new Thread[nbThreads];
        allM = new Main[nbThreads];
        for (int i = 0; i < nbThreads; i++) {
            allM[i] = new Main(pas * i + 1, pas * i + pas);
            allThreads[i] = new Thread(allM[i]);
        }

        //run des threads
        for (int i = 0; i < nbThreads; i++) {
            allThreads[i].run();
        }

        //resultats des threads
        for (int i = 0; i < nbThreads; i++) {
            System.out.println(allM[i].cpt);
        }

        System.out.println(x);
    }
}
