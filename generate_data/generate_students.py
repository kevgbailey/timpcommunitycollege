import random
from dataclasses import dataclass

@dataclass
class Student:
	first_name: str
	last_name: str
	year: int
	major: str

	def as_sql(self) -> str:
		# Escape apostophes in names
		escaped_first_name = self.first_name.replace('\'', '\'\'')
		escaped_last_name = self.last_name.replace('\'', '\'\'')

		return f"(\'{escaped_first_name}\', \'{escaped_last_name}\', {self.year}, \'{self.major}\')"

def generate_student(first_names, last_names, majors):
	fn_idx = random.randint(0, len(first_names) - 1)
	first_name = first_names[fn_idx]

	ln_idx = random.randint(0, len(last_names) - 1)
	last_name = last_names[ln_idx]

	year = random.randint(1, 4)

	mj_idx = random.randint(0, len(majors) - 1)
	major = majors[mj_idx]

	return Student(first_name, last_name, year, major)

def main():
	fn = open("data/first-names.txt")
	ln = open("data/last-names.txt")
	mj = open("data/majors.txt")

	first_names = [name.strip() for name in fn.readlines()]
	last_names = [name.strip() for name in ln.readlines()]
	majors = [major.strip() for major in mj.readlines()]

	mj.close()
	ln.close()
	fn.close()


	query = "INSERT INTO students (FirstName, LastName, Year, Major) VALUES\n\t"
	for i in range(10000):
		if i != 0:
			query += ",\n\t"
		stu = generate_student(first_names, last_names, majors)
		query += stu.as_sql() 

	query += ';'
	
	out_file = open("output/students.sql", "w")
	out_file.write(query)
	out_file.close()

if __name__ == "__main__":
	main()