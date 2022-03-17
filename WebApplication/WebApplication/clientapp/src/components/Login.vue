<template>
    <div class="login-wrap">
        <div style="float: left; height: 100%; width: 65%; position: inherit;">
            <img src="../assets/bg_login.jpg" style="background-repeat: no-repeat; width: 100%; height: 645px;" />
        </div>
        <div class="login-html">
            <input id="tab-1" type="radio" name="tab" class="sign-in" style="white-space: nowrap;" @click="OpenSign()" checked><label for="tab-1" class="tab">Đăng nhập</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up" style="white-space: nowrap" @click="OpenRegister()"><label for="tab-2" class="tab">Đăng ký</label>
            <div class="login-form">
                <div class="sign-in-htm">
                    <div class="group" style="padding-top: 60px;">
                        <label for="user" style="text-align: left; padding-left: 20px;" class="label">Tài khoản</label>
                        <input id="user" type="text" v-on:keyup.enter="LoginUser" class="input" v-model="UserName">
                    </div>
                    <div class="group">
                        <label for="pass" style="text-align: left; padding-left: 20px;" class="label">Mật khẩu</label>
                        <input id="pass" type="password" v-on:keyup.enter="LoginUser" class="input" data-type="password" v-model="Password">
                    </div>
                    <div>
                        <p v-if="this.isLogin == false" style="color: red; font-weight: bold">Tài khoản hoặc mật khẩu không chính xác.</p>
                    </div>
                    <div class="group">
                    </div>
                    <div class="group" style="margin-top: 25px;">
                        <input id="check" type="checkbox" class="check" checked>
                        <label for="check" style="color: white; font-weight: bold;"><span class="icon"></span> Lưu tài khoản</label>
                    </div>
                    <div class="group" style="margin-top: 20px;">
                        <input type="submit" @click="LoginUser" class="button" value="Đăng nhập">
                    </div>
                    <div class="hr" style="margin: 110px 0 50px 0;"></div>
                    <div class="foot-lnk">
                        <label @click="openForm" style="color: white">Quên mật khẩu ?</label>
                    </div>
                </div>
                <div class="sign-up-htm">
                    <div class="group" style="padding-top: 10px;">
                        <label for="user" style="text-align: left; padding-left: 20px;" class="label">Tài khoản <span style="color: red; font-weight: bold"> (*)</span><span v-if="this.isCkeckUserName == true" style="color: red; font-weight: bold; padding-left: 10px">đã tồn tại.</span></label>
                        <input id="user" type="text" @change="CheckUserName" v-model="user.UserName" class="input">
                    </div>
                    <div class="group">
                        <label for="pass" style="text-align: left; padding-left: 20px;" class="label">Mật khẩu<span style="color: red; font-weight: bold"> (*)</span></label>
                        <input id="pass" type="password" class="input" @change="CheckRePassword" v-model="user.Password" data-type="password">
                    </div>
                    <div class="group">
                        <label for="pass" style="text-align: left; padding-left: 20px;" class="label">Nhập lại mật khẩu<span style="color: red; font-weight: bold"> (*)</span><span v-if="this.isCheckRePassword == true" style="color: red; font-weight: bold; padding-left: 10px">không khớp.</span></label>
                        <input id="pass" type="password" class="input" @change="CheckRePassword" v-model="user.RePassword" data-type="password">
                    </div>
                    <div class="group">
                        <label for="pass" style="text-align: left; padding-left: 20px;" class="label">Email<span style="color: red; font-weight: bold"> (*)</span><span v-if="this.isCkeckEmail == true" style="color: red; font-weight: bold; padding-left: 10px">đã tồn tại.</span></label>
                        <input id="pass" type="email" @change="CheckEmail" v-model="user.Email" class="input">
                    </div>
                    <div class="group" style="margin-top: 30px;">
                        <input type="submit" @click="register" class="button" value="Đăng ký">
                    </div>
                    <div class="hr"></div>
                    <div class="foot-lnk">
                        <label for="tab-1" style="color: white">Đã có tài khoản ?</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-popup" id="myForm" style="width: 35%">
            <div class="form-container">
                <h1>Quên mật khẩu ?</h1>
                <label for="email" style="display: -webkit-box; margin-left: 2%;"><b>Lấy lại mật khẩu qua Email.</b></label>
                <input type="text" placeholder="Enter Email" style="width: 75%" v-on:keyup.enter="CheckEmailSQL()" v-model="sendEmail" name="email" required />
                <button type="submit" @click="CheckEmailSQL()" style="width:auto" class="btn">Gửi Mail</button>
                <label v-if="this.isUserNameNull == true" for="email" style="display: -webkit-box; margin-left: 2%; margin-bottom: 3%;"><b style="color: red">Email không tồn tại trong hệ thống vui lòng kiểm tra lại.</b></label>
                <label v-if="this.isShowUser != '' && this.isShowUser != null" for="email" style="display: -webkit-box; margin-left: 2%; margin-bottom: 3%;"><b>Tài khoản: {{isShowUser}}</b></label>
                <label for="email" style="display: -webkit-box; margin-left: 2%;"><b>Nhập mã gồm 6 kí tự.</b></label>
                <input type="text" style="width: 75%" v-on:keyup.enter="CheckKeyValidateUser()" v-model="keyValidate" name="email" required />
                <button type="submit" style="width:auto" @click="CheckKeyValidateUser()" class="btn">Xác nhận</button>
                <button type="button" class="btn cancel" @click="closeForm()">Đóng</button>
            </div>
        </div>

        <!-- Form đổi Password -->
        <div class="form-popup" id="myFormResetPW" style="width: 35%">
            <div class="form-container">
                <h1>Thay đổi mật khẩu ?</h1>
                <label for="email" style="display: -webkit-box; margin-left: 2%;"><b>Mật khẩu mới.</b></label>
                <input type="text" style="width: 100%" @change="CheckPasswordReset()" v-model="PasswordReset" name="email" required />
                <label for="email" style="display: -webkit-box; margin-left: 2%;"><b>Nhập lại mật khẩu.</b></label>
                <input type="text" style="width: 100%" v-on:keyup.enter="ResetPassword()" v-model="isPasswordReset" name="email" required />
                <button type="button" class="btn" @click="ResetPassword()">Xác nhận</button>
                <button type="button" class="btn cancel" @click="closeFormResetPass()">Đóng</button>
            </div>
        </div>
        <loading v-if="this.isShowLoading == true"></loading>
    </div>
</template>


<script>
    import axios from 'axios';
    import loading from '../components/Loading.vue';
    import Swal from 'sweetalert2'
    export default {
        components: {
            loading
        },
        data() {
            return {
                UserName: '',
                Password: '',
                PasswordReset: '',
                isPasswordReset: '',
                isShowUser: '',
                keyValidate: '',
                isLogin: true,
                isCkeckUserName: false,
                isCkeckEmail: false,
                isCheckRePassword: false,
                isUserNameNull: false,
                isShowLoading: false,
                user: {
                    UserName: '',
                    Password: '',
                    RePassword: '',
                    Email: '',
                },
                sendEmail: '',
            }
        },
        methods: {
            async CheckPasswordReset() {
                if (this.PasswordReset == "") {
                    this.isWarning("Bạn chưa nhập mật khẩu.\nVui lòng kiểm tra lại.");
                    return;
                }
            },
            async openForm() {
                document.getElementById("myForm").style.display = "block";
            },
            async closeForm() {
                document.getElementById("myForm").style.display = "none";
                if (this.isShowUser.trim() != null && this.isShowUser.trim() != "" && this.sendEmail.trim() != "") {
                    await axios.post('/api/User/resetKeyValidate?UserName=' + this.isShowUser.trim() + "&Email=" + this.sendEmail.trim())
                }
                window.location = "http://localhost:33171/Login";
            },
            OpenSign() {
                this.user.UserName = "";
                this.user.Password = "";
                this.user.RePassword = "";
                this.user.Email = "";
            },
            async OpenRegister() {
                this.UserName = "";
                this.Password = "";
                document.getElementById("myForm").style.display = "none";
                document.getElementById("myFormResetPW").style.display = "none";
            },
            async closeFormResetPass() {
                document.getElementById("myFormResetPW").style.display = "none";
                if (this.isShowUser.trim() != null && this.isShowUser.trim() != "" && this.sendEmail.trim() != "") {
                    await axios.post('/api/User/resetKeyValidate?UserName=' + this.isShowUser.trim() + "&Email=" + this.sendEmail.trim())
                }
                window.location = "http://localhost:33171/Login";
            },
            async CheckEmailSQL() {
                if (this.sendEmail.trim() == "") {
                    this.isWarning("Bạn chưa nhập Email.\nVui lòng kiểm tra lại.");
                    return;
                }
                this.isShowLoading = true;
                await axios.get('/api/User/CheckEmailSQL?Email=' + this.sendEmail.trim()).then(res => {
                    if (res.data) {
                        if (res.data.rs == 1) {
                            this.isSuccess(res.data.result.msg);
                            this.isShowUser = res.data.result.UserName;
                            this.isShowLoading = false;
                            this.SendMailAuto(this.sendEmail.trim());
                        }
                        else {
                            this.isWarning(res.data.result.msg);
                            this.isShowUser = null;
                        }
                    }
                })
                .catch(function (error) {
                    this.isFalse(error);
                })
                this.isShowLoading = false;
            },
            async SendMailAuto(Email) {
                if (this.isShowUser != null && this.isShowUser != "") {
                    await axios.post('/api/User/SendMailAuto?Email=' + Email)
                    .catch(function (error) {
                        this.isFalse(error);
                    })
                }
            },
            async CheckKeyValidateUser() {
                if (this.isShowUser == null) {
                    this.isWarning("Chưa có tài khoản này được đăng ký bởi Email: " + this.sendEmail + ".\nVui lòng kiểm tra lại");
                    return;
                }
                if (this.keyValidate == "" || this.keyValidate == null) {
                    this.isWarning("Bạn chưa có nhập mã xác nhận.\nVui lòng kiểm tra lại.");
                    return;
                }
                this.isShowLoading = true;
                if (this.isShowUser != "" && this.isShowUser != null) {
                    await axios.get('/api/User/CheckKeyValidateUser?UserName=' + this.isShowUser + "&keyValidate=" + this.keyValidate).then(res => {
                        if (res.data == true) {
                            document.getElementById("myForm").style.display = "none";
                            document.getElementById("myFormResetPW").style.display = "block";
                        }
                        else {
                            this.isWarning("Mã xác nhận không chính xác.\nVui lòng kiểm tra lại");
                            return;
                        }
                    })
                    .catch(function (error) {
                        this.isFalse(error);
                    })
                }
                this.isShowLoading = false;
            },
            async ResetPassword() {
                if (this.PasswordReset == "" || this.isPasswordReset == "") {
                    this.isWarning("Bạn chưa nhập mật khẩu. Vui lòng kiểm tra lại");
                    return;
                }
                if (this.PasswordReset != this.isPasswordReset) {
                    this.isWarning("Mật khẩu không khớp. Vui lòng kiểm tra lại");
                    return;
                }
                this.isCheckRePassword = true;
                if (this.keyValidate != "" && this.PasswordReset != "" && this.isShowUser != "") {
                    await axios.get('/api/User/resetPassword?KeyValidate=' + this.keyValidate + "&Password=" + this.PasswordReset + "&UserName=" + this.isShowUser).then(res => {
                        if (res) {
                            if (res.data == true) {
                                this.isSuccess("Đổi mật khẩu thành công.");
                            }
                        }
                    })
                    .catch(function (error) {
                        this.isFalse(error);
                    })
                }
                this.isCheckRePassword = false;
                window.location = "http://localhost:33171/Login";
            },
            async LoginUser() {
                if (this.UserName.trim() == '') {
                    this.isWarning("Bạn chưa nhập Tài khoản. Vui lòng kiểm tra lại.");
                    return;
                }
                if (this.Password.trim() == '') {
                    this.isWarning("Bạn chưa nhập Mật khẩu. Vui lòng kiểm tra lại.");
                    return;
                }
                if (this.UserName.includes(" ")) {
                    this.isWarning("Tên đăng nhập không chứa khoảng trắng.\nVui lòng kiểm tra lại.");
                    return;
                }
                await axios.get('/api/User/LoginUser?UserName=' + this.UserName + "&Password=" + this.Password).then(res => {
                    if (res) {
                        if (res.data == true) {
                            window.location = "http://localhost:33171";
                        }
                        else {
                            this.isLogin = res.data;
                        }
                    }
                })
                .catch(function (error) {
                    this.isFalse(error);
                })
            },
            async CheckEmail() {
                if (this.user.Email != "") {
                    await axios.get('/api/User/CheckEmail?Email=' + this.user.Email).then(res => {
                        if (res.data == true) {
                            this.isCkeckEmail = res.data;
                        }
                        else {
                            this.isCkeckEmail = res.data;
                        }
                    })
                    .catch(function (error) {
                        this.isFalse(error);
                    })
                }
            },
            async CheckUserName() {
                if (this.user.UserName != "") {
                    await axios.get('/api/User/CheckUserName?UserName=' + this.user.UserName).then(res => {
                        if (res.data == true) {
                            this.isCkeckUserName = res.data;
                        }
                        else {
                            this.isCkeckUserName = res.data;
                        }
                    })
                    .catch(function (error) {
                        this.isFalse(error);
                    })
                }
            },

            async CheckRePassword() {
                if (this.user.RePassword != "") {
                    if (this.user.Password != this.user.RePassword) {
                        this.isCheckRePassword = true;
                    }
                    else {
                        this.isCheckRePassword = false;
                    }
                }
                else {
                    this.isCheckRePassword = false;
                }
            },
            async register() {
                if (this.user.UserName.includes(" ")) {
                    this.isWarning("Tên đăng nhập không chứa khoảng trắng.\nVui lòng kiểm tra lại.");
                    return;
                }
                if (this.isCkeckUserName == true) {
                    this.isWarning("Tên tài khoản đã tồn tại, vui lòng chọn tên khác.");
                    return;
                }
                if (this.user.UserName == "") {
                    this.isWarning("Vui lòng nhập tài khoản.");
                    return;
                }
                if (this.user.Password == "" || this.user.RePassword == "") {
                    this.isWarning("Vui lòng nhập mật khẩu.");
                    return;
                }
                if (this.user.Password != this.user.RePassword) {
                    this.isWarning("Vui lòng kiểm tra lại mật khẩu.");
                    return;
                }
                if (this.user.Email == "") {
                    this.isWarning("Vui lòng nhập Email.");
                    return;
                }
                if (this.isCkeckEmail == true) {
                    this.isWarning("Email đã tồn tại, vui lòng chọn Email khác.");
                    return;
                }
                var data = {
                    UserModel: this.user
                };
                await axios.post('/api/User/register', data).then(res => {
                    if (res.data) {
                        if (res.data.result) {
                            this.isSuccess(res.data.result.msg);
                        }
                    }
                })
                    .catch(function (error) {
                        this.isFalse("Đăng ký tài khoản thất bại.\n"+ error);
                    })
            },
            async isFalse(body) {
                await Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: body,
                    showConfirmButton: false,
                    timer: 2500
                })
            },
            async isSuccess(body) {
                await Swal.fire({
                    position: 'center',
                    title: 'Thông báo!',
                    icon: 'success',
                    text: body,
                    showConfirmButton: false,
                    timer: 5000
                })
            },
            async isWarning(body) {
                Swal.fire({
                    position: 'top',
                    title: 'Thông báo!',
                    text: body,
                    icon: 'warning',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Đóng'
                })
            },
        },
        async mounted() {
        }
    }
</script>

<style scoped>
    body {
        margin: 0 !important;
        color: #6a6f8c;
        background: #c8c8c8;
        font: 600 16px/18px 'Open Sans',sans-serif;
    }

    *, :after, :before {
        box-sizing: border-box
    }

    .clearfix:after, .clearfix:before {
        content: '';
        display: table
    }

    .clearfix:after {
        clear: both;
        display: block
    }

    a {
        color: inherit;
        text-decoration: none
    }

    .login-wrap {
        width: 100%;
        margin: auto;
        height: 100%;
    }

    .login-html {
        width: 35%;
        height: 645px;
        position: inherit;
        float: left;
        padding: 50px 20px 50px 20px;
        background: rgba(40,57,101,.9);
    }

        .login-html .sign-in-htm,
        .login-html .sign-up-htm {
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            position: absolute;
            transform: rotateY(180deg);
            backface-visibility: hidden;
            transition: all .4s linear;
        }

        .login-html .sign-in,
        .login-html .sign-up,
        .login-form .group .check {
            display: none;
        }

        .login-html .tab,
        .login-form .group .label,
        .login-form .group .button {
            text-transform: uppercase;
        }

        .login-html .tab {
            font-size: 22px;
            margin-right: 15px;
            padding-bottom: 5px;
            color: white;
            margin: 0 15px 10px 0;
            display: inline-block;
            border-bottom: 2px solid transparent;
        }

        .login-html .sign-in:checked + .tab,
        .login-html .sign-up:checked + .tab {
            color: red;
            border-color: #1161ee;
        }

    .login-form {
        min-height: 345px;
        position: relative;
        perspective: 1000px;
        transform-style: preserve-3d;
    }

        .login-form .group {
            margin-bottom: 15px;
            width: 75%;
            margin-left: 15%;
        }

            .login-form .group .label,
            .login-form .group .input,
            .login-form .group .button {
                width: 100%;
                color: #fff;
                display: block;
                margin-top: 10px;
            }

            .login-form .group .input,
            .login-form .group .button {
                border: none;
                padding: 15px 20px;
                border-radius: 25px;
                background: rgba(255,255,255,.1);
            }

            .login-form .group input[data-type="password"] {
                text-security: circle;
                -webkit-text-security: circle;
            }

            .login-form .group .label {
                color: #aaa;
                font-size: 12px;
            }

            .login-form .group .button {
                background: #1161ee;
            }

            .login-form .group label .icon {
                width: 15px;
                height: 15px;
                border-radius: 2px;
                position: relative;
                display: inline-block;
                background: rgba(255,255,255,.1);
            }

                .login-form .group label .icon:before,
                .login-form .group label .icon:after {
                    content: '';
                    width: 10px;
                    height: 2px;
                    background: #fff;
                    position: absolute;
                    transition: all .2s ease-in-out 0s;
                }

                .login-form .group label .icon:before {
                    left: 3px;
                    width: 5px;
                    bottom: 6px;
                    transform: scale(0) rotate(0);
                }

                .login-form .group label .icon:after {
                    top: 6px;
                    right: 0;
                    transform: scale(0) rotate(0);
                }

            .login-form .group .check:checked + label {
            }

                .login-form .group .check:checked + label .icon {
                    background: #1161ee;
                }

                    .login-form .group .check:checked + label .icon:before {
                        transform: scale(1) rotate(45deg);
                    }

                    .login-form .group .check:checked + label .icon:after {
                        transform: scale(1) rotate(-45deg);
                    }

    .login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm {
        transform: rotate(0);
    }

    .login-html .sign-up:checked + .tab + .login-form .sign-up-htm {
        transform: rotate(0);
    }

    .hr {
        height: 2px;
        margin: 30px 0 50px 0;
        background: rgba(255,255,255,.2);
    }

    .foot-lnk {
        text-align: center;
    }

    /* Button used to open the contact form - fixed at the bottom of the page */
    .open-button {
        background-color: #555;
        color: white;
        padding: 16px 20px;
        border: none;
        cursor: pointer;
        opacity: 0.8;
        position: fixed;
        bottom: 23px;
        right: 28px;
        width: 280px;
    }

    /* The popup form - hidden by default */
    .form-popup {
        display: none;
        position: fixed;
        bottom: 0;
        right: 15px;
        border: 3px solid #f1f1f1;
        z-index: 9;
        inset: auto;
        margin-left: 30%;
        margin-top: 10%;
    }

    /* Add styles to the form container */
    .form-container {
        max-width: 500px;
        position: initial;
        padding: 10px;
        background-color: white;
    }

        /* Full-width input fields */
        .form-container input[type=text], .form-container input[type=password] {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            border: none;
            background: #f1f1f1;
        }

            /* When the inputs get focus, do something */
            .form-container input[type=text]:focus, .form-container input[type=password]:focus {
                background-color: #ddd;
                outline: none;
            }

        /* Set a style for the submit/login button */
        .form-container .btn {
            background-color: #04AA6D;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 10px;
            opacity: 0.8;
        }

        /* Add a red background color to the cancel button */
        .form-container .cancel {
            background-color: red;
        }

        /* Add some hover effects to buttons */
        .form-container .btn:hover, .open-button:hover {
            opacity: 1;
        }

    .swal2-title {
        font-size: 20px !important;
    }
</style>
