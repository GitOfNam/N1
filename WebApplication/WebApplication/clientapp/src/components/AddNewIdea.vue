<template>
    <nav class="main-menu">
        <ul>
            <li>
                <a href="/">
                    <i class="fa fa-home fa-2x"></i>
                    <span class="nav-text">
                        Dashboard
                    </span>
                </a>
            </li>
            <li class="has-subnav">
                <a href="/addnew">
                    <i class="fa fa-plus-circle"></i>
                    <span class="nav-text">
                        Add New Idea
                    </span>
                </a>
            </li>
        </ul>
        <ul class="logout">
            <li class="has-subnav" v-if="this.UserModel.Position == 'PS01'">
                <a href="/infor">
                    <i class="fa fa-user"></i>
                    <span class="nav-text">
                        Staff Information
                    </span>
                </a>
            </li>
            <li>
                <a href="/login">
                    <i class="fa fa-power-off fa-2x"></i>
                    <span class="nav-text">
                        Logout
                    </span>
                </a>
            </li>
        </ul>
    </nav>
    <div id="myModalNNExHD" class="modal" style="z-index: 9000">
        <div class="modal-content" style="height: auto">
            <div id="closeButton" class="cButton" style="text-align:center">
                <!--<div class="close" style="font-size: 29px; padding-right: 10px; margin-top: -12px;" @click="closepopupNNExHD()">&times;</div>-->
            </div>
            <div>
                <div style="width: 100%;">
                    <div style="width:100%; border:1px solid black;border-radius:5px;height: 400px">
                        <p> <b>Điều khoản</b></p>
                    </div>
                    <div  style="width:100%;text-align:left;margin:5px;">
                        <input type="checkbox" v-model="Comfirm"/> <span style="color:brown">Tôi đồng ý với các điều khoản trên!</span>
                    </div>
                </div>
            </div>
            <div style="text-align:right">
                <button @click="closepopupNNExHD()"  class="nbtn" style="margin-right:2px" >Close</button>
                <button v-if="this.Comfirm" @click="insertIDeas()"  class="nbtn" >Accept</button>
            </div>
        </div>
    </div>
    <div class="app-container">

        <div class="app-header">
            <div class="app-header-left">

                <p class="app-name">Project Collection Ideas</p>
                <!-- <div class="search-wrapper">
                  <input class="search-input" type="text" placeholder="Search">
                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="feather feather-search" viewBox="0 0 24 24">
                    <defs></defs>
                    <circle cx="11" cy="11" r="8"></circle>
                    <path d="M21 21l-4.35-4.35"></path>
                  </svg>
                </div> -->
            </div>
            <div class="app-header-right">
                <!-- <button class="mode-switch" title="Switch Theme">
                  <svg class="moon" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" width="24" height="24" viewBox="0 0 24 24">
                    <defs></defs>
                    <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z"></path>
                  </svg>
                </button>
                <button class="add-btn" title="Add New Project">
                  <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus">
                    <line x1="12" y1="5" x2="12" y2="19" />
                    <line x1="5" y1="12" x2="19" y2="12" /></svg>
                </button>
                <button class="notification-btn">
                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bell">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" />
                    <path d="M13.73 21a2 2 0 0 1-3.46 0" /></svg>
                </button> -->
                <button class="profile-btn">
                    <img src="https://assets.codepen.io/3306515/IMG_2025.jpg" />
                    <span>{{this.UserModel.FullName}}</span>
                </button>
            </div>
            <button class="messages-btn">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-message-circle">
                    <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z" />
                </svg>
            </button>
        </div>
        <div class="app-content">

            <div class="projects-section">
                <div class="projects-section-header">
                    <p v-if="this.ID == ''|| this.ID == undefined">Add New Ideas</p>
                    <p>
                        <span v-if="this.ID">ID: {{Ideas.IID}}</span> <span><i v-if="this.Ideas.IsOnline == true && this.Ideas.Tag" style="width: 83px; text-align: left; height: 17px; font-size: 15px; color: blue; padding: 5px;" class="fa fa-tag">  <span style="margin-left: 5px;">{{this.Ideas.TagName}}</span></i></span>
                    </p>
                    <p class="time">
                        <button v-if="this.ID == '' || this.ID == undefined" class="nbtn" @click="CheckComfirm()">Sent</button>
                        <button v-if="this.ID && this.FileName != '' && this.FileName != 'null' && this.UserModel.Position == 'PS02'" class="nbtn" @click="downloadFile()" style="width: 118px;">DownLoad File</button>
                        <button v-if="this.UserModel.Position == 'PS02' && this.Ideas.IsOnline == false && this.ID" class="nbtn" @click="Brose()" style="margin-left:2px">Browse</button>
                        <button v-if="(this.UserModel.Position == 'PS02' && this.Ideas.IsOnline == false && this.ID) || (this.UserModel.UserCode == this.Ideas.Crt_User && this.Ideas.IsOnline == false && this.ID)" class="nbtn" @click="UpdateIDeas()" style="margin-left:2px">Update</button>
                        <button v-if="(this.UserModel.Position == 'PS02' && this.Ideas.IsOnline == false && this.ID)" @click="DeleteIDeas()" class="nbtn" style="margin-left:2px">Delete</button>
                    </p>
                </div>
                <div style="display: flex;justify-content:space-between;width:100%">
                    <div style="width:74%;height:478px;    border: 2px solid navajowhite;border-radius: 6px;">
                        <div style=" width: 100%; margin: 10px; padding: 10px; text-align: left;">
                            <span style="margin-right: 4%"><label><b>Title:</b> </label></span>
                            <input style="width: 89.7%; height: 29px; border-radius: 6px;" v-model="Ideas.Title" />
                        </div>
                        <div style=" width: 100%; margin: 10px; padding: 10px; text-align: left;">
                            <p style="margin-right: 4%"><label><b>Content:</b> </label></p>
                            <textarea v-model="Ideas.Content" style="width: 98%; border-radius: 6px; height: 200px; max-width: 98%; max-height: 200px;"></textarea>
                            <p>
                                <label><b>File Attack:</b></label>  <input multiple @change="fileChange($event.target.files)" type="file" />
                                <label><b>Mode Browser: </b></label>
                                <select v-model="this.Ideas.isOption">
                                    <option value="true">Incognito</option>
                                    <option value="false">Nomal</option>
                                </select>
                            </p>
                        </div>
                        <div style=" width: 100% ;text-align: left;margin-left: 20px">
                            <p>
                                <label v-if="this.UserModel.Position == 'PS01'"><b>Date Start:</b></label> <input v-if="this.UserModel.isAdmin == true" v-model="Ideas.StartDatefrm" type="datetime" placeholder="yyyy/MM/dd" style="height: 29px; border-radius: 6px;" /> <label v-if="this.UserModel.isAdmin == true" style="margin-left: 30px"><b>Date End:</b></label> <input v-if="this.UserModel.isAdmin == true" v-model="Ideas.EndDatefrm" type="datetime" placeholder="yyyy/MM/dd" style="height: 29px; border-radius: 6px;" />
                                <label v-if="this.UserModel.Position == 'PS02'"><b>Tag: </b></label>
                                <select v-if="this.UserModel.Position == 'PS02'" v-model="Ideas.Tag">
                                    <option value=""></option>
                                    <option value="Tag01     ">Impotant</option>
                                    <option value="Tag02     ">Good</option>
                                </select>
                            </p>

                        </div>
                    </div>
                    <div v-if="this.ID && this.Ideas.IsOnline == true" style="width:25%;height:478px;    border: 1px black solid;border: 2px solid navajowhite;border-radius: 6px;">
                        <div style=" width: 100%; text-align: left;">
                            <div style=" padding: 10px; text-align: center; border-bottom: 1px navajowhite dashed; font-size: 23px; font-family: 'FontAwesome'; color: red;">
                                Comment Box
                            </div>
                            <div style="justify-content:space-between;display:flex;width: 100%;border-bottom: 1px navajowhite dashed ">
                                <div style="width: 50%;text-align:center;border-right: 1px navajowhite dashed">
                                    <button @click="Like()" style="width: 100%;  background-color: transparent;border-color: transparent"><i style=" padding-left: 93%;" class="LikeDis fa fa-thumbs-up"></i></button>
                                </div>
                                <div style="width: 50%;text-align:center">
                                    <button @click="DisLike()" style="width: 100%;  background-color: transparent;border-color: transparent;"><i style=" padding-left: 93%;" class="LikeDis fa fa-thumbs-down"></i></button>
                                </div>
                            </div>
                            <div style=" width: 100%; text-align: left;margin-bottom: 5px">
                                <input style="width:88%" v-model="IdeaComments.Comment" placeholder="write your comments..." /> <button style="width: 10%;  background-color: transparent;border-color: transparent;" @click="insertIDeaComments()"><i style="color: dodgerblue;height: 20px;font-size: 18px;vertical-align: bottom;margin-top: 29px;" class="fa fa-location-arrow"></i></button>
                            </div>
                            <div style="width: 100%; text-align: left; height: 330px; border-top: 1px solid navajowhite; overflow-y: auto; overflow-x: hidden;">
                                <div v-for="(item,index) in IdeaCommentsLisst" v-bind:key="index" style="justify-content:space-between;display:flex;width: 100%; margin:10px;">
                                    <div style="width: 10%;height:auto;vertical-align:top">
                                        <img src="https://img.lovepik.com/element/40213/4111.png_860.png!/both/336x336" style=" width: 28px; border-radius: 50%;" />
                                    </div>
                                    <div style="width: 90%;height:auto">
                                        <div style="max-width: 249px">
                                            <textarea style="width: 252px; max-width: 252px; border: transparent; font-size: 15px; font-family: 'FontAwesome';height: auto;overflow: hidden;" v-model="item.Comment"> </textarea><br /> <span style="font-size: 13px"><i>{{item.Crt_Datefrm}}</i> by {{item.Crt_Name}}</span>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>


<script>
    import axios from 'axios'
    export default {
        components: {
        },
        data() {
            return {
                ID: '',
                IdeaCommentsLisst: [],
                lstFileAttach: [],
                files: new FormData(),
                Comfirm: false,
                Ideas: {
                    IID: '',
                    Title: '',
                    Content: '',
                    Crt_User: '',
                    Crt_Date: new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + new Date().getDate(),
                    IsActive: false,
                    IsOnline: false,
                    View_numb: 0,
                    StartDate: new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + new Date().getDate(),
                    EndDate: new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + new Date().getDate(),
                    LikeNumb: 0,
                    DisLikeNumb: 0,
                    FileName: '',
                    StartDatefrm: '',
                    Date_Onlinefrm: '',
                    EndDatefrm: '',
                    FilePath: '',
                    isOption: false,
                    Date_Online: new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + new Date().getDate(),
                    msg: '',
                    Tag: '',
                    TagName: '',
                    UserLike:'',
                    UserDisLike: '',
                    CrtName:''

                },
                IdeaComments: {
                    IID: '',
                    Comment: '',
                    Crt_User: '',
                    Crt_Name: '',
                    Crt_Date: new Date(),
                    Crt_Datefrm: '',
                },
                UserModel: {
                    UserCode: '',
                    UserName: '',
                    Password: '',
                    FullName: '',
                    Email: '',
                    Address: '',
                    NumberPhone: '',
                    Crt_Date: new Date(),
                    KeyEnCrypt: '',
                    KeyValidate: '',
                    isAdmin: false,
                    isQA: false,
                    isStaffIT: false,
                    isStaffBusiness: false,
                    isStaffComputerScience: false,
                    Position: '',
                },
            }
        },
        methods: {
            async getDB() {
                await axios.get('/api/Department').then(function (response) {
                    console.log(response);
                }).catch(function (error) {
                    console.log(error);
                })
            },
            async getTTDN() {
                let response = await axios.get('/api/User/ttdn');
                if (response) {
                    this.UserModel = response.data;
                }
            },
            async showpopupNNExHD() {
                document.getElementById('myModalNNExHD').style.display = "block";
            },
            async closepopupNNExHD() {
                document.getElementById('myModalNNExHD').style.display = "none";
            },
            async getIID() {
                let response1 = await axios.get('/api/User/getIID');
                if (response1) {
                    this.Ideas.IID = response1.data;
                }
            },
            async fileChange(fileList) {
                var myID = this.$route.query.IID;
                if (myID) {
                    this.Ideas.IID = myID;
                } else {
                    await this.getIID();
                }
                for (var i = 0; i < fileList.length; i++) {
                    if (fileList.length == 1) {
                        this.files.append(this.Ideas.IID, fileList[i], fileList[i].name);
                    }
                    if (fileList.length == 2) {
                        this.files.append(this.Ideas.IID, fileList[0], fileList[0].name);
                        this.files.append(this.Ideas.IID, fileList[1], fileList[1].name);
                    }
                    if (fileList.length == 3) {
                        this.files.append(this.Ideas.IID, fileList[0], fileList[0].name);
                        this.files.append(this.Ideas.IID, fileList[1], fileList[1].name);
                        this.files.append(this.Ideas.IID, fileList[2], fileList[2].name);
                    }
                    for (var t = 0; t < fileList.length; t++) {
                        this.lstFileAttach.push(this.files);
                    }
                }

            },
            async CheckComfirm() {
                if (this.Comfirm) {
                    await this.insertIDeas();
                }
                else {
                    await this.showpopupNNExHD();
                }
            },
            async insertIDeas() {
                if (this.Ideas.IID == '') {
                    await this.getIID();
                }
                var data = {
                    Ideas: this.Ideas
                };
                for (var i = 0; i < this.lstFileAttach.length; i++) {
                    await axios.post('/api/User/uploadfile', this.lstFileAttach[i],
                        {
                            headers: {
                                'Content-Type': 'multipart/form-data'
                            },
                            onUploadProgress: function (progressEvent) {
                                this.uploadPercentage = parseInt(Math.round((progressEvent.loaded * 100) / progressEvent.total))
                            }.bind(this)

                        }
                    ).then((response) => {
                        this.Ideas.FilePath = response.data.url;
                        this.Ideas.FileName = response.data.name;
                    });
                }
                console.log(data);
                let response = await axios.post('/api/User/InsIdeas', data);
                if (response) {
                    alert("Insert success!!!");
                    window.open('/addnew?IID=' + this.Ideas.IID, '_self');
                }
            },
            async Brose() {
                var myID = this.$route.query.IID;
                this.Ideas.IID = myID;
                var data = {
                    Ideas: this.Ideas
                };
                console.log(data);
                let response = await axios.post('/api/User/Browse', data);
                if (response) {
                    alert("Browse success!!!");
                    window.location.reload();
                }
            },
            async downloadFile() {
                var myID = this.$route.query.IID;
                let response = await axios.get('/api/User/downloadFile?IID=' + myID);
                if (response) {
                    alert("Download success!!!");
                }
            },
            async Like() {
                var myID = this.$route.query.IID;
                this.Ideas.IID = myID;
                var data = {
                    Ideas: this.Ideas
                };
                console.log(data);
                let response = await axios.post('/api/User/Like', data);
                if (response) {
                    document.getElementsByClassName('LikeDis')[0].style.color = 'green';
                    document.getElementsByClassName('LikeDis')[1].style.color = 'black';
                }
            },
            async DisLike() {
                var myID = this.$route.query.IID;
                this.Ideas.IID = myID;
                var data = {
                    Ideas: this.Ideas
                };
                console.log(data);
                let response = await axios.post('/api/User/DisLike', data);
                if (response) {
                    document.getElementsByClassName('LikeDis')[1].style.color = 'green';
                    document.getElementsByClassName('LikeDis')[0].style.color = 'black';
                }
            },
            async DeleteIDeas() {
                var myID = this.$route.query.IID;
                this.Ideas.IID = myID;

                var data = {
                    Ideas: this.Ideas
                };
                console.log(data);
                let response = await axios.post('/api/User/DeleteIDeas', data);
                if (response) {
                    alert("Delete Ideas success!!!");
                    window.open('/', '_self');
                }
            },
            async UpdateIDeas() {
                var myID = this.$route.query.IID;
                this.IdeaComments.IID = myID;
                
                var data = {
                    Ideas: this.Ideas
                };
                console.log(data);
                let response = await axios.post('/api/User/InsIdeas', data);
                if (response) {
                    alert("Update success!!!");
                    window.location.reload();
                }
            },
            async insertIDeaComments() {
                var myID = this.$route.query.IID;
                this.IdeaComments.IID = myID;
                var data = {
                    IdeaComments: this.IdeaComments
                };
                let response = await axios.post('/api/User/InsIdeaComments',data).catch(function (error) {
                    this.isFalse(error);
                });
                if (response) {
                    this.IdeaCommentsLisst = response.data;
                    this.IdeaComments.Comment = "";
                }
            },
        },
        
        async mounted() {
            this.getTTDN();
            var myID = this.$route.query.IID;
            this.ID = myID;
            if (myID) {
                let response = await axios.get('/api/User/getIdeasByID?ID=' + myID);
                if (response) {
                    this.Ideas = response.data.results.ideas;
                    this.IdeaCommentsLisst = response.data.results.ideaComments;
                    if (response.data.isLike == true) {
                        document.getElementsByClassName('LikeDis')[0].style.color = 'green';
                        document.getElementsByClassName('LikeDis')[1].style.color = 'black';
                    }
                    else if (response.data.isDisLike == true){
                        document.getElementsByClassName('LikeDis')[1].style.color = 'green';
                        document.getElementsByClassName('LikeDis')[0].style.color = 'black';
                    }
                }
            }
        }
    }


</script>


<style>
    @charset "UTF-8";
    @import url("https://fonts.googleapis.com/css?family=DM+Sans:400,500,700&display=swap");

    * {
        box-sizing: border-box;
    }

    @import url(//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css);

    @import url(https://fonts.googleapis.com/css?family=Titillium+Web:300);

    .fa-2x {
        font-size: 2em;
    }
    .nbtn {
        border-radius: 4px;
        /* height: 29px; */
        width: 84px;
        color: #fff;
        background-color: #3c8dbc;
        border-color: #367fa9;
        display: inline-block;
        padding: 6px 12px;
        margin-bottom: 0;
        font-size: 14px;
        font-weight: 400;
        line-height: 1.42857143;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
    }
    .fa {
        position: relative;
        display: table-cell;
        width: 60px;
        height: 36px;
        text-align: center;
        vertical-align: middle;
        font-size: 20px;
    }


    .main-menu:hover, nav.main-menu.expanded {
        width: 250px;
        overflow: visible;
    }

    .main-menu {
        background: #212121;
        border-right: 1px solid #e5e5e5;
        position: absolute;
        top: 0;
        bottom: 0;
        height: 100%;
        left: 0;
        width: 60px;
        overflow: hidden;
        -webkit-transition: width .05s linear;
        transition: width .05s linear;
        -webkit-transform: translateZ(0) scale(1,1);
        z-index: 1000;
    }

        .main-menu > ul {
            margin: 7px 0;
        }

        .main-menu li {
            position: relative;
            display: block;
            width: 250px;
        }

            .main-menu li > a {
                position: relative;
                display: table;
                border-collapse: collapse;
                border-spacing: 0;
                color: #999;
                font-family: arial;
                font-size: 14px;
                text-decoration: none;
                -webkit-transform: translateZ(0) scale(1,1);
                -webkit-transition: all .1s linear;
                transition: all .1s linear;
            }

        .main-menu .nav-icon {
            position: relative;
            display: table-cell;
            width: 60px;
            height: 36px;
            text-align: center;
            vertical-align: middle;
            font-size: 18px;
        }

        .main-menu .nav-text {
            position: relative;
            display: table-cell;
            vertical-align: middle;
            width: 190px;
            font-family: 'Titillium Web', sans-serif;
        }

        .main-menu > ul.logout {
            position: absolute;
            left: 0;
            bottom: 0;
        }

    .no-touch .scrollable.hover {
        overflow-y: hidden;
    }

        .no-touch .scrollable.hover:hover {
            overflow-y: auto;
            overflow: visible;
        }

    a:hover, a:focus {
        text-decoration: none;
    }

    nav {
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        
        user-select: none;
    }

        nav ul, nav li {
            outline: 0;
            margin: 0;
            padding: 0;
        }

        .main-menu li:hover > a, nav.main-menu li.active > a, .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus, .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus, .no-touch .dashboard-page nav.dashboard-menu ul li:hover a, .dashboard-page nav.dashboard-menu ul li.active a {
            color: #fff;
            background-color: #5fa2db;
        }

    .area {
        float: left;
        background: #e2e2e2;
        width: 100%;
        height: 100%;
    }

    @font-face {
        font-family: 'Titillium Web';
        font-style: normal;
        font-weight: 300;
        src: local('Titillium WebLight'), local('TitilliumWeb-Light'), url(http://themes.googleusercontent.com/static/fonts/titilliumweb/v2/anMUvcNT0H1YN4FII8wpr24bNCNEoFTpS2BTjF6FB5E.woff) format('woff');
    }

    :root {
        --app-container: #f3f6fd;
        --main-color: #1f1c2e;
        --secondary-color: #4a4a4a;
        --link-color: #1f1c2e;
        --link-color-hover: #c3cff4;
        --link-color-active: #fff;
        --link-color-active-bg: #1f1c2e;
        --projects-section: #fff;
        --message-box-hover: #fafcff;
        --message-box-border: #e9ebf0;
        --more-list-bg: #fff;
        --more-list-bg-hover: #f6fbff;
        --more-list-shadow: rgba(209, 209, 209, 0.4);
        --button-bg: #1f1c24;
        --search-area-bg: #fff;
        --star: #1ff1c2e;
        --message-btn: #fff;
    }

    .dark:root {
        --app-container: #1f1d2b;
        --app-container: #111827;
        --main-color: #fff;
        --secondary-color: rgba(255, 255, 255, 0.8);
        --projects-section: #1f2937;
        --link-color: rgba(255, 255, 255, 0.8);
        --link-color-hover: rgba(195, 207, 244, 0.1);
        --link-color-active-bg: rgba(195, 207, 244, 0.2);
        --button-bg: #1f2937;
        --search-area-bg: #1f2937;
        --message-box-hover: #243244;
        --message-box-border: rgba(255, 255, 255, 0.1);
        --star: #ffd92c;
        --light-font: rgba(255, 255, 255, 0.8);
        --more-list-bg: #2f3142;
        --more-list-bg-hover: rgba(195, 207, 244, 0.1);
        --more-list-shadow: rgba(195, 207, 244, 0.1);
        --message-btn: rgba(195, 207, 244, 0.1);
    }

    html,
    body {
        width: 100%;
        height: 100vh;
        margin: 0;
    }

    body {
        font-family: "DM Sans", sans-serif;
        overflow: hidden;
        
        justify-content: center;
        background-color: var(--app-container);
    }

    button,
    a {
        cursor: pointer;
    }

    .app-container {
        width: 96%;
        margin-left: 4%;
        display: flex;
        flex-direction: column;
        height: 100%;
        background-color: var(--app-container);
        transition: 0.2s;
        max-width: 1800px;
    }

        .app-container button,
        .app-container input,
        .app-container optgroup,
        .app-container select,
        .app-container textarea {
            font-family: "DM Sans", sans-serif;
        }

    .app-content {
        display: flex;
        height: 100%;
        overflow: hidden;
        padding: 16px 24px 24px 0;
    }

    .app-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        padding: 16px 24px;
        position: relative;
    }

    .app-header-left, .app-header-right {
        display: flex;
        align-items: center;
    }

    .app-header-left {
        flex-grow: 1;
    }

    .app-header-right button {
        margin-left: 10px;
    }

    .app-icon {
        width: 26px;
        height: 2px;
        border-radius: 4px;
        background-color: var(--main-color);
        position: relative;
    }

        .app-icon:before, .app-icon:after {
            content: "";
            position: absolute;
            width: 12px;
            height: 2px;
            border-radius: 4px;
            background-color: var(--main-color);
            left: 50%;
            
        }

        .app-icon:before {
            top: -6px;
        }

        .app-icon:after {
            bottom: -6px;
        }

    .app-name {
        color: var(--main-color);
        margin: 0;
        font-size: 20px;
        line-height: 24px;
        font-weight: 700;
        margin: 0 32px;
    }

    .mode-switch {
        background-color: transparent;
        border: none;
        padding: 0;
        color: var(--main-color);
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .search-wrapper {
        border-radius: 20px;
        background-color: var(--search-area-bg);
        padding-right: 12px;
        height: 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        max-width: 480px;
        color: var(--light-font);
        box-shadow: 0 2px 6px 0 rgba(136, 148, 171, 0.2), 0 24px 20px -24px rgba(71, 82, 107, 0.1);
        overflow: hidden;
    }

    .dark .search-wrapper {
        box-shadow: none;
    }

    .search-input {
        border: none;
        flex: 1;
        outline: none;
        height: 100%;
        padding: 0 20px;
        font-size: 16px;
        background-color: var(--search-area-bg);
        color: var(--main-color);
    }

       

    .add-btn {
        color: #fff;
        background-color: var(--button-bg);
        padding: 0;
        border: 0;
        border-radius: 50%;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .notification-btn {
        color: var(--main-color);
        padding: 0;
        border: 0;
        background-color: transparent;
        height: 32px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .profile-btn {
        padding: 0;
        border: 0;
        background-color: transparent;
        display: flex;
        align-items: center;
        padding-left: 12px;
        border-left: 2px solid #ddd;
    }

        .profile-btn img {
            width: 32px;
            height: 32px;
            -o-object-fit: cover;
            object-fit: cover;
            border-radius: 50%;
            margin-right: 4px;
        }

        .profile-btn span {
            color: var(--main-color);
            font-size: 16px;
            line-height: 24px;
            font-weight: 700;
        }

    .page-content {
        flex: 1;
        width: 100%;
    }

    .app-sidebar {
        padding: 40px 16px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .app-sidebar-link {
        color: var(--main-color);
        color: var(--link-color);
        margin: 16px 0;
        transition: 0.2s;
        border-radius: 50%;
        flex-shrink: 0;
        width: 40px;
        height: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

        .app-sidebar-link:hover {
            background-color: var(--link-color-hover);
            color: var(--link-color-active);
        }

        .app-sidebar-link.active {
            background-color: var(--link-color-active-bg);
            color: var(--link-color-active);
        }

    .projects-section {
        flex: 2;
        background-color: var(--projects-section);
        border-radius: 32px;
        padding: 32px 32px 0 32px;
        overflow: hidden;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .projects-section-line {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 32px;
    }

    .projects-section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
        color: var(--main-color);
    }

        .projects-section-header p {
            font-size: 24px;
            line-height: 32px;
            font-weight: 700;
            opacity: 0.9;
            margin: 0;
            color: var(--main-color);
        }

        .projects-section-header .time {
            font-size: 20px;
        }

    .projects-status {
        display: flex;
    }

    .item-status {
        display: flex;
        flex-direction: column;
        margin-right: 16px;
    }

        .item-status:not(:last-child) .status-type:after {
            content: "";
            position: absolute;
            right: 8px;
            top: 50%;
            
            width: 6px;
            height: 6px;
            border-radius: 50%;
            border: 1px solid var(--secondary-color);
        }

    .status-number {
        font-size: 24px;
        line-height: 32px;
        font-weight: 700;
        color: var(--main-color);
    }

    .status-type {
        position: relative;
        padding-right: 24px;
        color: var(--secondary-color);
    }

    .view-actions {
        display: flex;
        align-items: center;
    }

    .view-btn {
        width: 36px;
        height: 36px;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 6px;
        border-radius: 4px;
        background-color: transparent;
        border: none;
        color: var(--main-color);
        margin-left: 8px;
        transition: 0.2s;
    }

        .view-btn.active {
            background-color: var(--link-color-active-bg);
            color: var(--link-color-active);
        }

        .view-btn:not(.active):hover {
            background-color: var(--link-color-hover);
            color: var(--link-color-active);
        }

    .messages-section {
        flex-shrink: 0;
        padding-bottom: 32px;
        background-color: var(--projects-section);
        margin-left: 24px;
        flex: 1;
        width: 100%;
        border-radius: 30px;
        position: relative;
        overflow: auto;
        transition: all 300ms cubic-bezier(0.19, 1, 0.56, 1);
    }

        .messages-section .messages-close {
            position: absolute;
            top: 12px;
            right: 12px;
            z-index: 3;
            border: none;
            background-color: transparent;
            color: var(--main-color);
            display: none;
        }

        .messages-section.show {
            transform: translateX(0);
            opacity: 1;
            margin-left: 0;
        }

        .messages-section .projects-section-header {
            position: sticky;
            top: 0;
            z-index: 1;
            padding: 32px 24px 0 24px;
            background-color: var(--projects-section);
        }

    .message-box {
        border-top: 1px solid var(--message-box-border);
        padding: 16px;
        display: flex;
        align-items: flex-start;
        width: 100%;
    }

        .message-box:hover {
            background-color: var(--message-box-hover);
            border-top-color: var(--link-color-hover);
        }

            .message-box:hover + .message-box {
                border-top-color: var(--link-color-hover);
            }

        .message-box img {
            border-radius: 50%;
            -o-object-fit: cover;
            object-fit: cover;
            width: 40px;
            height: 40px;
        }

    .message-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }

        .message-header .name {
            font-size: 16px;
            line-height: 24px;
            font-weight: 700;
            color: var(--main-color);
            margin: 0;
        }

    .message-content {
        padding-left: 16px;
        width: 100%;
    }

    .star-checkbox input {
        opacity: 0;
        position: absolute;
        width: 0;
        height: 0;
    }

    .star-checkbox label {
        width: 24px;
        height: 24px;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
    }

    .dark .star-checkbox {
        color: var(--secondary-color);
    }

        .dark .star-checkbox input:checked + label {
            color: var(--star);
        }

    .star-checkbox input:checked + label svg {
        fill: var(--star);
        transition: 0.2s;
    }

    .message-line {
        font-size: 14px;
        line-height: 20px;
        margin: 8px 0;
        color: var(--secondary-color);
        opacity: 0.7;
    }

        .message-line.time {
            text-align: right;
            margin-bottom: 0;
        }

    .project-boxes {
        margin: 0 -8px;
        overflow-y: auto;
    }

        .project-boxes.jsGridView {
            display: flex;
            flex-wrap: wrap;
        }

            .project-boxes.jsGridView .project-box-wrapper {
                width: 33.3%;
            }

        .project-boxes.jsListView .project-box {
            display: flex;
            border-radius: 10px;
            position: relative;
        }

            .project-boxes.jsListView .project-box > * {
                margin-right: 24px;
            }

        .project-boxes.jsListView .more-wrapper {
            position: absolute;
            right: 16px;
            top: 16px;
        }

        .project-boxes.jsListView .project-box-content-header {
            order: 1;
            max-width: 120px;
        }

        .project-boxes.jsListView .project-box-header {
            order: 2;
        }

        .project-boxes.jsListView .project-box-footer {
            order: 3;
            padding-top: 0;
            flex-direction: column;
            justify-content: flex-start;
        }

            .project-boxes.jsListView .project-box-footer:after {
                display: none;
            }

        .project-boxes.jsListView .participants {
            margin-bottom: 8px;
        }

        .project-boxes.jsListView .project-box-content-header p {
            text-align: left;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .project-boxes.jsListView .project-box-header > span {
            position: absolute;
            bottom: 16px;
            left: 16px;
            font-size: 12px;
        }

        .project-boxes.jsListView .box-progress-wrapper {
            order: 3;
            flex: 1;
        }

    .project-box {
        --main-color-card: #dbf6fd;
        border-radius: 30px;
        padding: 16px;
        background-color: var(--main-color-card);
    }

    .project-box-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 16px;
        color: var(--main-color);
    }

        .project-box-header span {
            color: #4a4a4a;
            opacity: 0.7;
            font-size: 14px;
            line-height: 16px;
        }

    .project-box-content-header {
        text-align: center;
        margin-bottom: 16px;
    }

        .project-box-content-header p {
            margin: 0;
        }

    .project-box-wrapper {
        padding: 8px;
        transition: 0.2s;
    }

    .project-btn-more {
        padding: 0;
        height: 14px;
        width: 24px;
        height: 24px;
        position: relative;
        background-color: transparent;
        border: none;
        flex-shrink: 0;
        /*&:after, &:before {
        content: '';
        position: absolute;
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background-color: var(--main-color);
        opacity: .8;
        left: 50%;
        transform: translatex(-50%);
      }
    
      &:before { top: 0;}
      &:after { bottom: 0; }*/
    }

    .more-wrapper {
        position: relative;
    }

    .box-content-header {
        font-size: 16px;
        line-height: 24px;
        font-weight: 700;
        opacity: 0.7;
    }

    .box-content-subheader {
        font-size: 14px;
        line-height: 24px;
        opacity: 0.7;
    }

    .box-progress {
        display: block;
        height: 4px;
        border-radius: 6px;
    }

    .box-progress-bar {
        width: 100%;
        height: 4px;
        border-radius: 6px;
        overflow: hidden;
        background-color: #fff;
        margin: 8px 0;
    }

    .box-progress-header {
        font-size: 14px;
        font-weight: 700;
        line-height: 16px;
        margin: 0;
    }

    .box-progress-percentage {
        text-align: right;
        margin: 0;
        font-size: 14px;
        font-weight: 700;
        line-height: 16px;
    }

    .project-box-footer {
        display: flex;
        justify-content: space-between;
        padding-top: 16px;
        position: relative;
        height:41px;
    }

        .project-box-footer:after {
            content: "";
            position: absolute;
            background-color: rgba(255, 255, 255, 0.6);
            width: calc(100% + 32px);
            top: 0;
            left: -16px;
            height: 1px;
        }

    .participants {
        display:flex;
    }

        .participants img {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            overflow: hidden;
            -o-object-fit: cover;
            object-fit: cover;
        }

            .participants img:not(:first-child) {
                margin-left: -8px;
            }

    .add-participant {
        width: 20px;
        height: 20px;
        border-radius: 50%;
        border: none;
        background-color: rgba(255, 255, 255, 0.6);
        margin-left: 6px;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0;
    }

    .days-left {
        background-color: rgba(255, 255, 255, 0.6);
        font-size: 12px;
        border-radius: 20px;
        flex-shrink: 0;
        padding: 6px 16px;
        font-weight: 700;
    }

    .mode-switch.active .moon {
        fill: var(--main-color);
    }

    .messages-btn {
        border-radius: 4px 0 0 4px;
        position: absolute;
        right: 0;
        top: 58px;
        background-color: var(--message-btn);
        border: none;
        color: var(--main-color);
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 4px;
        display: none;
    }

    @media screen and (max-width: 980px) {
        .project-boxes.jsGridView .project-box-wrapper {
            width: 50%;
        }

        .status-number,
        .status-type {
            font-size: 14px;
        }

            .status-type:after {
                width: 4px;
                height: 4px;
            }

        .item-status {
            margin-right: 0;
        }
    }

    @media screen and (max-width: 880px) {
        .messages-section {
            transform: translateX(100%);
            position: absolute;
            opacity: 0;
            top: 0;
            z-index: 2;
            height: 100%;
            width: 100%;
        }

            .messages-section .messages-close {
                display: block;
            }

        .messages-btn {
            display: flex;
        }
    }

    @media screen and (max-width: 720px) {
        .app-name,
        .profile-btn span {
            display: none;
        }

        .add-btn,
        .notification-btn,
        .mode-switch {
            width: 20px;
            height: 20px;
        }

            .add-btn svg,
            .notification-btn svg,
            .mode-switch svg {
                width: 16px;
                height: 16px;
            }

        .app-header-right button {
            margin-left: 4px;
        }
    }

    @media screen and (max-width: 520px) {
        .projects-section {
            overflow: auto;
        }

        .project-boxes {
            overflow-y: visible;
        }

        .app-sidebar,
        .app-icon {
            display: none;
        }

        .app-content {
            padding: 16px 12px 24px 12px;
        }

        .status-number,
        .status-type {
            font-size: 10px;
        }

        .view-btn {
            width: 24px;
            height: 24px;
        }

        .app-header {
            padding: 16px 10px;
        }

        .search-input {
            max-width: 120px;
        }

        .project-boxes.jsGridView .project-box-wrapper {
            width: 100%;
        }

        .projects-section {
            padding: 24px 16px 0 16px;
        }

        .profile-btn img {
            width: 24px;
            height: 24px;
        }

        .app-header {
            padding: 10px;
        }

        .projects-section-header p,
        .projects-section-header .time {
            font-size: 18px;
        }

        .status-type {
            padding-right: 4px;
        }

            .status-type:after {
                display: none;
            }

        .search-input {
            font-size: 14px;
        }

        .messages-btn {
            top: 48px;
        }

        .box-content-header {
            font-size: 12px;
            line-height: 16px;
        }

        .box-content-subheader {
            font-size: 12px;
            line-height: 16px;
        }

        .project-boxes.jsListView .project-box-header > span {
            font-size: 10px;
        }

        .box-progress-header {
            font-size: 12px;
        }

        .box-progress-percentage {
            font-size: 10px;
        }

        .days-left {
            font-size: 8px;
            padding: 6px 6px;
            text-align: center;
        }

        .project-boxes.jsListView .project-box > * {
            margin-right: 10px;
        }

        .project-boxes.jsListView .more-wrapper {
            right: 2px;
            top: 10px;
        }
        
    }
    .LikeDis {
        padding-left: 93%;
    }
    .modal {
        z-index: 9000;
        top: 0px;
        display:none;
    }
    .modal-content {
        background-color: #fefefe;
        margin: 4% auto auto 15%;
        border: 1px solid #888;
        border-radius: 4px;
        width: 70%;
        height: auto;
        box-shadow: 0px 8px 16px 0px rgb(4 4 4 / 61%);
        margin-right: 1%;
        padding: 1%;
        position: absolute;
        z-index: 9000;
    }

    .modal-backdrop {
        position: inherit;
    }

</style>
