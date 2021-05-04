package com.example.controllers.implementations;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;

import com.example.controllers.IProcessController;
import com.example.models.Process;

public class ProcessController implements IProcessController{
    private List<Process> processArray = new ArrayList<>();
    private List<Process> processInterrupt = new ArrayList<>();
    private List<Process> processArrayReady = new ArrayList<>();
    private List<Process> processArrayExecution = new ArrayList<>();
    private List<Process> processArrayFinished = new ArrayList<>();
    
    private Random randomNumber = new Random();

    private Scanner input = new Scanner(System.in);
    
    public ProcessController(){}
    
    @Override
    public void run() {
        createProcess();
        int choose;

        do {
            for (int i = 0; i < 4; i++) {
                Process processIndex0 = processArrayReady.get(0);
                if (processInterrupt.isEmpty()) {
                    runProcess(processIndex0);
                }else{
                    Process interruptWithHighPriority = interruptByPriority();
                    if (processIndex0.compareTo(interruptWithHighPriority) == 1) {
                        runInterrupt(interruptWithHighPriority);
                    }else{
                        runProcess(processIndex0);
                    }
                }
            }
            System.out.print("Processo a serem executados: [");
            for (Process process : processArrayReady) {
                System.out.print(process.getId() + ", ");
                
            }
            System.out.println("]");
            System.out.println("TOTAL: " + processArrayReady.size());

            System.out.print("\nTerminados: [");

            for (Process process : processArrayFinished) {
                System.out.print(process.getId() + ", ");
            }
            System.out.println("]");
            System.out.println("Total: " + processArrayFinished.size());

            System.out.print("\nInterrupções: [\n");

            for (Process process : processInterrupt) {
                System.out.println(process.getException().toString()+ ",\n");
            }

            System.out.print("]");
            System.out.println("\nTotal: " + processInterrupt.size());

            System.out.println("Escolha uma opção:\n (0 - Encerrar, 1 - Continuar)");
            choose = input.nextInt();
        } while(choose != 0);
    }

    private void createProcess() {
        for(int k=0; k<20; k++){
            Process process = new Process(randomNumber.nextInt(20));
            processArray.add(process);
            processArrayReady.add(process);
        }
    }

    private Process interruptByPriority() {
        Collections.sort(processInterrupt);
        return processInterrupt.get(0);
    }

    private void runProcess(Process process) {
        processArrayExecution.add(process);
        processArrayReady.remove(process);
        UnicProcessController unicProcessController = new UnicProcessController(process);
        unicProcessController.start();
        try {
            unicProcessController.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (unicProcessController.hasException()) {
            Process processWithException = unicProcessController.getProcess();
            processArrayExecution.remove(process);
            processInterrupt.add(processWithException);
        }else{
            processArrayExecution.remove(process);
            processArrayFinished.add(process);
        }
    }

    private void runInterrupt(Process process) {
        try {
            Thread.sleep(ThreadLocalRandom.current().nextInt(1000, 9000 + 1));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        processInterrupt.remove(process);
        processArrayReady.add(process);
    }
}
