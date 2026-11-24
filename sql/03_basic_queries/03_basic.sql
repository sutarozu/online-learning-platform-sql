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

-- 3. Hitung total pendapatan per bulan, tanpa enrollment berstatus refunded.

select 
    to_char(e.enroll_date, 'yyyy-mm') AS bulan,
    sum(c.price) as total_pendapatan
from enrollments e
join courses c on e.course_id = c.course_id
where e.status <> 'refunded'
group by to_char(e.enroll_date, 'yyyy-mm')
order by bulan asc;