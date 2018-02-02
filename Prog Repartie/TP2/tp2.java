
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


/*
10000=>249 332=>0.2
100000=>6 251 210=>2.6
300000=>14 066 974=>16
1 000 000=>36 072 907=>143
 */
public class tp2 extends Thread {

    static int n;       //numero de thread
    static int nt;      //nombre de thread
    static byte v[];    // Tableau principal
    static int ntab;
    static int deb, fin;
    static long compteur;

    public tp2(int deb, int fin) {
        this.deb = deb;
        this.fin = fin;
    }

    static void readFile(String name) throws FileNotFoundException {
        Scanner inFile = new Scanner(new File(name));
        ntab = inFile.nextInt();
        v = new byte[ntab + 1];

        for (int i = 1; i <= ntab; i++) {
            v[i] = inFile.nextByte();
        }

        inFile.close();
    }

    public void run() {
        int tmp;
        compteur = 0;
        for (int i = deb; i < fin; i++) {
            tmp = v[i];
            for (int j = i; j <= v.length - i; j++) {
                if (tmp == v[j]) {
                    if (tmp == v[i + j]) {
                        compteur++;
                    }
                }
            }
        }

        System.out.println("Thread numéro" + nt + " est fini");
    }

    public static void main(String[] args) throws FileNotFoundException {
        int dist;
        tp2[] t;

        readFile(args[0]);
        nt = Integer.valueOf(args[1]);
        t = new tp2[nt];
        dist = ntab / 2 / nt;

        for (int i = 0; i < nt; i++) {
            t[i] = new tp2(dist * i + 1, dist * i + dist);
        }

        for (int i = 0; i < nt; i++) {
            t[i].start();
        }

        for (int i = 0; i < nt; i++) {
            try {
                t[i].join();
            } catch (InterruptedException e) {
                System.out.println("AIE !");
                return;
            }
        }

        System.out.println("Le thread main est fini !" + compteur);
    }
}
