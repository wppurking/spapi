## Selling Partner API Models
This repository contains Swagger models for developers to use to create software to call Selling Partner APIs. Developers can use [swagger codegen](https://github.com/swagger-api/swagger-codegen) to generate client libraries from these models. Please refer to [selling-partner-api-docs](https://github.com/amzn/selling-partner-api-docs) for additional documentation and read the [Selling Partner API Developer Guide](https://github.com/amzn/selling-partner-api-docs/blob/main/guides/en-US/developer-guide/SellingPartnerApiDeveloperGuide.md) for instructions to get started.

The [models directory](https://github.com/amzn/selling-partner-api-models/tree/main/models) contains all of the currently available Selling Partner API models.

The [clients directory](https://github.com/amzn/selling-partner-api-models/tree/main/clients) contains a [Java library](https://github.com/amzn/selling-partner-api-models/tree/main/clients/sellingpartner-api-aa-java) and a [C# library](https://github.com/amzn/selling-partner-api-models/tree/main/clients/sellingpartner-api-aa-csharp) with mustache templates for use with [swagger-codegen](https://swagger.io/tools/swagger-codegen/) to generate client libraries with authentication and authorization functionality included. The templates are located in *resources/swagger-codegen*.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.


## 使用说明
因为需要为每一个 api 的描述文件生成 api, 而且 amazon 的 api 很多, 所以使用 ruby 脚本进行处理, 其中步骤有:
1. 设定好 groupId, artifactId, template, invokerPackage 等生成主体的 api 代码
2. 复制需要的 SellingPartnerAPIAA 与 Documents API
3. 调整 gradle 的信息, build.gradle 与依赖


使用:
* ruby generate.rb
* 将代码 cp 到对应目录, 例如: cp -r codegen/* /Users/wyatt/Programer/gitlab/amazon-sp-api/
* 需要将  messaging/Schema 与 solicitations/Schema 中的 @Schema 与 Schema 区分开. 手动修改 @Schema 变为 @io.swagger.v3.oas.annotations.media.Schema
* 最后在 <xxx>/amazon-sp-api/ 生成 jar 包, ./gradlew jar
