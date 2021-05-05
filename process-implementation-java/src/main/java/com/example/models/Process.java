package com.example.models;

import java.util.concurrent.ThreadLocalRandom;

public class Process implements Comparable<Process>{
    static int numberOfProcess = 0;

    private int id;
    private int status;
    private int priority;
    private String interrupt;
    private int operateTime;

    public int getOperateTime() {
        return this.operateTime;
    }

    public void setOperateTime(int operateTime) {
        this.operateTime = operateTime;
    }

    public String getInterrupt() {
        return this.interrupt;
    }

    public void setInterrupt(String interrupt) {
        this.interrupt = interrupt;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStatus() {
        return this.status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void incrementPriority() {
        this.priority--;
    }

    public void decrementPriority() {
        this.priority++;
    }

    public int getPriority() {
        return this.priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    @Override
    public int compareTo(Process process) {
        if(this.priority < process.priority){
            return -1;
        } else if(this.priority > process.priority) {
            return 1;
        } else {
            return 0;
        }
    }

    public Process(int priority) {
        this.id = numberOfProcess;
        this.status = 0;
        this.priority = priority;
        numberOfProcess++;
        operateTime = ThreadLocalRandom.current().nextInt(1000, 6000 + 1);
    }
}
