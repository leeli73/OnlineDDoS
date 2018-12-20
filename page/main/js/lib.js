function ping(ip) {
    var img = new Image();
    var start = new Date().getTime();
    var flag = false;
    var isCloseWifi = true;
    var hasFinish = false;
    img.onload = function () {
        if (!hasFinish) {
            flag = true;
            hasFinish = true;
            img.src = 'X:\\';
            console.log('Ping ' + ip + ' success. ');
        }
    };
    img.onerror = function () {
        if (!hasFinish) {
            if (!isCloseWifi) {
                flag = true;
                img.src = 'X:\\';
                console.log('Ping ' + ip + ' success. ');
            } else {
                console.log('network is not working!');
            }
            hasFinish = true;
        }
    };
    setTimeout(function () {
        isCloseWifi = false;
        console.log('network is working, start ping...');
    }, 2);
    img.src = 'http://' + ip + '/' + start;
    var timer = setTimeout(function () {
        if (!flag) {
            hasFinish = true;
            img.src = 'X://';
            flag = false;
            console.log('Ping ' + ip + ' fail. ');
        }
    }, 1500);
}
function get()
{
    
}