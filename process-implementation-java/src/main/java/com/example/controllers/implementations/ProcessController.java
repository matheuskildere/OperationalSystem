package com.example.controllers.implementations;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import com.example.controllers.IProcessController;
import com.example.models.Process;

public class ProcessController implements IProcessController{
    private List<Process> processArray = new ArrayList<>();
    private List<Process> processArrayReady = new ArrayList<>();
    private List<Process> processArrayFinished = new ArrayList<>();
    
    private Random randomNumber = new Random();

    private Scanner input = new Scanner(System.in);
    private int processNumber;
    
    public ProcessController(){}
    
    @Override
    public void run() {
        System.out.print("Number of processes:(10) ");
        processNumber = input.nextInt();
        createProcess();

        for (int i = 0 ; i < processNumber; i++) {
            Process processIndex0 = processArrayReady();
            runProcess(processIndex0);
        }
        
    }

    private void createProcess() {
        for(int k=0; k< processNumber; k++){
            Process process = new Process(randomNumber.nextInt(20));
            processArray.add(process);
            processArrayReady.add(process);
        }
    }

    private Process processArrayReady() {
        Collections.sort(processArrayReady);
        // for (Process process : processArrayReady) {
        //     System.out.println(process.getId()+"--"+process.getPriority());
        // }
        return processArrayReady.get(0);
    }

    private void runProcess(Process process) {
        System.out.println("\n=====================================");
        System.out.println("CURRENT PROCESS: " + process.getId());
        processArrayReady.remove(process);
        UnicProcessController unicProcessController = new UnicProcessController(process);
        unicProcessController.start();
        try {
            unicProcessController.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (unicProcessController.wasInterrupted()) {
            Process processInterrupted = unicProcessController.getProcess();
            processArrayReady.add(processInterrupted);
            processNumber++;
        }else{
            processArrayFinished.add(process);
            System.out.println("FINISHED");
        }
    }
}
