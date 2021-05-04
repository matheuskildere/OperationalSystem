package com.example.models;

public class Process implements Comparable<Process>{
    static int numberOfProcess = 0;

    private int id;
    private int status;
    private int priority;
    private Exception exception;

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Exception getException() {
        return this.exception;
    }

    public void setExceeption(Exception exception) {
        this.exception = exception;
    }

    public boolean hasExceeption() {
        return this.exception != null;
    }

    public int getStatus() {
        return this.status;
    }

    public void setStatus(int status) {
        this.status = status;
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
    }
}
