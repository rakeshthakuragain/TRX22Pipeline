def sendSuccessEmail()
{
	def subject = "Job Executed '${env.JOB_NAME} - [${env.BUILD_NUMBER}] - ${env.BUILD_STATUS}'"
	def details = """<p>Job - '${env.JOB_NAME}' </p>
				 <p>Build number - '[${env.BUILD_NUMBER}]'</p>
				 <p>Status - '${env.BUILD_STATUS}' </p>
				 
				 <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""
	emailext(
		subject: subject,
		body: details,
		to: 'rakesh.thakur@siemens.com'
	)
}
return this

