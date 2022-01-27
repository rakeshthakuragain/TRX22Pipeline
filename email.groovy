def sendSuccessEmail()
{
	def subject = "Job Executed '${env.JOB_NAME} [${env.BUILD_NUMBER}] - ${BUILD_STATUS}'"
	def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
					 <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""
					 
	emailext(
		subject: subject,
		body: details,
		to: 'rakesh.thakur@siemens.com'
	)
}
return this

