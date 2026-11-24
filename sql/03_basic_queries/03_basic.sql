-- Level 1: Fondasi

-- 1. Tampilkan daftar kursus beserta nama kategori, dan nama instruktur lalu diurutkan dari harga tertinggi.

select
	c.course_id,
	c.title,
	c.price,
	cat.category_id,
	cat.category_name,
	ins.instructor_id,
	ins.full_name
from courses c
LEFT JOIN categories cat ON c.category_id = cat.category_id
LEFT JOIN instructors ins ON c.instructor_id = ins.instructor_id
ORDER BY c.price DESC;

-- 2. Cari kursus yang belum punya satu pun peserta, lengkap dengan nama instrukturnya.

select
	c.course_id,
    c.title,
    ins.full_name as instructor_name
from courses c
left join instructors ins on c.instructor_id = ins.instructor_id
left join enrollments e on c.course_id = e.course_id
where e.enrollment_id is null;