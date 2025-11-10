# RStudioServer-RootFree
Deploying RStudio Server using Singularity without root privileges.  
使用singularity部署Rstudio Server（无需root权限）。  

# 必须使用lfs拉取项目
git clone https://github.com/haojiao-hofly/RStudioServer-RootFree.git  
cd RStudioServer-RootFree 
git lfs pull 
  
#============================ CN ============================  
##免超级管理员权限配置Rstudio server单人版（4.2）  
##部署工具：singularity  
##管理工具：micromamba  
  
#1.创建并进入工作目录，如  
mkdir workdir && cd  workdir
  
#2.拷贝配置文件，修改密码（password文件），添加singularity系统路径  
cp  -r /path/to/project/RstudioServer/*  ./  
vi password 
export PATH=$PATH:/usr/local/bin  
  
#3.修改/path/to/project/RstudioServer/run_RstudioServer.sh中的相关参数  
  
#4.修改/path/to/project/run_singularity.sh文件的singularity命令，绑定重要目录  
  
#5.启动Rstudio server，run_RstudioServer.sh脚本接收一个参数指定R虚拟环境的名称  
sh run_RstudioServer.sh R_env_name  
  
#============================ EN ============================  
##Configuring RStudio Server Single-User Version (4.2) Without Superuser Privileges  
##Deployment Tool: singularity  
##Management Tool: micromamba  
  
#1. Create and enter working directory, e.g.  
mkdir workdir && cd workdir  
  
#2. Copy configuration files, modify password (password file), add singularity system path  
cp -r /path/to/project/RstudioServer/* ./   
vi password  
export PATH=$PATH:/usr/local/bin  
  
#3. Modify relevant parameters in /path/to/project/RstudioServer/run_RstudioServer.sh  

#4. Modify the singularity command in /path/to/project/run_singularity.sh file to bind important directories

#5. Start RStudio server, run_RstudioServer.sh script accepts one parameter to specify the R virtual environment name
sh run_RstudioServer.sh R_env_name
