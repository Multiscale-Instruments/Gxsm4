FROM ubuntu:22.04 AS build

RUN apt-get update
RUN apt-get install -y meson cmake libgtk-4-dev libsoup-gnome2.4-dev gsettings-desktop-schemas-dev libglew-dev
RUN apt-get install -y libnetcdf-c++4-dev ncview libnetcdf-dev libnetcdf-cxx-legacy-dev libglm-dev
RUN apt-get install -y libfftw3-dev libgsl-dev libgtksourceview-5-dev python3-dev libpython3-all-dev python3-numpy
RUN apt-get install -y libquicktime-dev
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y libopencv-dev 
RUN apt-get install desktop-file-utils

ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu
RUN ldconfig

# These commands copy your files into the specified directory in the image
# and set that as the working location
WORKDIR /builddir
COPY . .

# This command compiles your app using meson
RUN meson builddir
RUN cd builddir && ninja install
# This command runs your application, comment out this line to compile only
CMD ["gxsm"]

LABEL Name=gxsm4 Version=0.0.1
