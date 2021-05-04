package com.example.providers.implementations;

import java.io.FileNotFoundException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.example.providers.IInterruptProvider;

public class InterruptProvider implements IInterruptProvider {
    private List<String> interruptList;

    public InterruptProvider(){
        interruptList = new ArrayList<String>();
        createList();
    }

    @Override
    public String getRandomInterrupt() {
        return interruptList.get(getRandomNumber(interruptList.size() - 1));
    }
    
    private void createList(){
        interruptList.add("Retorno do disco rigido");
        interruptList.add("Retorno do mouse");
        interruptList.add("Retorno do teclado");
    }

    private int getRandomNumber(int length){
        double randomDouble = (Math.random()*((length)+1));
        return (int) Math. round(randomDouble);
    }
}
