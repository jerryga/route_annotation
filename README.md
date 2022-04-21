# route_annotation

## **使用注解生成路由表**

****

### 代码结构：

code_gen：注解解析与生成

helloworld：Demo展示

### 集成（参考 helloworld Demo）

1. 将code_gen加入pubspec.yaml中：

    `code_gen:`

`
        path: ../code_gen`

2. `flutter pub get`

3. `flutter packages pub run build_runner clean`

4. `flutter packages pub run build_runner build --delete-conflicting-outputs`

### 路由查找

![](https://gist.githubusercontent.com/jerryga/d22cdca42ade8e5db64db2e9580e854b/raw/routeflow.jpg)