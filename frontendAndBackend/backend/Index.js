import express from "express";
import "dotenv/config.js";
import cors from "cors";
import bodyParser from "body-parser";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
const app = express()
app.use(bodyParser.json());
import {createUser, getFullUserData, getUser, createOrganisation, getOrganisationsByName} from "./database.js";
import { v4 as uuidv4 } from 'uuid';
import dayjs from "dayjs"



const users = [{
    fName: "matt",
    lName: "fisher",
    email: "matt@gmail.com",
    password: "1234",
}]


app.use(cors({
    origin: "*",
    method: ["GET","POST"],
}))
//users routes:
app.post("/users/signup",async(req,res)=>{
    console.log({body:req.body})
    if(!req.body.forename || !req.body.surname || !req.body.email || /*!req.body.organisation_id*/  !req.body.password || !req.body.dob  || !req.body.role ) {
        console.log("need full data")
        res.status(400).json({
            success: false,
            reason:"please fill all fields"})
        return;
    } else if(await getUser(req.body.email)==true) { //call db service to see if user already exists.
        console.log(getUser(req.body.email))
        res.status(400).json({success: false, reason:"account with that email already exists"})
        return;
    } else if((req.body.role !== "Teacher" && req.body.role !== "Student")){
        console.log("need student or teacher")
        res.status(400).json({success: false, reason:"need to send role correctly"})

    } else{
        try{
            const parsedDate = dayjs(req.body.dob, ['YYYY-MM-DD', 'MM/DD/YYYY', 'DD-MM-YYYY'], true);

            if (!parsedDate.isValid()) {
                return res.status(400).json({ error: 'Invalid date format. Please use YYYY-MM-DD.' });
            }
            const formattedDate = parsedDate.format('YYYY-MM-DD');
            console.log(formattedDate)
            const salt = await bcrypt.genSalt()
            bcrypt.hash(req.body.password, salt, function(err, hash) {
                if(err){
                    console.log(err)
                } else{
                    let user = {forename : req.body.forename, surname: req.body.surname,
                        password : hash, email: req.body.email, dob: formattedDate, organisation_id:1234, roles: req.body.role}
                    createUser(user)
                }
                // Store hash in data object and call db service
            });

           // users.push(user)
            res.status(200).json({success: true})
            return;
        } catch {

        }}
    const user = {name : req.body.name, password : req.body.password}
    users.push(user)
    // const accessToken = jwt.sign(user, `${process.env.SECRET_KEY}`)
    // res.json({accessToken: accessToken})
    res.json("signup successful")
})
app.post("/users/login", async(req,res) => {
    if(!req.body.email || !req.body.password) { //if no password or username then send failure response
        res.status(400).send("username and password not sent")
        return;
    }
    console.log("attempted login ---")
    const user = {email : req.body.email, password : req.body.password}
        //user object made from parameters
    if(await getUser(req.body.email)){ //await getUser db service call, if true then user exists
        const matchingUser =  await getFullUserData(user.email) //if user exists query for there full data
        console.log({matchingUser})
        bcrypt.compare(user.password, matchingUser[0].hashed_password, function (err,response)  {
            //compare the password the user has sent with the hashed one stored in the database

            if(err){
                throw err
            }
            if (response) { //if they match
                console.log({response})
                const accessToken = jwt.sign(user,process.env.ACCESS_SECRET_TOKEN)//create access token
                res.status(200).json({accessToken: accessToken }) //send to user in response

            } else{
                res.status(401).send("passwords dont match") //if passwords dont match send failure response

            }})
}})





app.get("/users/getuser",(req,res)=> { //listens for http://localhost:4000/users/getuse
    if( !req.query.email){
        res.status(400).send("insufficient data sent")
    } else {
        const matchingUsers = users.find(user => {   //look in our mock user database
            if(user.email == req.query.email) { //matching user object exists?
                return user         //return the matching user to variable matchingUsers
            }})
        console.log(matchingUsers)
        if(matchingUsers == null){  //if no matching user
            res.status(400).send("user doesnt exist") //cant get user to failure response
        }
        if(matchingUsers){  //if one matching user
            res.status(200).send(matchingUsers)  //user exists and can be sent in response

        }
    }

})

let organisations = [
    {
        organisation_id: "1234",
        organisation_name: "Savannah_Saviors",
        organisation_type: "school",
        enrolled_date: "23-02-2020",
        subscription_status: "active",
        expiry_date: "23-02-2026",
        description: "Savannah Saviors is a dedicated wildlife conservation organization that focuses on protecting and preserving the African savannah ecosystem. The organisation has been actively involved in monitoring and safeguarding the elephant populations in Kenya and Tanzania, where poaching and habitat loss are significant threats to these magnificent creatures. Through a series of field-based research projects, local community engagement, and conservation advocacy, Savannah Saviors works tirelessly to mitigate the impact of human-wildlife conflict and ensures the long-term survival of elephants and other endangered species. In addition to their efforts on the ground, they also provide educational outreach programs to schools and communities, raising awareness about the importance of biodiversity and habitat conservation. Their primary goal is to ensure that the savannah ecosystems remain healthy and sustainable for future generations, while also providing valuable resources for local communities to coexist with wildlife.",
        importance_of_this_conservation: "The African savannah is a critical ecosystem, home to many endangered species such as elephants, cheetahs, and lions. The conservation of this biome is essential not only for the survival of these animals but also for the overall health of the planet. As one of the most biodiverse ecosystems on Earth, it plays a vital role in regulating climate, water, and soil quality. The loss of the savannah ecosystem would result in the extinction of numerous species and disrupt the balance of the global environment. By preserving the African savannah, we help ensure that the delicate balance of the Earth's natural systems is maintained, allowing both wildlife and human populations to thrive. Additionally, protecting the savannah creates a lasting legacy for future generations who will benefit from the biodiversity and natural resources it provides.",
        how_you_can_help: "As a student, there are many ways you can contribute to the efforts of Savannah Saviors and other wildlife conservation organizations. One of the most impactful things you can do is raise awareness about the importance of wildlife conservation in your community. You can participate in local fundraising events, donate to wildlife conservation projects, or volunteer with organizations that focus on protecting endangered species. Additionally, consider advocating for stronger environmental policies in your local government to support conservation efforts. Educating yourself and others about the threats facing wildlife, such as poaching, climate change, and habitat destruction, is another valuable way to help. Every action, no matter how small, can make a significant difference in the fight to protect the African savannah and its wildlife.",
    },
    {
        organisation_id: "5678",
        organisation_name: "Elephant_Protection_Network",
        organisation_type: "community",
        enrolled_date: "12-05-2018",
        subscription_status: "active",
        expiry_date: "12-05-2025",
        description: "The Elephant Protection Network is a grassroots wildlife conservation initiative that focuses on protecting African elephants from poaching and human-wildlife conflict in Southern Africa. The network works in collaboration with local communities, national parks, and conservation organizations to create anti-poaching strategies and sustainable conservation practices. In addition to their work on the ground, the Elephant Protection Network also provides education and training for local communities, empowering them to be active participants in the conservation of elephants. Their focus is on reducing the demand for ivory, strengthening anti-poaching patrols, and mitigating human-elephant conflict, which often leads to harm for both elephants and people. Through their holistic approach, the Elephant Protection Network aims to ensure the long-term survival of elephants in Africa while benefiting the local populations who depend on these ecosystems for their livelihoods.",
        importance_of_this_conservation: "Elephants play a crucial role in maintaining the ecological balance of their habitats. They help to disperse seeds, create waterholes, and maintain open grasslands that benefit many other species. Unfortunately, elephants face an enormous threat from poaching for their ivory tusks, which has led to the rapid decline of their populations. The loss of elephants would not only disrupt the ecosystems they help sustain but also result in the loss of one of the planet's most iconic and magnificent species. Protecting elephants is therefore crucial for biodiversity conservation, as their existence supports the health of many other species in the African ecosystem. Conservation efforts to protect elephants directly impact the future of African ecosystems and the health of the environment at large.",
        how_you_can_help: "Students can make a difference in elephant conservation by raising awareness about the issues elephants face, particularly the illegal ivory trade. You can participate in educational campaigns that promote the importance of protecting elephants and their habitats. Volunteering with conservation organizations, participating in local clean-up drives, and supporting elephant-friendly tourism are all ways you can contribute. Additionally, advocating for policies that combat illegal wildlife trafficking and promoting sustainable practices in communities are essential to long-term conservation efforts. Your involvement, whether it’s through small actions or large-scale advocacy, can help ensure that elephants continue to thrive in the wild.",
    },
    {
        organisation_id: "91011",
        organisation_name: "Lion_Protection_Alliance",
        organisation_type: "community",
        enrolled_date: "01-08-2019",
        subscription_status: "active",
        expiry_date: "01-08-2024",
        description: "The Lion Protection Alliance is a community-driven organization focused on preserving African lion populations, particularly in areas where human-wildlife conflict threatens their survival. Lions are apex predators and essential to maintaining the balance of ecosystems, but their populations are rapidly declining due to poaching, loss of habitat, and retaliation from farmers whose livestock are targeted by lions. The Lion Protection Alliance works closely with local communities to implement lion conservation strategies, such as creating wildlife corridors, reducing human-lion conflict, and promoting sustainable coexistence. The organization also supports lion research initiatives and works to increase awareness of the importance of protecting lions for both ecological and cultural reasons. By engaging local populations in the conservation process, the Lion Protection Alliance ensures that efforts are rooted in the communities that need them the most.",
        importance_of_this_conservation: "Lions are not only an important cultural symbol for many African nations, but they also play a vital role in maintaining the health of ecosystems by controlling herbivore populations. As apex predators, lions regulate the populations of other species and ensure that ecosystems remain balanced. Without lions, herbivore populations would grow unchecked, leading to overgrazing and the destruction of habitats for many other species. Protecting lions is thus crucial not only for the species itself but for the integrity of entire ecosystems. The conservation of lions also has significant economic benefits through eco-tourism, as many visitors come to Africa specifically to see lions in their natural habitats. By conserving lions, we protect an entire ecosystem, its biodiversity, and the livelihoods of communities who depend on tourism.",
        how_you_can_help: "As a student, there are many ways you can get involved in lion conservation efforts. You can participate in awareness campaigns that highlight the importance of lions in maintaining ecosystem balance and reducing human-wildlife conflict. You can support organizations that work on the ground to protect lions by donating or volunteering your time. Additionally, you can advocate for policies that protect lions and other big cats from poaching and habitat destruction. Educating your peers about the threats facing lions and other wildlife will help create a larger base of support for conservation initiatives. Every voice matters, and your efforts can help secure a future for lions and their ecosystems.",
    }
];



app.post("/organisation/create",async(req,res)=> {
    if(!req.body.organisation_name || !req.body.organisation_type){ //if necessary parameters are not sent then
        res.status(400).send("insufficient data sent") // response with error
    }
    let exists = await getOrganisationsByName(req.body.organisation_name) //call get handler to find if organisation already exists.

    if(exists.length != 0){ //if organisation already exists, return already exists message.
        return res.status(400).send("organisation already exists")}
    let newOrg = {
        organisation_id: Math.random() * 100000000,  //generate id
        enrolled_date : new Date().toISOString().slice(0, 19).replace('T', ' '), //current date
        subscription_status : "active", //organisation is active as its just been created
        organisation_name: req.body.organisation_name,  //name is passed-in parameter
        organisation_type: req.body.organisation_type,  //type is passed-in parameter
        expiry_date: new Date().toISOString().slice(0, 19).replace('T', ' '), //date in 3 years
    }
    const result = await createOrganisation(newOrg) //call create db servie
    if(result[0] && result[0].insertId){ //if insert id is returned then creation must have been successful
        console.log("return success msg")
        return res.status(200).send({success:true}) //successful status
    } else {
        return res.status(400).send({success:false}) //error status
    }
})

app.get("/organisation/get", async(req,res)=> {
    if(!req.query.name){  //name parameter needed so we know which organisation to query for
        res.status(400).send("send id") //if no name send error response
    }
    const org = await getOrganisationsByName(req.query.name) //call database service
    if(org==false){  //if service response is false there is no org with that name
        return res.status(400).send("organisation does not exist") // so return error
    } else{ //if there is an organisation...
        return res.status(200).send(org[0])  //respond with the organisation data.
    }


})

app.post("/organisation/update",(req,res)=> {
    if(!req.query.id){
        res.status(400).send("send id")
    }
    let orgToUpdate = organisations.find(org => org.organisation_id == req.query.id);
    let filteredOrgs = organisations.filter(org => org!= orgToUpdate)
    if(!orgToUpdate){
        res.status(400).send("incorrect id")
        return;
    }
    if(req.body.organisation_name){
        orgToUpdate = {...orgToUpdate, organisation_name: req.body.organisation_name};
    }
    if(req.body.organisation_type){
        orgToUpdate = {...orgToUpdate, organisation_type: req.body.organisation_type};
    }
    if(req.body.subscription_status){
        orgToUpdate = {...orgToUpdate, subscription_status: req.body.subscription_status};
    }
    filteredOrgs.push(orgToUpdate)
    organisations = filteredOrgs
    res.json(organisations)


    if(!req.body.organisation_name && !req.body.organisation_type && !req.body.subscription_status){
        res.status(400).send("send data that needs to be updated")
    }
    let updatingOrg = organisations.find(org => {
        org.organisation_id == req.params.id
    })
    res.send(updatingOrg)
    updatingOrg = {...updatingOrg, }
    updatingOrg.organisation_id = req.body.organisation_id

})

app.get("/orgs/dummyData", async (req, res) => {
    console.log("dummy data reached:");

    const organisationName = req.query.organisation_name;

    if (organisationName) {
        let org = await getOrganisationsByName(organisationName);

        // Send back both organisations and the newly created organisation
        res.send({
            organisations: organisations,  // Make sure 'orgs' is the correct array of organisations
            newlyCreatedOrganisation: org // Ensure 'org' is the newly created organisation
        });
    } else {
        res.send({ organisations: orgs });
    }
});

app.listen(4001, () => {
    console.log("Server running on port 4001")
})


/* app.post("/users/signup",(req,res)=> {          //listens for http://localhost:4000/users/signUp
    if(!req.body.forename || !req.body.surname || !req.body.email || !req.body.password || !req.body.dob){
        res.status(400).send("insufficient data sent")  //need all fields above to be sent in req.body
    } else{
        users.push({                  //create a new user object using sent data,
            forename: req.body.forename,            //add it to our mock database
            surname: req.body.surname,
            email: req.body.email,
            password: req.body.password,
            dob: req.body.dob
        })
        console.log(users);
        res.status(200).send("successful signup")  //send success code
    }

})

app.post("/users/login",(req,res)=> {               //listens for http://localhost:4000/users/login
    if(!req.body.email || !req.body.password ){  //check if email and password sent in request
        res.status(400).send("insufficient data sent")  //reject if absent
    } else {  //if email and password both sent
        const matchingUsers = users.find(existingUser => {   //look in our mock user database
            if(req.body.email === existingUser.email && req.body.password === existingUser.password) { //matching user object exists?
                return existingUser         //return the matching user to variable matchingUsers
            }})
        if(matchingUsers == null){  //if no matching user
            res.status(400).send("user doesnt exist") //login failure response
        }
        if(matchingUsers){  //if one matching user
            res.status(200).send("successfully logged in")  //user has logged

        }
    }
})

*/