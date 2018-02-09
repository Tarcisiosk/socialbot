# EADBOX WEBHOOK

This project is a twitter bot that publish something evertytime a course is created.

It's integrated with eadbox platform, you just need to create a account at eadbox.com. In your administrative panel goes to Integrations/Webhooks. There you'll paste the url with the callback action from controller /hook/course_created_callback/
This way, everytime you create a course in EADBOX, it'll send a post to this action with the course params. The app will created a course based on this params and will publish a tweet about it.

