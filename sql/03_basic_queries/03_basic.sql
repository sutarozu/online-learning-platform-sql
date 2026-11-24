-- 1. Tampilkan daftar kursus beserta nama kategori, nama kategori induk, dan nama instruktur, diurutkan dari harga tertinggi.

select
	c.course_id,
	c.title,
	c.price,
	cat.category_name,
	cat.parent_category_id,
	ins.full_name
from courses c
LEFT JOIN categories cat ON c.category_id = cat.category_id
LEFT JOIN categories parent_cat ON cat.parent_category_id = parent_cat.category_id
LEFT JOIN instructors ins ON c.instructor_id = ins.instructor_id
ORDER BY c.price DESC;