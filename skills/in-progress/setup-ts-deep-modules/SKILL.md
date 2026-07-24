---
name: setup-ts-deep-modules
description: 把 dependency-cruiser 接入一个 TypeScript 仓库，使每个包都成为深模块——实现隐藏在子文件夹里，只能通过其入口文件访问。用户触发。
disable-model-invocation: true
---

# Setup TS Deep Modules

让本仓库中的每个包都成为一个**深模块**：小接口背后藏着大量行为。一个包的公共表面就是它的**入口点**——位于包根目录的那些文件——而它子文件夹里的一切都是隐藏的。本技能会安装 [dependency-cruiser](https://github.com/sverweij/dependency-cruiser) 以及一套规则，使入口点成为唯一的进入方式，然后证明这些规则确实生效。

关于相关词汇（深模块、接口、接缝、深度），运行 `/codebase-design` 技能——全程使用它的语言。

## 它所强制的形态

```
src/packages/
  <name>/
    index.ts        ← 一个入口点（公共）。从外部导入这个。
    client.ts       ← 另一个入口点。包可以暴露多个。
    lib/            ← 实现：对外隐藏，彼此之间可自由导入。
    tests/          ← 就近放置的测试 + 固件（一个子文件夹，所以是私有的）。
```

公共表面是包的**根文件**——而不是某个指定的 `index.ts`。按约定，实现放在 `lib/`，测试放在 `tests/`，让每个包都有相同的双文件夹形态。不过规则本身是通用的：*任何*子文件夹里的*任何东西*都是私有的，所以你永远不需要为了新增一个文件夹去扩展配置。

四条规则，全部为 `error`：

1. **入口点边界** — 包外部的代码（应用代码或另一个包）只能导入该包的入口点（其根文件），绝不能导入它子文件夹里的任何东西。
2. **包内自由** — 一个包自己的文件之间可自由互相导入。
3. **测试经由入口点** — `<pkg>/tests/` 下的文件可以导入任何包的入口点以及它们自己的 `tests/` 固件，但绝不能导入任何包的子文件夹内部（即使是它们自己的也不行）。跨包的集成测试没问题；深层导入不行。
4. **无环** — 不存在依赖环。

**是入口点，不是 barrel。** 因为公共表面是*每个*根文件，所以一个包可以暴露多个小入口点（`index.ts`、`client.ts`、`server.ts`），而不必把一切都塞进一个巨大的 `index.ts`。不鼓励用重新导出整个子树的 barrel 文件——保持入口点小巧，把实现藏进子文件夹。

分层（哪些包可以依赖哪些包）是一个*不同的*关注点，本仓库需在配置里以注释形式的占位存根自行填写。

## 步骤

### 1. 检测环境

- **包管理器** — `pnpm-lock.yaml` → pnpm，`yarn.lock` → yarn，`bun.lockb` → bun，否则 npm。下面每条命令都用它（`pnpm`/`yarn`/`npm run`/`bunx`）。
- **包根目录** — 若存在 `src/` 则用 `src/packages`，否则用 `packages`。若仓库已有另一套明显的约定，则与用户确认该选择。
- **既有配置** — 检查是否有 `.dependency-cruiser.*` 文件。如果已存在，**不要**覆盖它：把四条规则和相关选项合并进去，并告知用户你添加了什么。

**完成标准：** 包管理器、包根目录、既有配置状态三者都已知。

### 2. 安装 dependency-cruiser

用检测到的包管理器把 `dependency-cruiser` 安装为 devDependency。

**完成标准：** `dependency-cruiser` 出现在 `devDependencies` 中。

### 3. 写入配置

把 [`dependency-cruiser.config.cjs`](./dependency-cruiser.config.cjs) 复制到仓库根目录，命名为 `.dependency-cruiser.cjs`。把 `PACKAGES_ROOT` 设为第 1 步检测到的根目录。这些规则基于路径深度且与扩展名无关，所以无需再改动其他东西。

**完成标准：** `.dependency-cruiser.cjs` 存在且 `PACKAGES_ROOT` 正确，四条 forbidden 规则都在。

### 4. 接入检查流程

- 添加一个 `lint:boundaries` 脚本：`depcruise <packages-root>`（或 `depcruise src`）。
- 把它并入仓库的总检查命令——也就是那个已经运行 typecheck 的命令（例如 `check` / `ci` / `validate` 脚本）。**不要**改动 `tsconfig`，也不要添加路径别名。
- 如果没有总检查脚本，就添加 `lint:boundaries` 并告知用户把它纳入 CI。

**完成标准：** `lint:boundaries` 存在，并作为与 typecheck 同一条命令的一部分运行。

### 5. 搭建示例包

创建一个提交进仓库的 `<packages-root>/example/`，作为“照我抄”的模板：

- `index.ts` — 一个入口点。导出一个函数，它委托给一个内部文件（这样这个包才明显是*深*的，而不是一个直通层）。
- `lib/impl.ts` — 一个位于**子文件夹**中的内部文件，被 `index.ts` 导入，从外部无法访问。
- `tests/example.test.ts` — **只**导入 `../index`（一个入口点），并针对该公共函数做断言。

告诉用户这是一个起步模板，可以复制或删除。

**完成标准：** 示例包存在，通过一个根入口点暴露其行为，并把 `impl` 藏在子文件夹里。

### 6. 证明规则生效

这是整个技能的完成判据——一个在违规时不会失败的配置毫无价值。

1. 运行 `lint:boundaries`。它在干净的示例上必须**通过**。
2. 临时给 `tests/example.test.ts` 加一个深层导入（例如 `import { thing } from "../lib/impl"`）。再次运行 `lint:boundaries`——它必须以 `tests-through-entrypoints` **失败**。
3. 撤销那个深层导入。再运行一次——它必须**通过**。

**完成标准：** 你已观察到一次通过、然后在深层导入上一次失败、再一次通过。如果第 2 步没有失败，说明规则没接对——完成前先修好。

### 7. 记录约定

在**包文件夹里**（`<packages-root>/README.md`）写一个 `README.md`——就放在它所治理的那些包旁边——内容涵盖：`src/packages/<name>/` 布局（入口点在根目录、`lib/` 放实现、`tests/` 放测试）、“只通过包的入口点（其根文件）导入”，以及如何运行 `lint:boundaries`。明确**劝阻使用 barrel 文件**——暴露多个小入口点，而不是通过一个 index 重新导出整个子树。把它控制在“照我抄”的代码片段，加上四条规则各一段。

然后从仓库的 agent 指令文件添加一个指向它的**上下文指针**——有 `CLAUDE.md` 就用它，否则用 `AGENTS.md`（若两者都没有则创建 `AGENTS.md`）。一行就够，例如 `Packages are deep modules — see [src/packages/README.md](./src/packages/README.md) before adding or importing one.`。正是这一点让 agent 发现边界规则，而不是撞上它。

**完成标准：** `<packages-root>/README.md` 存在且劝阻 barrel，仓库的 `CLAUDE.md`/`AGENTS.md` 链接到它。

## 备注

- 配置里的 `$1` 反向引用（dependency-cruiser 的分组匹配）正是让一个包能够访问自己的内部、而外人不能的机制——不要把它们摊平成一条条按包分开的规则。
- 公共与私有由**深度**决定：包的根文件是入口点；子文件夹里的任何东西都是私有的。约定的子文件夹是 `lib/`（实现）和 `tests/`，但规则并没有把它们写死——任何子文件夹都是私有的，所以新增文件夹永远不需要改配置。添加一个入口点只是添加一个根文件——没有 barrel。
- 包是**扁平的**：根下只有一层直接子级。一个包的内部可以按你喜欢的深度嵌套；一个包不能包含另一个包。
- 使用 `.cjs`（而非 `.js`），这样即使在 `"type": "module"` 的仓库里，配置的 `module.exports` 也能正常工作。
