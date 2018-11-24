/**
 * Created by zll on 18-10-18.
 */
import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'
import TurbolinksAdapter from 'vue-turbolinks';


Vue.use(VueResource)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token').getAttribute('content')
    const el = document.getElementById('team-form')
    if(el){
        var id = el.dataset.id
        var team = JSON.parse(el.dataset.team)
        const app = new Vue({
            el,
            data:{
                id: id,
                team: team,
                errors: [],
                scrollPosition: null
            },
            mounted(){
                window.addEventListener('scroll',this.updateScroll)
            },
            methods: {
                updateScroll(){
                    this.scrollPosition = window.scrollY
                },
                addUser(){
                    this.team.users.push({"name":null,"email":null,"_destroy":false})
                },
                removeUser(index){
                    var user = team.users[index]
                    if(user.id == null)
                    {
                        this.team.users.splice(index,1)

                    }
                    else {
                        this.$set(user,"_destroy" ,"1")
                    }
                },
                saveTeam(){
                    this.team.users_attributes = this.team.users
                    if(this.id == null || this.id.trim() == ""){
                        this.$http.post('/teams',{team:this.team})
                            .then(response => Turbolinks.visit(`/teams/${response.body.id}`),
                            response => {
                                console.log(response)
                                if(response.status == 422){
                                    var json = JSON.parse(response.bodyText)
                                    this.errors = json["users.email"][0]
                                }
                            })

                    }else{
                        this.$http.put(`/teams/${this.id}`,{team: this.team})
                            .then(response => Turbolinks.visit(`/teams/${response.body.id}`),
                            response => {
                                console.log(response)
                                if(response.status == 422){
                                    var json = JSON.parse(response.bodyText)
                                    this.errors = json["users.email"][0]
                                }
                            })
                    }
                },
                undoRemove(index){
                    var user = team.users[index]
                    user._destroy = null
                }

            }
        })
    }

})
