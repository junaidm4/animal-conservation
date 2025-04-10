import mysql from 'mysql2';

const pool = mysql.createPool({
    host : '127.0.0.1',
    user : 'root',
    password : '123asdfg',
    database : 'komodo_hub'
}).promise();

const result = await pool.query("SELECT * FROM users")

export async function getUser(email) { //returns true if user exists, else false
    //this query selects all the users who have the specified email:
    console.log("get user called with email," ,email)
    const result = await pool.query("SELECT * FROM users WHERE email = ?", [email])
    console.log("result", result[0])

    if(result[0][0]){
        //console.log(true, "so account already exists; hence should not be created")
        return true
    } else {
        //console.log(false)
        return false
    }
    //console.log(result[0][0].username)
    //return result[0];  //get the rows returned by the query, as sql returns more than just the data we want.
}

export function testy(){
    console.log("testy works!")
}
export async function createUser(userData){  //userData is an object
    console.log("in createUser")
    //sql query for inserting user. I used the ? syntax as it is far more secure as it prevents SQL injection attacks.
    const result = await pool.query("INSERT INTO users (forename, surname, organisation_id, hashed_password, dob, email, roles) " +
        "VALUES (?,?, ?, ?, ?, ?, ?)",
        [userData.forename,userData.surname, userData.organisation_id,
            userData.password, userData.dob, userData.email, userData.roles]);
    //query depends on these variables ^ using dummy data for now to focus on functionality.
    //console.log(result)
    return result
} //
export async function createOrganisation(organisationData) {
    const result = await pool.query("INSERT INTO organisations (organisation_id, organisation_name, organisation_type," +
        " enrolled_date, subscription_status, expiry_date) VALUES (?,?,?,?,?,?)",

        [organisationData.organisation_id, organisationData.organisation_name,
            organisationData.organisation_type, organisationData.enrolled_date, organisationData.subscription_status,
            organisationData.expiry_date]);

    return result
}

export async function getOrganisationsByName(name) { //name is parameter
    // specifying which organisation to retrieve
    const result = await pool.query("SELECT * FROM organisations WHERE organisation_name = ?", [name]);
    if(result[0] == undefined){ //if unable to find the organisation
        return false
    } else{
        return result[0]; //return the organisation object

    }


}

export async function getFullUserData(userEmail) {
    const result = await pool.query("SELECT * FROM users WHERE email = ?", [userEmail]);
    //gets the data of the user with email passed as parameter
    //console.log(result[0])
    return(result[0])
}
//getOrganisationsByName("Coventry") //test calling service in db file with
                                                // Coventry parameter hardcoded


/*createOrganisation({
    organisation_id: 1234,
    organisation_name: "st johns school",
    organisation_type: "school",
    enrolled_date: "2010-03-06",
    subscription_status: "active",
    expiry_date: "2010-03-07",
})  */

getFullUserData("")





//createUser()

//getUser('johnj@example.com')
//const rows = result[0]
//console.log(rows)



//module.exports = mysql.createConnection({
  //  host: '127.0.0.1',
    //user: 'root',
    //password: '123asdfg',
//})

// let forename = "john"
//let surname = "smith"
//let organisation_id = 1
//let hashed_password = "vfnjfo"
//let dob ='2010-03-06'
// let email = "john@example.com"
//let {forename, surname, organisation_id, hashed_password, dob, email} = userData;
// let forename = "john"
//let forename = userData.forname;
//let surname = userData.surname
//let organisation_id = userData.organisation_id
//let hashed_password = userData.hashedPassword
//let dob = userData.dob
//let email = userData.email

const dummyData = {
    forename : "o",
    surname : "m",
    organisation_id : 1,
    hashed_password : "gnjorj",
    dob: '2010-03-06',
    email : "c@gmail.com",
}