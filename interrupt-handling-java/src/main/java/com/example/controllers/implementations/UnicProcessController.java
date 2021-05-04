package com.example.controllers.implementations;

import com.example.models.Process;
import com.example.providers.IInterruptProvider;
import com.example.providers.implementations.InterruptProvider;

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import com.example.controllers.IUnicProcessController;

public class UnicProcessController extends Thread implements IUnicProcessController{
    private IInterruptProvider interruptProvider;
    
    private Random randomNumber = new Random();
    private Process process;
    private boolean hasException = false;

    public UnicProcessController(Process process){
        interruptProvider = new InterruptProvider();
        this.process = process;
        process.setStatus(1);
    }

    @Override
    public void run() {
        try {
            Thread.sleep(ThreadLocalRandom.current().nextInt(1000, 2000 + 1));
            int randomNumberInt = randomNumber.nextInt(2);
            if (randomNumberInt == 1) {
                String error = interruptProvider.getRandomInterrupt();
                process.setExceeption(error);
                throw new Exception();
            }
        } catch (Exception e) {
            System.out.println("---------- INTERRUPT ---------");
            System.out.println("ID DO PROCESSO: " +process.getId());
            System.out.println(process.getException());
            System.out.println("------------------------------");
            hasException = true;
        }
    }

    @Override
    public Process getProcess() {
        return process;
    }

    @Override
    public boolean hasException() {
        return hasException;
    }
}
