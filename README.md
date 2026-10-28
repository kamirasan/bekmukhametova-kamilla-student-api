# Bekmukhametova Kamilla — Student API

Spring Boot CRUD REST API for student records with PostgreSQL, Docker and Jenkins.
Author and documentation maintainer: Kamilla Bekmukhametova.

Author: **Kamilla Bekmukhametova**

## Changes by Kamilla Bekmukhametova (feature/bekmukhametova-kamilla-crud)

- Added `PUT /api/students/{id}` — update a student's information.
- Added `DELETE /api/students/{id}` — delete a student (returns 204, or 404 if not found).
- Added MockMvc tests for create / update / delete / not-found.
