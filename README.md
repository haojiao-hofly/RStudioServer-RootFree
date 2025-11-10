## RStudioServer-RootFree
Deploying RStudio Server using Singularity without root privileges.  
使用singularity部署Rstudio Server（无需root权限）。  

##   

  
## 使用方式-中文   
 - 免超级管理员权限配置Rstudio server单人版（4.2）  
 - 部署工具：singularity  
 - 管理工具：micromamba  

1. 拉取项目 (必须使用lfs拉取镜像文件)
`git clone https://github.com/haojiao-hofly/RStudioServer-RootFree.git`  
`cd RStudioServer-RootFree`  
`git lfs pull`  
  
 2. 创建并进入工作目录，如  
`mkdir workdir && cd  workdir`    
  
 3. 拷贝配置文件，修改密码（password文件），添加singularity系统路径    
`cp  -r /path/to/project/RstudioServer/*  ./  `    
`vi password  `    
`export PATH=$PATH:/usr/local/bin  `    
    
 4. 修改/path/to/project/RstudioServer/run_RstudioServer.sh中的相关参数  
`vi /path/to/project/RstudioServer/run_RstudioServer.sh`  
    
 5. 修改/path/to/project/run_singularity.sh文件的singularity命令，绑定重要目录  
`vi /path/to/project/run_singularity.sh`    
  
 6. 启动Rstudio server，run_RstudioServer.sh脚本接收一个参数指定R虚拟环境的名称    
`sh run_RstudioServer.sh R_env_name`    
    
## usage-EN   
 - Configuring RStudio Server Single-User Version (4.2) Without Superuser Privileges  
 - Deployment Tool: singularity  
 - Management Tool: micromamba  
  
1. pull project  
`git clone https://github.com/haojiao-hofly/RStudioServer-RootFree.git`    
`cd RStudioServer-RootFree`    
`git lfs pull`    
  
2. Create and enter working directory, e.g.  
`mkdir workdir && cd workdir`
  
 3. Copy configuration files, modify password (password file), add singularity system path 
`cp -r /path/to/project/RstudioServer/* ./`   
`vi password`  
`export PATH=$PATH:/usr/local/bin`   
    
 4. Modify relevant parameters in /path/to/project/RstudioServer/run_RstudioServer.sh  
 `vi /path/to/project/RstudioServer/run_RstudioServer.sh`  
  
 5. Modify the singularity command in /path/to/project/run_singularity.sh file to bind important directories  
`vi /path/to/project/run_singularity.sh`  
 6. Start RStudio server, run_RstudioServer.sh script accepts one parameter to specify the R virtual environment name  
`sh run_RstudioServer.sh R_env_name`  



## 重要参数
| item           | 描述              |
| -------------- | --------------- |
| PORT           | 指定端口            |
| SOFT_DIR       | 项目根目录           |
| MICROMAMBA     | micromamba全路径   |
| MICROMAMBA_ENV | micromamba环境根路径 |
