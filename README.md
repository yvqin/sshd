# rsync ssh 文件同步服务端 镜像

* port  22 873   

# ENV 环境变量配置 

* ROOT_PASSWORD  root 用户密码  默认 root   
* CRON_TIME	定时时间 */10 * * * *   min hour day month weekday 
* SRC_DIR  需要备份文件目录  默认 /data/
* TARGET_DIR 备份存储目录  默认 /backup
 

