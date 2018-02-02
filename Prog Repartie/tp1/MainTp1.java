package tp1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class MainTp1 {
	static byte v[];    // Tableau principal
	static int n;       // Nombre d'elements du tableau

	static void readFile(String name) throws FileNotFoundException {
		Scanner inFile = new Scanner(new File(name));
		n = inFile.nextInt();
		v = new byte[n+1];

		for(int i = 1; i <= n; i++) {
			v[i] = inFile.nextByte();
		}
		
		inFile.close();
	}
	
	static int schurCount() {
		int x = 0;
		
		for(int i = 1; i <= n/2; i++) {
			int tmp = v[i];    // On gagne un peu de vitesse
			for(int j = i; i+j <= n; j++) {
				if (tmp == v[j] &&	tmp == v[i+j]) {
					x++;
				}
			}
		}
		
		return x;
	}

	public static void main(String[] args) throws FileNotFoundException {
		readFile(args[0]);
		System.out.println(schurCount());
	}
}


