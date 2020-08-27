echo "remove library"
rm -rf paho.mqtt.c cJSON

echo "giai nen library"
tar -zxvf cJSON_C.tar.gz
tar -zxvf mqtt_client_paho.tar.gz
echo "remove release"

rm -rf release

mkdir release

cur_dir=$(pwd)

echo "Clean Up lib"

rm -rf ${cur_dir}/mqtt_client/include_mqtt/*
rm -rf ${cur_dir}/mqtt_client/lib_mqtt/*

#Build libray cJSON#
echo "Build_cJSON"
cd ${cur_dir}/cJSON
make clean
cmake .
make
cp *.h ${cur_dir}/mqtt_client/include_mqtt
cp *.so ${cur_dir}/mqtt_client/lib_mqtt
#************************#

#Build library MQTT#
echo "Cmake_mqtt"

cd ${cur_dir}/paho.mqtt.c

make clean
cmake .
echo "Rebuild lib"

cd ${cur_dir}/paho.mqtt.c/src

make clean
make
cp *.h ${cur_dir}/mqtt_client/include_mqtt
cp *.so ${cur_dir}/mqtt_client/lib_mqtt
#************************#

echo "Build application"

cd ${cur_dir}/mqtt_client/source_mqtt

make clean
make

cp run_sub ${cur_dir}/release

cd ${cur_dir}/mqtt_client

cp -r lib_mqtt ${cur_dir}/release

echo "end"

