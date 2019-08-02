package com.orchowskia.memory;

import com.jerolba.jmnemohistosyne.HistogramEntry;
import com.jerolba.jmnemohistosyne.Histogramer;
import com.jerolba.jmnemohistosyne.MemoryHistogram;

public class Test2 {

    public static void main(String... args){
        String a = "asds";
        String c = "asds";
        String b = "asds";


        var x = new Test2();
        var s = new Test1();

        while(true){
            try {
                Thread.sleep(22222);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

//        for (HistogramEntry entry : histogram) {
//            System.out.println(entry);
//        }
    }
}
