import random
from dataclasses import dataclass

FACULTY_COUNT = 300

@dataclass
class Faculty:
	first_name: str
	last_name: str
	department: str

	def as_sql(self) -> str:
		# Escape apostophes in names
		escaped_first_name = self.first_name.replace('\'', '\'\'')
		escaped_last_name = self.last_name.replace('\'', '\'\'')

		return f"(\'{escaped_first_name}\', \'{escaped_last_name}\', \'{self.department}\')"

def generate_faculty_member(first_names, last_names, depts):
	first_name = random.choice(first_names)
	last_name = random.choice(last_names)
	dept = random.choice(depts)

	return Faculty(first_name, last_name, dept)

def main():
	with open("data/first-names.txt") as fn, open("data/last-names.txt") as ln, open("data/departments.txt") as dp:
		first_names = [name.strip() for name in fn.readlines()]
		last_names = [name.strip() for name in ln.readlines()]
		depts = [dept.strip() for dept in dp.readlines()]


	query = "INSERT INTO faculty (FirstName, LastName, Department) VALUES\n\t"
	for i in range(FACULTY_COUNT):
		if i != 0:
			query += ",\n\t"
		fac_member = generate_faculty_member(first_names, last_names, depts)
		query += fac_member.as_sql() 

	query += ';'
	
	with open("output/faculty.sql", "w") as out_file:
		out_file.write(query)


if __name__ == "__main__":
	main()