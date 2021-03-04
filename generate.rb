files = Dir.glob('models/**/*.json')

output_folder = "/Users/wyatt/Programer/github/spapi"

files.each do |f|
  # 1. 生成代码
  package_name =  File.basename(f).gsub('.json', '').gsub('V0', '').split("_").first.downcase
  #command = "swagger-codegen generate --group-id com.amazon --artifact-id spapi --artifact-version 1.0.0 --invoker-package com.amazon.spapi.client --api-package com.amazon.spapi.api --model-package com.amazon.spapi.model.#{package_name} -i #{f} -l java -o #{output_folder}"
  command = "java -jar swagger-codegen-cli.jar generate --group-id com.amazon --artifact-id spapi --artifact-version 1.0.0 --invoker-package com.amazon.spapi.client --api-package com.amazon.spapi.api --model-package com.amazon.spapi.model.#{package_name} -i #{f} -l java -o #{output_folder}"
  puts command
  `#{command}`
end

# 2. 挪动 SellingPartnerAPIAA
command2 = "cp -r clients/sellingpartner-api-aa-java/src/com #{output_folder}/src/main/java/"
puts command2
`#{command2}`

# 3. 修改 gradle 版本
command3 = "cp -f gradle-wrapper.properties #{output_folder}/gradle/wrapper/"
puts command3
`#{command3}`

# 4. 增加 gradlew 可执行权限
command4 = "chmod +x #{output_folder}/gradlew"
puts command4
`#{command4}`

# 5. 调整构建脚本
command5 = "cp -f build.gradle #{output_folder}/"
puts command5
`#{command5}`
