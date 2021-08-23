files = Dir.glob('models/**/*.json')

output_folder = "./codegen"

# 两份 api 描述, 只能使用一份
skip_files = %w[catalogItemsV0 feeds_2020-09-04 reports_2021-06-30 vendor]

# - 清理老文件
cmd0 = "rm -rf #{output_folder}"
puts cmd0
`#{cmd0}`

files.each do |f|
  next if skip_files.select { |sk| f.include?(sk) }.size > 0
  # 1. 生成代码
  package_name =  File.basename(f).gsub('.json', '').gsub('V0', '').split("_").first.downcase
  template_path = 'clients/sellingpartner-api-aa-java/resources/swagger-codegen/templates'
  puts "file: #{f}, package_name: #{package_name}"
  # 使用 swagger-codegen 命令
  #command = "swagger-codegen generate --group-id com.amazon --artifact-id spapi --artifact-version 1.0.0 --invoker-package com.amazon.spapi.client --api-package com.amazon.spapi.api --model-package com.amazon.spapi.model.#{package_name} -i #{f} -l java -o #{output_folder}"
  # 直接使用 java + swagger-codegen jar 包
  # command = "java -jar swagger-codegen-cli.jar generate --group-id com.amazon --artifact-id spapi --artifact-version 1.0.0 --invoker-package com.amazon.spapi.client --api-package com.amazon.spapi.api --model-package com.amazon.spapi.model.#{package_name} -i #{f} -l java -o #{output_folder}"
  command = "java -jar swagger-codegen-cli.jar generate --model-package com.amazon.spapi.models.#{package_name} -t #{template_path}  -i #{f} -l java -c ./config.json -o #{output_folder}"
  puts command
  `#{command}`
end

# - 挪动 SellingPartnerAPIAA
cp1 = "cp -r clients/sellingpartner-api-aa-java/src/com #{output_folder}/src/main/java/"
puts cp1
`#{cp1}`

cp2 = "cp -r clients/sellingpartner-api-aa-java/tst/com #{output_folder}/src/test/java/"
puts cp2
`#{cp2}`

# - 挪动 documents api
cp3 = "cp -r clients/sellingpartner-api-documents-helper-java/src/main/java/com #{output_folder}/src/main/java/"
puts cp3
`#{cp3}`

# - 修改 gradle 版本
command3 = "cp -f gradle-wrapper.properties #{output_folder}/gradle/wrapper/"
puts command3
`#{command3}`

# - 增加 gradlew 可执行权限
command4 = "chmod +x #{output_folder}/gradlew"
puts command4
`#{command4}`

# - 调整构建脚本
command5 = "cp -f build.gradle #{output_folder}/"
puts command5
`#{command5}`

# - 清理无用的文件
cmd6 = "rm -rf #{output_folder}/src/main/AndroidManifest.xml"
puts cmd6
`#{cmd6}`
