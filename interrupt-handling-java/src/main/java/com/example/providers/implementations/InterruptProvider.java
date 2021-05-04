package com.example.providers.implementations;

import java.io.FileNotFoundException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.example.providers.IInterruptProvider;

public class InterruptProvider implements IInterruptProvider {
    private List<Exception> exceptionsList;

    public InterruptProvider(){
        exceptionsList = new ArrayList<Exception>();
        createList();
    }

    @Override
    public Exception getRandomInterrupt() {
        return exceptionsList.get(getRandomNumber(exceptionsList.size() - 1));
    }

    private void createList(){
        exceptionsList.add(new FileNotFoundException());
        exceptionsList.add(new ParseException("ParseException", 2));
        exceptionsList.add(new InterruptedException());
        exceptionsList.add(new NullPointerException());
        exceptionsList.add(new ArrayIndexOutOfBoundsException());
        exceptionsList.add(new NumberFormatException());
    }

    private int getRandomNumber(int length){
        double randomDouble = (Math.random()*((length)+1));
        return (int) Math. round(randomDouble);
    }
}
