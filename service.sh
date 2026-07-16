#!/system/bin/sh

MODDIR=${0%/*}

LAST_RUN=""

while true
do

    DATE=$(date +%Y%m%d)
    HOUR=$(date +%H)
    MIN=$(date +%M)

    NOW="$DATE-$HOUR:$MIN"


    # 上午09:29 下午18:30执行
    if { [ "$HOUR" = "09" ] && [ "$MIN" = "29" ]; } || \
       { [ "$HOUR" = "17" ] && [ "$MIN" = "18" ]; }; then


        if [ "$LAST_RUN" != "$NOW" ]; then

            LAST_RUN="$NOW"


            echo "$(date) 开始执行" >> /sdcard/dingding.log


            # 点亮屏幕
            input keyevent 224
            sleep 2


            # 滑动解锁
            input swipe 500 1800 500 300
            sleep 2


            # 输入密码
            input text 9999
            input keyevent 66
            sleep 5


            # 启动钉钉
            am start -n com.alibaba.android.rimet/.biz.LaunchHomeActivity
            sleep 12


            # 工作台
            input tap 615 3050
            sleep 5


            # 考勤打卡
            input tap 200 1800
            sleep 10


            # 打卡按钮
            input tap 720 1900
            sleep 5


            echo "$(date) 执行完成" >> /sdcard/dingding.log


            sleep 60

        fi

    fi


    sleep 10

done