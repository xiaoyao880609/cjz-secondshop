var simpleAlert = function (opts) {
    //设置默认参数
    const opt = {
        "closeAll": false,
        "content": "",
        "buttons": {}
    };
    //合并参数
    const option = $.extend(opt, opts);
    //事件
    const dialog = {};
    const $simpleAlert = $('<div class="simpleAlert">');
    const $shelter = $('<div class="simpleAlertShelter">');
    const $simpleAlertBody = $('<div class="simpleAlertBody">');
    const $simpleAlertBodyClose = $('<img class="simpleAlertBodyClose" src="/cjz/statics/image/logo/close.png" height="10%" width="14%"/>');
    const $simpleAlertBodyContent = $('<p class="simpleAlertBodyContent">' + option.content + '</p>');
    dialog.init = function () {
        $simpleAlertBody.append($simpleAlertBodyClose).append($simpleAlertBodyContent);
        let num = 0;
        let only = false;
        const onlyArr = [];
        for (let i = 0; i < 2; i++) {
            for (const key in option.buttons) {
                switch (i) {
                    case 0:
                        onlyArr.push(key);
                        break;
                    case 1:
                        if (onlyArr.length <= 1) {
                            only = true;
                        } else {
                            only = false;
                        }
                        num++;
                        const $btn = $('<button class="simpleAlertBtn simpleAlertBtn' + num + '">' + key + '</button>');
                        $btn.bind("click", option.buttons[key]);
                        if (only) {
                            $btn.addClass("onlyOne")
                        }
                        $simpleAlertBody.append($btn);
                        break;
                }

            }
        }
        $simpleAlert.append($shelter).append($simpleAlertBody);
        $("body").append($simpleAlert);
        $simpleAlertBody.show().animate({"marginTop":"-128px","opacity":"1"},300);
    }
    //右上角关闭按键事件
    $simpleAlertBodyClose.bind("click", function () {
        option.closeAll=false;
        dialog.close();
    })
    dialog.close = function () {
        if(option.closeAll){
            $(".simpleAlert").remove()
        }else {
            $simpleAlertBody.animate({"marginTop": "-188px", "opacity": "0"}, 200, function () {
                $(".simpleAlert").last().remove()
            });
        }
    }
    dialog.init();
    return dialog;
}