package com.example;

import com.example.controllers.IProcessController;
import com.example.controllers.implementations.ProcessController;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws Exception
    {
        IProcessController processController = new ProcessController();
        processController.run();
    }
}
