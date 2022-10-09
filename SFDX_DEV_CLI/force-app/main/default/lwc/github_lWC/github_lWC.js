import { LightningElement } from 'lwc';

const Github_URL = "https://api.github.com/users/";

export default class Github_lWC extends LightningElement {
    username;
    user = {};

    /*  This method will return if the user object is populated or not */
    get userPopulated() {
        return this.user && this.user.id;
    }

    /* This method will return the github url for the searched user */ 
    get githubUrl() {
        return 'https://www.github.com/' + this.username;
    }

    /* This method will set the username as the user is typing the text in the input field */ 
    updateUsername(event) {
        this.username  = event.target.value;
    }

    /* This method is used to call GitHub API using fetch method and get the user details */
    getGithubProfileInfo() {
        console.log(this.username);
        if (this.username) {
            this.user = {};
            fetch(Github_URL + this.username)
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw Error(response);
                }
                })
                .then(githubUserDetails => {
                    this.user = {
                        id: githubUserDetails.id,
                        name: githubUserDetails.name,
                        image: githubUserDetails.avatar_url,
                        blog: githubUserDetails.blog,
                        about: githubUserDetails.bio,
                        repos: githubUserDetails.public_repos,
                        gists: githubUserDetails.public_gists,
                        followers: githubUserDetails.followers

                    };
                })
            .catch(error => console.log(error))
        } else {
            alert("Please specify a username");
        }
    }
}