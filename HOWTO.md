# 将 amazon 官方的 sp-api 生成 jar 包
最终还是使用 https://github.com/penghaiping/amazon-sp-api 这个, 因为其中有一些在构建中的错误暂时没有找到修复的办法.

# 走过一遍才知道的问题
1. swagger-codegen 的命令在 generate.rb 中, 调整了 api, model 的 package
2. 区分 sellingpartner-api-aa-java, 这个需要单独处理
3. 对 FbaInboundApi 生成错误, 他在 fulfillmentInboundV0 与 fba-inbound-eligibility-api-model 都存在, 需要在生成代码的时候区分开
4. [Schema] is already defined in this compilation unit, 在 solicitations 与 messaging 这两个包中存在. 未成功


# 最终结果
在走过这一条流程后, 完成了 95% 的内容, 最后只剩下一点点, 但这一点点需要花的时间太长了. 在了解整个生成的过程后发现, 要最终输出一份对应语言
的 SDK 有很多的小细节需要处理, 所以最终还是使用他人已经弄好的进行处理, 下面是构建得比较好的:

* java sdk [amazon-sp-api](https://github.com/penghaiping/amazon-sp-api)
* php sdk [amazon-sp-api-php](https://github.com/clousale/amazon-sp-api-php)
* nodejs sdk [amazon-sp-api](https://github.com/amz-tools/amazon-sp-api)
* golang sdk [selling-partner-api-sdk](https://github.com/gopkg-dev/selling-partner-api-sdk)

构建得不是很好的:
* ruby sdk [amz_sp_api](https://github.com/ericcj/amz_sp_api), 众多需要一个一个安装, 其实可以合并到一起

所以, 最终 java 版本的 sdk 使用 [amazon-sp-api](https://github.com/penghaiping/amazon-sp-api) 然后推送到自己的 Github 的 maven
仓储中.

# Swagger Codegen
1. 可以使用 java -jar swagger-codegen-cli.jar config-help -l java 来检查 java 语言生成代码支持哪一些 library

使用 retrofit2 为了避免默认与常见的 jackson 出现冲突
