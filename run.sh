#!/usr/bin/env bash
set -x

if [ "${SERVER_TYPE}" = "nodemgr" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_nodemgr.xml /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/" /app/prototype/config/regnode.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "center" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_center.xml /app/prototype/config/boot_config.xml
	sed -i "s/GAME_WORLD_ID/${GAME_WORLD_ID}/g; s/NODE_LISTEN_PORT/${NODE_LISTEN_PORT}/; s/CENTER_LISTEN_PORT/${CENTER_LISTEN_PORT}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/REDIS_WORLD_DBNAME/world_db_${GAME_WORLD_ID}/; s/REDIS_WORLD_HOST/${REDIS_WORLD_HOST}/; s/REDIS_WORLD_PORT/${REDIS_WORLD_PORT}/; s/REDIS_GLOBAL_DBNAME/global_db/; s/REDIS_GLOBAL_HOST/${REDIS_GLOBAL_HOST}/; s/REDIS_GLOBAL_PORT/${REDIS_GLOBAL_PORT}/" /app/prototype/config/database.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "logic" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_logic.xml /app/prototype/config/boot_config.xml
	sed -i "s/GAME_WORLD_ID/${GAME_WORLD_ID}/g; s/LOGIC_LISTEN_PORT/${LOGIC_LISTEN_PORT}/; s/GLOBALCOPYMAP_ID/${GLOBALCOPYMAP_ID}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/REDIS_WORLD_DBNAME/world_db_${GAME_WORLD_ID}/; s/REDIS_WORLD_HOST/${REDIS_WORLD_HOST}/; s/REDIS_WORLD_PORT/${REDIS_WORLD_PORT}/; s/REDIS_GLOBAL_DBNAME/global_db/; s/REDIS_GLOBAL_HOST/${REDIS_GLOBAL_HOST}/; s/REDIS_GLOBAL_PORT/${REDIS_GLOBAL_PORT}/" /app/prototype/config/database.xml
	sed -i "s/GMTOOL_SKIP/${GMTOOL_SKIP}/; s/GMTOOL_SERVER_HOST/${GMTOOL_SERVER_HOST}/; s/GMTOOL_SERVER_PORT/${GMTOOL_SERVER_PORT}/" /app/prototype/config/gmtool.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "map" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_map.xml /app/prototype/config/boot_config.xml
	if [ -z ${MAP_ID+x} ]; then
		MAP_ID=$((${HOSTNAME##*-}+1))
	fi
	sed -i "s/GAME_WORLD_ID/${GAME_WORLD_ID}/g; s/MAP_ID/${MAP_ID}/; s/MAP_LISTEN_PORT/${MAP_LISTEN_PORT}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/REDIS_WORLD_DBNAME/world_db_${GAME_WORLD_ID}/; s/REDIS_WORLD_HOST/${REDIS_WORLD_HOST}/; s/REDIS_WORLD_PORT/${REDIS_WORLD_PORT}/" /app/prototype/config/database.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "gate" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_gate.xml /app/prototype/config/boot_config.xml
	sed -i "s/GAME_WORLD_ID/${GAME_WORLD_ID}/g; s/GATE_ID/${GATE_ID}/; s/GATE_PORT/${GATE_PORT}/; s/GLOBALCOPYMAP_ID/${GLOBALCOPYMAP_ID}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "stateless" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_stateless.xml /app/prototype/config/boot_config.xml
	sed -i "s/GAME_WORLD_ID/${GAME_WORLD_ID}/g; s/STATELESS_ID/${STATELESS_ID}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/REDIS_WORLD_DBNAME/world_db_${GAME_WORLD_ID}/; s/REDIS_WORLD_HOST/${REDIS_WORLD_HOST}/; s/REDIS_WORLD_PORT/${REDIS_WORLD_PORT}/" /app/prototype/config/database.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "globalcopymap" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_globalcopymap.xml /app/prototype/config/boot_config.xml
	sed -i "s/<\!--//g; s/-->//g; s/GLOBALCOPYMAP_ID/${GLOBALCOPYMAP_ID}/g; s/NODE_LISTEN_PORT/${NODE_LISTEN_PORT}/; s/GLOBALCOPYMAP_LISTEN_PORT/${GLOBALCOPYMAP_LISTEN_PORT}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/REDIS_WORLD_DBNAME/copymap_db_${GLOBALCOPYMAP_ID}/; s/REDIS_WORLD_HOST/${REDIS_COPYMAP_HOST}/; s/REDIS_WORLD_PORT/${REDIS_COPYMAP_PORT}/" /app/prototype/config/database.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "copymap" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_copymap.xml /app/prototype/config/boot_config.xml
	sed -i "s/GLOBALCOPYMAP_ID/${GLOBALCOPYMAP_ID}/g; s/COPYMAP_ID/${COPYMAP_ID}/; s/COPYMAP_LISTEN_PORT/${COPYMAP_LISTEN_PORT}/" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/${NODE_MGR_PORT}/; s/NODE_MGR_HOST/${NODE_MGR_HOST}/" /app/prototype/config/regnode.xml
	sed -i "s/REDIS_WORLD_DBNAME/copymap_db_${GLOBALCOPYMAP_ID}/; s/REDIS_WORLD_HOST/${REDIS_COPYMAP_HOST}/; s/REDIS_WORLD_PORT/${REDIS_COPYMAP_PORT}/" /app/prototype/config/database.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; s/log_level=\"5\"/log_level=\"3\"/" /app/prototype/config/option.xml
	./nodesolid

elif [ "${SERVER_TYPE}" = "test" ]; then
	cp -Lr /config/* /app/prototype/config
	cp /app/prototype/config/boot_config_test.xml /app/prototype/config/boot_config.xml
	sed -i "s/GAME_WORLD_ID/0/g" /app/prototype/config/boot_config.xml
	sed -i "s/NODE_MGR_PORT/1/" /app/prototype/config/regnode.xml
	sed -i "s/production=\"0\"/production=\"1\"/; s/gm_level=\"0\"/gm_level=\"1\"/; s/log_to_file=\"1\"/log_to_file=\"0\"/; \
		s/log_level=\"5\"/log_level=\"3\"/; s/127.0.0.1/${SERVER_HOST}/; s/10009/${SERVER_PORT}/; \
		s/test_tool_camp_count=\"1\"/test_tool_camp_count=\"${CAMP_COUNT}\"/; \
		s/test_tool_bot_count=\"1\"/test_tool_bot_count=\"${BOT_COUNT}\"/; \
		s/test_tool_bot_interval=\"100\"/test_tool_bot_interval=\"${CREATE_BOT_INTERVAL}\"/; \
		s/test_tool_timeout=\"8000\"/test_tool_timeout=\"${REQUEST_TIMEOUT}\"/; \
		s/test_tool_wait_others=\"0\"/test_tool_wait_others=\"${WAIT_OTHER_BOTS}\"/; \
		s/test_tool_case=\"test_temp\"/test_tool_case=\"${TEST_CASE}\"/; \
		s/test_tool_loop_times=\"1\"/test_tool_loop_times=\"${LOOP_TIMES}\"/; \
		s/test_tool_replica_index=\"1\"/test_tool_replica_index=\"${REPLICA_INDEX}\"/" /app/prototype/config/option.xml
	./nodesolid

else
	echo "Specify SERVER_TYPE please"
fi
