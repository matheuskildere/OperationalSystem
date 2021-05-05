package com.example.controllers.implementations;

import com.example.models.Process;
import com.example.providers.IInterruptProvider;
import com.example.providers.implementations.InterruptProvider;

import java.util.Random;

import com.example.controllers.IUnicProcessController;

public class UnicProcessController extends Thread implements IUnicProcessController{
    private IInterruptProvider interruptProvider;
    
    private Random randomNumber = new Random();
    private Process process;
    private long quantum;
    private boolean wasInterrupted = false;

    public UnicProcessController(Process process, long quantum){
        interruptProvider = new InterruptProvider();
        this.process = process;
        this.quantum = quantum;
        process.setStatus(1);
    }

    @Override
    public void run() {
        try {
            Thread.sleep(quantum / 2);
            process.setExecutionTime(process.getExecutionTime() - quantum / 2);
            int randomNumberInt = randomNumber.nextInt(2);
            if (randomNumberInt == 1) {
                String interrupt = interruptProvider.getRandomInterrupt();
                process.setInterrupt(interrupt);
                throw new Exception();
            }
            Thread.sleep(quantum / 2);
            process.setExecutionTime(process.getExecutionTime() - quantum / 2);
        } catch (Exception e) {
            System.out.println("---------- INTERRUPT ---------");
            System.out.println("PROCESS ID: " +process.getId());
            System.out.println(process.getInterrupt());
            System.out.println("PRIOTITY BEFORE: " +process.getPriority());
            if (process.getInterrupt().equals("SYSTEM CALL")) {
                process.incrementPriority();
            }else if (process.getInterrupt().equals("PRE-EMPTION")){
                process.decrementPriority();
            }
            System.out.println("PRIOTITY NOW: " +process.getPriority());
            System.out.println("------------------------------");
            wasInterrupted = true;
        }
    }

    @Override
    public Process getProcess() {
        return process;
    }

    @Override
    public boolean wasInterrupted() {
        return wasInterrupted;
    }
}
