#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/jylee/jylee/ROSPlan/src/ROSPlan/rosplan_rqt"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/jylee/jylee/ROSPlan/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/jylee/jylee/ROSPlan/install/lib/python2.7/dist-packages:/home/jylee/jylee/ROSPlan/build/rosplan_rqt/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/jylee/jylee/ROSPlan/build/rosplan_rqt" \
    "/usr/bin/python2" \
    "/home/jylee/jylee/ROSPlan/src/ROSPlan/rosplan_rqt/setup.py" \
     \
    build --build-base "/home/jylee/jylee/ROSPlan/build/rosplan_rqt" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/jylee/jylee/ROSPlan/install" --install-scripts="/home/jylee/jylee/ROSPlan/install/bin"
