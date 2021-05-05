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
    private List<Process> processArrayExecution = new ArrayList<>();
    private List<Process> processArrayFinished = new ArrayList<>();
    
    private Random randomNumber = new Random();

    private Scanner input = new Scanner(System.in);
    private long quantum;
    private int processNumber;
    private int maxDurationProcess;
    private int minDurationProcess;
    
    public ProcessController(){}
    
    @Override
    public void run() {
        System.out.print("Quantum lenght:(1000ms) ");
        quantum = input.nextLong();
        System.out.print("Number of processes:(10) ");
        processNumber = input.nextInt();
        System.out.print("Min duration of process:(1000ms) ");
        minDurationProcess = input.nextInt();
        System.out.print("Max duration of process:(9000ms) ");
        maxDurationProcess = input.nextInt();
        createProcess();

        for (int i = 0; i < processNumber; i++) {
            if (!processArrayReady.isEmpty()) {
                Process processIndex0 = processArrayReady();
                runProcess(processIndex0, quantum);
            }
        }
    }

    private void createProcess() {
        for(int k=0; k<processNumber; k++){
            Process process = new Process(randomNumber.nextInt(20), minDurationProcess, maxDurationProcess);
            processArray.add(process);
            processArrayReady.add(process);
        }
    }

    private Process processArrayReady() {
        Collections.sort(processArrayReady);
        return processArrayReady.get(0);
    }

    private void runProcess(Process process, long quantum) {
        processArrayReady.remove(process);
        processArrayExecution.add(process);
        UnicProcessController unicProcessController = new UnicProcessController(process, quantum);
        unicProcessController.start();
        try {
            unicProcessController.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (unicProcessController.wasInterrupted()) {
            Process processInterrupted = unicProcessController.getProcess();
            processArrayExecution.remove(process);
            processArrayReady.add(processInterrupted);
        }else{
            processArrayExecution.remove(process);
            processArrayFinished.add(process);
        }
    }
}
