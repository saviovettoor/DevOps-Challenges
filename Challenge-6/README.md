## Deamon Process

```
Download and Install Python 3 from Source
Here are the commands that we’ll run to build and install Python 3:

]# sudo su -
]# yum groupinstall -y "development tools"
]# yum install -y \
  libffi-devel \
  zlib-devel \
  bzip2-devel \
  openssl-devel \
  ncurses-devel \
  sqlite-devel \
  readline-devel \
  tk-devel \
  gdbm-devel \
  db4-devel \
  libpcap-devel \
  xz-devel \
  expat-devel

]# cd /usr/src
]# wget http://python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
]# tar xf Python-3.6.4.tar.xz
]# cd Python-3.6.4
]# ./configure --enable-optimizations
]# make altinstall
]# exit

]# sudo pip3.6 install --upgrade pip
]# sudo pip3.6 install --upgrade psutil
]# sudo pip3.6 install time
]# pip3.6 install --upgrade sh

Now place the script in the folder /usr/src/Python-3.6.4/ and excute it using ./python <script_name> make sure script have executable permission
```