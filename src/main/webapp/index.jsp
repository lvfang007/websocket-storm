<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
    <head>

        <title>吕方的webSocket测试案例</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <link rel="stylesheet" type="text/css" href="./style/numberAnimate_change.css" />
        <link rel="stylesheet" type="text/css" href="./style/buttons.css" />
        <style>
            body {
                background-image: url("./image/20.png");
                background-repeat: no-repeat;
                background-size: 100% 100%;
                height: 100%;
                min-height: 900px;
            }
            .class-box-div-overall{
                text-align:center;
                border-width:1px;
                width: 40%;
                height:85%;
                display: inline-block;
            }
            .class-box-div-out{
                display: inline-block;
                border-style: solid;
                border-width: 0px;
                border-color: #fff;
                border-radius:10px;
                width: 80%;
                height: 20%;
                margin-top: 5px;
            }
            .class-box-div-in{
                float: left;
                margin-left:10px;
                margin-top: 5px;
                color: white;
            }
            #msg{
                outline: 0;
                border: 1px solid #fff;
                box-shadow: 0px 0px 20px 0px #fff;
                height: 35px;
                width: 200px;
            }
            /*input:focus{*/
                /*outline: 0;*/
                /*border: 1px solid #f95d5d;*/
                /*box-shadow: 0px 0px 10px 0px #f95d5d;*/
            /*}*/
        </style>
    </head>
    <%--<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>--%>
    <%--<script src="http://cdn.bootcss.com/jquery/1.8.3/jquery.min.js"></script>--%>
    <script type="text/javascript" src="./script/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="./script/numberAnimate.js"></script>
    <script type="text/javascript">

        var dv1num = Number(0);
        var dv2num = Number(0);
        var dv3num = Number(0);
        var dv4num = Number(0);
        var dv1,dv2,dv3,dv4;
        var ws;//一个websocket对象就是一个同学管道
        var target="WS://localhost:8080/websocket-storm/echo";
        function subOpen(){
            //alert(target);
            if("WebSocket" in window){
                ws = new WebSocket(target);//target表示你要链接的websocket管道（EndPoint）
            }else if("MozWebSocket" in window) {
                ws = new MozWebSocket(target);
            }else{
                alert("no supported WebSocket !!");
                return;
            }
            ws.onopen=function(){
                console.info("webSocket通道建立成功！！！");
                alert("webSocket通道建立成功！！！");
            };

            ws.onmessage=function(event){
                var dv = document.getElementById("dv");
                var dv1 = document.getElementById("dv1");
                var dv2 = document.getElementById("dv2");
                var dv3 = document.getElementById("dv3");
                var dv4 = document.getElementById("dv4");
                dv.innerHTML="接收到消息：{"+event.data+"}";
                var arrData = event.data.split(",");
                if(arrData.length == 4){

//                    dv1.innerHTML= "  优惠前总价（单位/元）: ";
                    if(dv1num!=Number(arrData[0])){
                        if(Number(arrData[0]>0)){
                            test1(Number(arrData[0])-dv1num);//新值
                        }
                    }
//                    dv2.innerHTML= "  优惠后总价（单位/元）: ";
                    if(dv2num!=Number(arrData[1])){
                        if(Number(arrData[1]>0)){
                            test2(Number(arrData[1])-dv2num);//新值
                        }
                    }
//                    dv3.innerHTML= "  活动用户数（单位/个）: ";
                    if(dv3num!=Number(arrData[2])){
                        if(Number(arrData[2]>0)){
                            test3(Number(arrData[2])-dv3num);//新值
                        }
                    }
//                    dv4.innerHTML= "  活动订单数（单位/单）: ";
                    if(dv4num!=Number(arrData[3])){
                        if(Number(arrData[3]>0)){
                            test4(Number(arrData[3])-dv4num);//新值
                        }
                    }

                }
            };
        }

        $(function() {
            dv1 = $(".numberRun1").numberAnimate({num: 10000, dot: 2, speed: 500, symbol: ","});
            dv2 = $(".numberRun2").numberAnimate({num: 1000, dot: 2, speed: 500, symbol: ","});
            dv3 = $(".numberRun3").numberAnimate({num: 100, dot: 0, speed: 500, symbol: ","});
            dv4 = $(".numberRun4").numberAnimate({num: 10, dot: 0, speed: 500, symbol: ","});
        })

        function test1(val) {
            dv1num = dv1num + val;
            dv1.resetData(dv1num);
        }
        function test2(val) {
            dv2num = dv2num + val;
            dv2.resetData(dv2num);
        }
        function test3(val) {
            dv3num = dv3num + val;
            dv3.resetData(dv3num);
        }
        function test4(val) {
            dv4num = dv4num + val;
            dv4.resetData(dv4num);
        }

        function ws_send(){
            var msg = document.getElementById("msg");

            if(ws == undefined) alert("请先打开链接再进行发送！");
            ws.send(msg.value);
            msg.value="";
        }

        function ws_close(){
            alert("socket通道关闭！")
            ws.close();
        }
    </script>
    <body>

        <br><br>
        <div style="margin:0 auto;text-align:center;">
            <button type="button" class="button button-raised button-primary button-pill" onclick="subOpen()">打开webSocket链接</button>&nbsp;&nbsp;
            <input id="msg" placeholder="请输入口令！" />&nbsp;&nbsp;
            <button class="button button-raised button-primary button-pill"  onclick="ws_send();">send</button>
            <button class="button button-raised button-pill button-inverse"  onclick="ws_close();">close</button>
        </div>
        <br><br>
        <div style="margin:0 auto;text-align:center;">
            <div class="class-box-div-overall">
                <div id="dv" class="button button-uppercase button-primary" style="margin-top: 5px;font-size: 20px;">链接未打开，暂无数据！</div>
                <br><br>
                <div class="class-box-div-out" style="background-color: #cc9933;">
                    <div id="dv1" class="class-box-div-in">
                        优惠前总价（单位/元）
                    </div><br><br>
                    <div class="numberRun1"></div><br><br>
                </div>

                <div class="class-box-div-out" style="background-color: #ff6699;">
                    <div id="dv2" class="class-box-div-in">
                        优惠后总价（单位/元）
                    </div><br><br>
                    <div class="numberRun2"></div><br><br>
                </div>

                <div class="class-box-div-out" style="background-color: #339999;">
                    <div id="dv3" class="class-box-div-in" >
                        活动用户数（单位/个）
                    </div><br><br>
                    <div class="numberRun3"></div><br><br>
                </div>

                <div class="class-box-div-out" style="background-color: #99cc33;">
                    <div id="dv4" class="class-box-div-in">
                        活动订单数（单位/单）
                    </div><br><br>
                    <div class="numberRun4"></div>
                </div>
            </div>
        </div>
    </body>
</html>

