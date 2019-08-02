package com.orchowskia.memory;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Test1 {
    StringBuilder a = new StringBuilder();
    public String x = "test 1 name field";

    public String x() {
        return x;
    }

    List<Object> xx = new ArrayList<>() {{
        add(new StringBuilder().append(2323));
    }};

    public static void main(String[] args) {
        ProcessHandle.allProcesses()
                .forEach(process -> System.out.println(processDetails(process)));
    }

    private static String processDetails(ProcessHandle process) {
        return String.format("%8d %8s %10s %26s %-40s",
                process.pid(),
                text(process.parent().map(ProcessHandle::pid)),
                text(process.info().user()),
                text(process.info().startInstant()),
                text(process.info().commandLine()));
    }

    private static String text(Optional<?> optional) {
        return optional.map(Object::toString).orElse("-");
    }
}
