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
                <div class="projects-section-header" style="border-bottom:0px">
                    <p>New Ideas</p>
                    
                </div>
                <div class="projects-section-line" style="margin-bottom: -24px !important">
                    <div class="projects-status">
                        <div class="view-actions" style="justify-content: space-between; display: flex;">
                            <div style="width: 100px;">
                                New Ideas <br />
                                <input type="radio" @change="GetAll()"  name="ideasoption" value="New" v-model="radioOption" />
                            </div>
                            <div style="width: 100px;"  v-if="this.UserModel.Position == 'PS02'">
                                Offline <br />
                                <input type="radio" @change="GetAll()" name="ideasoption" value="Offline" v-model="radioOption" />
                            </div>
                            <div style="width: 100px;">
                                Most Viewer <br />
                                <input type="radio" @change="GetAll()" name="ideasoption" value="MostView" v-model="radioOption" />
                            </div>
                            <div style="width: 100px;">
                                Top Like <br />
                                <input type="radio" @change="GetAll()" name="ideasoption" value="TopLike" v-model="radioOption" />
                            </div>
                        </div>
                    </div>
                    <div class="view-actions" v-if="this.UserModel.Position == 'PS02'">
                        <div class="item-status">
                            <span class="status-number">{{this.statistical.IT}}</span>
                            <span >IT</span>
                        </div>
                        <div class="item-status">
                            <span class="status-number">{{this.statistical.CS}}</span>
                            <span >Computer Science </span>
                        </div>
                        <div class="item-status">
                            <span class="status-number">{{this.statistical.Business}}</span>
                            <span >Business</span>
                        </div>
                    </div>
                </div>
                <div class="project-boxes jsGridView">
                    <div class="project-box-wrapper" v-for="(item,index) in ListModel" v-bind:key="index">
                        <div class="project-box" style="background-color: #fee4cb;">
                            <div class="project-box-header" style="margin-bottom: 0px;">
                                <span v-if="item.isOption == true">Ẩn danh</span>
                                <span v-if="item.isOption == false">{{item.CrtName}}</span>
                                <div class="more-wrapper">
                                    <span><i v-if="item.Tag" style="width: 83px; text-align: left; height: 15px; font-size: 15px; color: blue;" class="fa fa-tag">  <span style="margin-left: 5px;">{{item.TagName}}</span></i></span>
                                </div>
                            </div>
                            <button @click="addview(item.IID,item.View_numb)" style="width: 100%; background: transparent; border-color: transparent;">
                                <div class="project-box-content-header">
                                    <p class="box-content-header" >{{item.Title}}</p>
                                    <p class="box-content-subheader" style="display: block; width: 339px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">{{item.Content}}</p>
                                </div>
                                <div class="box-progress-wrapper">
                                    <p class="box-progress-header">{{item.IID}}</p>
                                </div>
                            </button>
                            <div class="project-box-footer">
                                <div class="participants">
                                    <span>{{item.View_numb}}</span><i class="fa fa-eye" style=" width: 34px; font-size: 15px;"></i>
                                    <button style="width: 30px; border: transparent; background-color: transparent;">
                                        <i class="fa fa-thumbs-up" style=" width: 34px; font-size: 15px;padding-bottom: 22px;"></i>
                                    </button>
                                    <span>{{item.LikeNumb}}</span>
                                    <button style="width: 30px; border: transparent; background-color: transparent;">
                                        <i class="fa fa-thumbs-down" style=" width: 34px; font-size: 15px;padding-bottom: 22px;"></i>
                                    </button>
                                    <span>{{item.DisLikeNumb}}</span>

                                </div>
                                <div class="days-left" style="color: #ff942e;">
                                    {{item.Date_Onlinefrm}}
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div id="pagina" style="text-align: right;">
                    <ul class="pagination pagination-sm" style=" display: inline-block; padding-left: 0; margin: 20px 0; border-radius: 4px;">
                        <template v-if="pagination.currentPage>1">
                            <li v-if="pagination.currentPage > pagination.max + 1">
                                <a href="#" @click="loadPage(1)">1</a>
                            </li>
                        </template>
                        <template v-if="start>=3">
                            <li v-if="start==3">
                                <a href="#" @click="loadPage(2)">2</a>
                            </li>
                            <li v-else>
                                <a href="#">...</a>
                            </li>
                        </template>

                        <template v-for="(n,index) in end" v-bind:key="index">
                            <template v-if="n==pagination.currentPage">
                                <li class="active">
                                    <a class="page-link" href="#">{{n}}</a>
                                </li>
                            </template>
                            <template v-else>
                                <li>
                                    <a class="page-link" href="#" @click="loadPage(n)">{{n}}</a>
                                </li>
                            </template>
                        </template>

                        <template v-if="end + 1 < totalPages">
                            <li v-if="end + 2 == totalPages">
                                <a href="#" @click="loadPage(totalPages-1)">{{(totalPages-1)}}</a>
                            </li>
                            <li v-else>
                                <a href="#">...</a>
                            </li>
                        </template>

                        <template v-if="pagination.currentPage< totalPages">
                            <li v-if="pagination.currentPage < totalPages - pagination.max">
                                <a href="#" @click="loadPage(totalPages)">{{totalPages}}</a>
                            </li>
                        </template>
                    </ul>
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
                test: '',
                radioOption: 'New',
                ListModel: [],
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
                    UserLike: '',
                    UserDisLike: '',
                    CrtName: ''

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
                    Position:'',
                },
                statistical: {
                    IT:0,
                    Business:0,
                    CS:0,
                },
                pagination: {
                    currentPage: 1,
                    total: 0,
                    pageSize: 5,
                    max: 3
                }
            }
        },
        methods: {
            
             async getTTDN() {
                let response = await axios.get('/api/User/ttdn');
                if (response) {
                    this.UserModel = response.data;
                }
            },
            async GetAll() {
                this.pagination.pageSize = 5;
                this.pagination.currentPage = 1;
                let response = await axios.get('/api/User/GetAll?PageSize=' + this.pagination.pageSize + "&page=" + this.pagination.currentPage + "&Option=" + this.radioOption);
                if (response) {
                    this.ListModel = response.data.results;
                    this.pagination.total = response.data.total;
                }
            },
            async GetLoadPage() {
                let response = await axios.get('/api/User/GetAll?PageSize=' + this.pagination.pageSize + "&page=" + this.pagination.currentPage + "&Option=" + this.radioOption);
                if (response) {
                    this.ListModel = response.data.results;
                    this.pagination.total = response.data.total;
                }
            },
            async statisticalList() {
                let response = await axios.get('/api/User/statistical');
                if (response) {
                    this.statistical = response.data;
                }
            },
            async addview(iid, view) {
                let response = await axios.get('/api/User/AddViewer?IID=' + iid + '&view=' + view);
                if (response) {
                    window.open('/addnew?IID=' + iid, '_self');
                }
            },
            async loadPage(page) {
                if (page == 0) {
                    page = 1;
                }
                this.pagination.currentPage = page;
                this.GetLoadPage();
            },
        },
       
        async mounted() {
            this.getTTDN();
            this.statisticalList();
            this.GetAll();
            this.loadPage(0);
            
        },
        computed: {
            totalPages: function () {
                return Math.ceil(this.pagination.total / this.pagination.pageSize)
            },
            start() {
                var start = this.pagination.currentPage - this.pagination.max;
                if (start <= 1) {
                    return 1;
                } else {
                    return start;
                }
            },

            end() {
                var end = this.pagination.currentPage + this.pagination.max;
                if (end > this.totalPages) {
                    return this.totalPages;
                } else {
                    return end;
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
        overflow-y:hidden !important;
        
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
        padding-bottom: 15px;
    }

    .projects-section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
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
    #pagina ul {
        list-style-type: none;
        text-align: center;
    }

        #pagina ul li {
            color: black;
            display: inline-block;
            width: 120px;
            height: 24px;
            border-radius: 5px;
            background-color: whitesmoke;
            padding-top: 4px;
            vertical-align: middle;
            width: 51px;
        }
    #pagina a {
        text-decoration: none;
        color: black;
        display: block;
    }

        #pagina a:hover {
            background: #F1F1F1;
            color: #333;
        }
    #pagina .active a {
        z-index: 3;
        color: #fff;
        cursor: default;
        background-color: #337ab7;
        border-color: #337ab7;
        border-radius: 5px;
        height: 24px;
        margin-top: -4px;
        padding-top: 4px;
    }
</style>
