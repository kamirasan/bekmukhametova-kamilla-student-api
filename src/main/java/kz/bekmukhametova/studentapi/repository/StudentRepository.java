package kz.bekmukhametova.studentapi.repository;

import kz.bekmukhametova.studentapi.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Long> {
}
