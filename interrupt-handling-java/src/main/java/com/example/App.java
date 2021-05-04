package com.example;

import com.example.providers.IInterruptProvider;
import com.example.providers.implementations.InterruptProvider;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws Exception
    {
        Thread tech = new Thread();
        IInterruptProvider interruptProvider = new InterruptProvider();

        interruptProvider.getRandomInterrupt();

    }
}
