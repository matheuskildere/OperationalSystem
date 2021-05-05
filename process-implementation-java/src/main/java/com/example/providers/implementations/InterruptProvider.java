package com.example.providers.implementations;

import com.example.providers.IInterruptProvider;

public class InterruptProvider implements IInterruptProvider {

    public InterruptProvider(){}

    @Override
    public String getRandomInterrupt() {
        if (getRandomNumber(2) == 1) {
            return "PRE-EMPTION";
        }else{
            return "SYSTEM CALL";
        }
    }

    private int getRandomNumber(int length){
        double randomDouble = (Math.random()*((length)+1));
        return (int) Math. round(randomDouble);
    }
}
