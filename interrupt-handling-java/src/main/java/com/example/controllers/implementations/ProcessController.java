package com.example.controllers.implementations;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;

import com.example.controllers.IProcessController;
import com.example.models.Process;
import com.example.providers.IInterruptProvider;
import com.example.providers.implementations.InterruptProvider;

public class ProcessController implements IProcessController{
    private List<Process> processArray = new ArrayList<>();
    private List<Process> processInterrupt = new ArrayList<>();
    private List<Process> processArrayReady = new ArrayList<>();
    private List<Process> processArrayExecution = new ArrayList<>();
    private List<Process> processArrayFinished = new ArrayList<>();
    private List<Process> processArrayBlocked = new ArrayList<>();
    private IInterruptProvider interruptProvider;
    
    Random randomNumber = new Random();

    public ProcessController(){
        interruptProvider = new InterruptProvider();
    }


    Scanner input = new Scanner(System.in);
    
    @Override
    public void run() {
        initProcess();
        int choose;

        do {
            for (int i = 0; i < 4; i++) {
                Process processWithHighPriority = processByPriority();
                runProcess(processWithHighPriority);
                int randomNumberAux = randomNumber.nextInt(2);
                
                if(randomNumberAux ==1 ){
                    Process processBlocked = randomBlockProcess();
                    processBlocked.decrementPriority();
                } else {
                    Process processBlocked = randomBlockProcess();
                    processBlocked.incrementPriority();
                }
            }
            String leftAlignFormat = "| %-18s | %n";
            System.out.println("A serem executados:");

            for (Process process : processArray) {
                System.out.format(leftAlignFormat, Integer.toString(process.getId()));
            }
            System.out.println("_________________________");

            leftAlignFormat = "| %-11s | %n";
            System.out.format("Em execução: ");

            for (Process process : processArray) {
                System.out.format(leftAlignFormat, Integer.toString(process.getId()));
            }
            System.out.format("_________________________");

            leftAlignFormat = "| %-10s | %n";
            System.out.format("Terminados:");

            for (Process process : processArray) {
                System.out.format(leftAlignFormat, Integer.toString(process.getId()));
            }
            System.out.format("_________________________");

            leftAlignFormat = "| %-10s | %n";
            System.out.format("Bloqueados:");

            for (Process process : processArray) {
                System.out.format(leftAlignFormat, Integer.toString(process.getId()));
            }
            System.out.format("_________________________");

            System.out.println("Continuar na simulação? 0 - Encerrar, 1 - Continuar");
            choose = input.nextInt();
        } while(choose != 0);
    }

    @Override
    public void initProcess() {
        for(int k=0; k<20; k++){
            Process process = new Process(randomNumber.nextInt(20));
            processArray.add(process);
            processArrayReady.add(process);
        }
    }

    Process processByPriority() {
        Collections.sort(processArrayExecution);
        return processArrayExecution.get(0);
    }

    public void runProcess(Process process) {
        process.setStatus(1);
        try {
            Thread.sleep(ThreadLocalRandom.current().nextInt(1000, 9000 + 1));
            int randomNumberInt = randomNumber.nextInt(2);
            if (randomNumberInt == 1) {
                process.setExceeption(interruptProvider.getRandomInterrupt());
            }else{

            }
        } catch (Exception e) {
            //TODO: handle exception
        }
        processArrayExecution.add(process);
        processArrayReady.remove(process);
    }

    Process randomBlockProcess() {
        Process processBlocked = processArrayExecution.get(randomNumber.nextInt(processArrayExecution.size()));
        processArrayExecution.remove(processBlocked);
        //processArrayBlocked.add(processprocessBlocked);
        return processBlocked;
    }

}
