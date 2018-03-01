package td3;

public class Ex5Waiter extends Thread {
	static boolean cafe = false;
	static Object obj = new Object();

	public void run(){
		while(true) {
			try {
				sleep(1500);
			} catch (InterruptedException e) {
				System.out.println("Waiter : Interrompu !");
				return;
			}
			
			synchronized(obj) {
				cafe = true;
				System.out.println("Waiter : J'ai servi le café.");
				obj.notify();
			}
		}
	}
	
	public static void main(String args[]) {
		Ex5Waiter w = new Ex5Waiter();
		w.start();
		
		for(int i = 0; i<5;) {
			synchronized (obj) {
				if(!cafe) {
					System.out.println("Main : Il n'y a pas de café !!!");
					try {
						obj.wait();
					} catch (InterruptedException e) {
						System.out.println("Main : Interrompu !");
					}
				}
				else {
					i++;
					cafe = false;
					System.out.println("Main : J'ai bu le café.");
				}
			}
		}
		
		System.out.println("Main : J'ai trop bu !");
		w.interrupt();
	}
}
