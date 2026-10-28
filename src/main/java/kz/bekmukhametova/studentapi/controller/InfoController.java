package kz.bekmukhametova.studentapi.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class InfoController {

    @Value("${student.name}")
    private String studentName;

    @Value("${app.version}")
    private String version;

    @GetMapping("/")
    public Map<String, String> info() {
        return Map.of(
                "application", "Student API",
                "author", studentName,
                "version", version);
    }
}
