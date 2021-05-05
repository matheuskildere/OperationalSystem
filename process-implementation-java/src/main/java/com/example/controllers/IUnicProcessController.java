package com.example.controllers;

import com.example.models.Process;

public interface IUnicProcessController{
    public Process getProcess();
    public boolean wasInterrupted();
}
