<p align="center"><img src="/art/logo.svg"></p>

<p align="center">
    <a href="https://github.com/laravel/homestead/actions">
        <img src="https://github.com/laravel/homestead/workflows/tests/badge.svg" alt="Build Status">
    </a>
    <a href="https://packagist.org/packages/laravel/homestead">
        <img src="https://img.shields.io/packagist/dt/laravel/homestead" alt="Total Downloads">
    </a>
    <a href="https://packagist.org/packages/laravel/homestead">
        <img src="https://img.shields.io/packagist/v/laravel/homestead" alt="Latest Stable Version">
    </a>
    <a href="https://packagist.org/packages/laravel/homestead">
        <img src="https://img.shields.io/packagist/l/laravel/homestead" alt="License">
    </a>
</p>

## Introduction

Laravel Homestead is an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Homestead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 8.2, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing Laravel applications.

Official documentation [is located here](https://laravel.com/docs/homestead).

| Ubuntu LTS | Settler Version | Homestead Version | Branch      | Status
| -----------|-----------------|-------------------| ----------- | -----------
| 20.04      | 13.x            | 14.x              | `main`      | Development/Unstable
| 20.04      | 13.x            | 14.x              | `release`   | Stable

## Developing Homestead

To keep any in-development changes separate from other Homestead installations, create a new project and install
Homestead from composer, forcing it to use a git checkout.

```shell
mkdir homestead && \
cd homestead && \
composer require --prefer-source laravel/homestead:dev-main
```

After it's complete, `vendor/laravel/homestead` will be a git checkout and can be used normally.

## clone

```shell
git clone https://github.com/pu-explore/homestead.git
```

## New function

### Add configurable software repositories：`sources`

> Configure the source_list to prevent unavailability due to network issues

```yaml
# Homestead.yaml
sources: "http://cn.archive.ubuntu.com"
ip: "192.168.56.10"
memory: 2048
```

> China source_list address

- 网易：http://mirrors.163.com
- 阿里：http://mirrors.aliyun.com
- 清华：https://mirrors.tuna.tsinghua.edu.cn
- 中科大：https://mirrors.ustc.edu.cn

### You can configure the vue site：`type: vue`

### When multi-site, you can configure the IP default site：`default: true`

```yaml
# Homestead.yaml
sites:
    - map: laravel.box
      to: /home/vagrant/code/laravel/public
    - map: vue.box
      to: /home/vagrant/code/vue/dist
      xhgui: admin
      type: vue
    - map: lumen.box
      to: /home/vagrant/code/lumen/public
      default: true
```

> Configure the default site to directly access the corresponding site through IP in the LAN without domain name access
