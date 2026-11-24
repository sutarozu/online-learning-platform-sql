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