#! /bin/sh

case "$1" in
    start)
        echo "Loading scull driver"
        start-stop-daemon -S -n sculldriver -a /usr/bin/scull_load

        echo "Loading faulty driver"
        start-stop-daemon -S -n faultydriver -a /usr/bin/module_load -- faulty

        echo "Modprobing hello module"
        modprobe hello
        
        echo "Loading AESD char driver"
        start-stop-daemon -S -n aesdchardriver -a /usr/bin/aesdchar_load
        ;;
    stop)
        echo "Unloading scull driver"
        start-stop-daemon -K -n sculldriver -a /usr/bin/scull_unload

        echo "Unloading faulty driver"
        start-stop-daemon -K -n faultydriver -a /usr/bin/module_unload

        echo "Removing hello module"
        rmmod hello
        
        echo "Unloading AESD char driver"
        start-stop-daemon -K -n aesdchardriver -a /usr/bin/aesdchar_unload
        ;;
    *)
        echo "Usage: $0 {start|stop}"
    exit 1
esac

exit 0
