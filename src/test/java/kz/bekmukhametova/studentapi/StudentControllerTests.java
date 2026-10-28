package kz.bekmukhametova.studentapi;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class StudentControllerTests {

    @Autowired
    private MockMvc mvc;

    @Test
    void infoShowsStudentName() throws Exception {
        mvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.author").value("Kamilla Bekmukhametova"));
    }

    @Test
    void createUpdateDeleteStudent() throws Exception {
        String body = """
                {"firstName":"Kamilla","lastName":"Bekmukhametova","email":"kamilla@example.com","groupName":"DevOps-1"}""";
        String location = mvc.perform(post("/api/students").contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.lastName").value("Bekmukhametova"))
                .andReturn().getResponse().getContentAsString();
        long id = Long.parseLong(location.replaceAll(".*\"id\":(\\d+).*", "$1"));

        mvc.perform(put("/api/students/" + id).contentType(MediaType.APPLICATION_JSON)
                        .content(body.replace("DevOps-1", "DevOps-2")))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.groupName").value("DevOps-2"));

        mvc.perform(delete("/api/students/" + id)).andExpect(status().isNoContent());
        mvc.perform(get("/api/students/" + id)).andExpect(status().isNotFound());
    }

    @Test
    void missingStudentReturns404() throws Exception {
        mvc.perform(get("/api/students/99999")).andExpect(status().isNotFound());
    }
}
