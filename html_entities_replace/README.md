# ArkTS html_entities_replace

用于替换html字符串中存在的符号实体引用，为正确符号

用法：

```typescript
import { HtmlEntityReplace } from 'html_entites_replace';

let inputString: string = 'Android &ldquo;edge to edge&rdquo;特性-官方&ldquo;沉浸式&rdquo;方案实探';
const newInputString = HtmlEntityReplace.replace(inputString);
console.log(newInputString);
// 输出：Android “edge to edge”特性-官方“沉浸式”方案实探
```