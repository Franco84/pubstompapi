This is the backend API for PubStomp.  We sticking close to REST guidelines, see endpoints listed below.

POST: 

/signup => email, password, password_confirmation => returns token on success
/login => email, password => returns token on success
/profiles => display_name, first_name, last_name => creates profile and saves it to authed user => returns profile

GET: 
/users =>  lists all users
/user/:id =>  returns user info

/profiles =>  lists all profiles
/profile/:id =>  returns profile info
/profile/:display_name =>  returns profile info

