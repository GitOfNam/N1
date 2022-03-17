<template>
    <div>
        <div class="Loading">
            <section id="global">
                <div id="top" class="mask">
                    <div class="plane"></div>
                </div>
                <div id="middle" class="mask">
                    <div class="plane"></div>
                </div>

                <div id="bottom" class="mask">
                    <div class="plane"></div>
                </div>

                <p style="color: black; font-weight: bolder; font-size: 15px;"><i>LOADING...</i></p>
            </section>
        </div>
    </div>
</template>


<script>
    export default {
        components: {
        },
        data() {
            return {
            }
        },
        methods: {
          
        },
        async mounted() {
        }
    }
</script>

<style scoped>

    .Loading {
        width: 100%;
        height: 100%;
        padding-top: 10%;
        padding-bottom: 10%;
        position: fixed;
        z-index: 9999;
    }

    #global {
        width: 70px;
        margin-top: 150px;
        margin-left: 45%;
        position: relative;
        cursor: pointer;
        height: 60px;
    }

    .mask {
        position: absolute;
        border-radius: 2px;
        overflow: hidden;
        
        backface-visibility: hidden;
    }

    .plane {
        background: #ffffff;
        width: 400%;
        height: 100%;
        position: absolute;
        transform: translate3d(0px,0,0);
        z-index: 100;
        
        backface-visibility: hidden;
    }

    .animation {
        transition: all 0.3s ease;
    }



    #top .plane {
        background-color: black;
        z-index: 2000;
        animation: trans1 1.3s ease-in infinite 0s backwards;
    }

    #middle .plane {
        transform: translate3d(0px,0,0);
        background: #bbbbbb;
        animation: trans2 1.3s linear infinite 0.3s backwards;
    }

    #bottom .plane {
        background-color: black;
        z-index: 2000;
        animation: trans3 1.3s ease-out infinite 0.7s backwards;
    }



    #top {
        width: 53px;
        height: 20px;
        left: 20px;
        transform: skew(-15deg, 0);
        z-index: 100;
    }

    #middle {
        width: 33px;
        height: 20px;
        left: 20px;
        top: 15px;
        transform: skew(-15deg, 40deg)
    }

    #bottom {
        width: 53px;
        height: 20px;
        top: 30px;
        transform: skew(-15deg, 0)
    }

    p {
        color: #fff;
        position: absolute;
        left: -3px;
        top: 45px;
        font-family: Arial;
        text-align: center;
        font-size: 10px;
    }

    @keyframes trans1 {
        from {
            transform: translate3d(53px,0,0)
        }

        to {
            transform: translate3d(-250px,0,0)
        }
    }

    @keyframes trans2 {
        from {
            transform: translate3d(-160px,0,0)
        }

        to {
            transform: translate3d(53px,0,0)
        }
    }

    @keyframes trans3 {
        from {
            transform: translate3d(53px,0,0)
        }

        to {
            transform: translate3d(-220px,0,0)
        }
    }

    @keyframes animColor {
        from {
            background: red;
        }

        25% {
            background: yellow;
        }

        50% {
            background: green;
        }

        75% {
            background: brown;
        }

        to {
            background: blue;
        }
    }
</style>
