package com.example.models;

import java.util.concurrent.ThreadLocalRandom;

public class Process implements Comparable<Process>{
    static int numberOfProcess = 0;

    private int id;
    private int status;
    private int priority;
    private long executionTime;
    private String interrupt;

    public String getInterrupt() {
        return this.interrupt;
    }

    public void setInterrupt(String interrupt) {
        this.interrupt = interrupt;
    }

    public int getId() {
        return this.id;
    }

    public long getExecutionTime() {
        return executionTime;
    }

    public void setExecutionTime(long executionTime) {
        this.executionTime = executionTime;
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

    public Process(int priority, int minDuration, int maxDuration) {
        this.id = numberOfProcess;
        this.status = 0;
        this.priority = priority;
        this.executionTime = ThreadLocalRandom.current().nextInt(minDuration, maxDuration + 1);
        numberOfProcess++;
    }
}
