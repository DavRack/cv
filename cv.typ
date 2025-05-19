#set page(
	paper: "a4",
	margin: (x: 0.6cm, y: 0.8cm),
)
#set text(
	font: "Arial",
	size: 10pt,
)
#set par(
	leading: 0.4em,
	spacing: 0.55em,
)
#set list(
	spacing: 0.3em,
	tight: true,
)
#set stack(
	spacing: 5em
)


#let cv_section(name) = [
	#text(
		weight: "bold",
		size: 1.5em,
		name
	)
	#line(
		length: 100%,
	)
]
#let contact_info(name, value) = [
	#text(weight: "bold", name):\
	#value
]
#let experience_block(exp) = [
	#stack(
		dir: ltr,
		spacing: 0.75fr,
		strong(exp.position),
		strong(exp.company),
		strong[#exp.start_date - #exp.end_date]
	)
	#list(
		..exp.description
	)
]
#let project_block(project) = [
	#stack(
		dir: ltr,
		spacing: 0.75fr,
		strong(project.name),
		link(
			project.link,
			project.link.replace("https://www.", ""),
		)
	)
	#list(
		..project.description
	)
]

#let cv_template(
	city_country: "",
	email: "",
	name: "",
	phone_number: "",
	links: (
		(
			name: "",
			link: ""
		),
	),
	skills: (
		(
			name: "",
			skills: ("")
		),
	),
	summary: "",
	experience: (
		(
			position: "",
			company: "",
			start_date: "",
			end_date: "",
			description: (
	      "",
			)
		),
	),
	projects: (
		(
			name: "",
			link: "",
			description: (
          "",
			)
		),
	),
	education: (
		(
			title: "",
			school: "",
			start_date: "",
			end_date: "",
			curses: (
      	"",
			)
		)
	),
	certifications: (
		(
			name: "",
			link: ""
		),
	)
) = {[
	#align(center)[#text(
		weight: "bold",
		size: 1.75em,
		name
	)]
	#stack(
		spacing: 1fr,
		block(
			stack(
				dir: ltr,
				spacing: 1fr,
				contact_info(
					"City / Country",
					city_country
				),
				contact_info(
					"Email",
					email
				),
				contact_info(
					"Phone Number",
					phone_number
				),
				..(links.map(
					(user_link) => {
						contact_info(
							user_link.name,
							link(
								user_link.link,
								user_link.link.replace("https://www.", ""),
							)
						)
				})),
			)
		),
		block[
			#cv_section("Skills")
			#list(
			..skills.map((category) => [
					#text(weight: "bold", category.name+":")
					#category.skills.join(", ")
			]))
		],
		block[
			#cv_section("Summary")
			#par(summary)
		],
		block[
			#cv_section("Experience")
			#stack(
				spacing: 1.25em,
			..(experience.map((exp) => {
					experience_block(exp)
			}))
			)
		],
		block[
			#cv_section("Projects")
			#stack(
				spacing: 1.25em,
			..(projects.map((exp) => {
					project_block(exp)
			}))
			)
		],
		block[
			#cv_section("Education")
			#stack(
				dir: ltr,
				spacing: 1fr,
				strong(education.title),
				strong(education.school),
				strong[#education.start_date - #education.end_date]
			)
			#grid(
				columns: 4,
				column-gutter: 1em,
				row-gutter: 0.4em,
				..education.curses
			)
		],
		block[
			#cv_section("Certifications")
			#list(
				..certifications.map((certification) => {
					link(
						certification.link,
						certification.name
					)
				})
			)
		]
	)
]}

#cv_template(..yaml(sys.inputs.cvdata))
