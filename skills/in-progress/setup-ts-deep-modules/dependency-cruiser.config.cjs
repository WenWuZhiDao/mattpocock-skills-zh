// @ts-check
// 为 dependency-cruiser 提供的深模块约束。
//
// packages 根目录下的每个包都是一个深模块（DEEP MODULE）：在一个小接口
// 背后隐藏大量行为。一个包的公共接口（PUBLIC SURFACE）就是它的入口点
// （ENTRY POINTS）——位于包根目录下的文件。实现代码位于子文件夹
// （SUBFOLDERS）中且为私有——按约定用 `lib/` 存放实现、用 `tests/` 存放测试，
// 但任何子文件夹都是私有的。一个包可以暴露多个小入口点
// （index.ts、client.ts、server.ts 等）——相比一个巨大的
// barrel index，更推荐这种做法。
//
// 这里唯一需要你修改的就是 PACKAGES_ROOT。

/** 包所在的位置。每个包对应一个直接子目录（扁平结构，不嵌套）。 */
const PACKAGES_ROOT = "src/packages";

// --- 派生出的匹配模式（无需修改） -------------------------------------
const R = PACKAGES_ROOT;
/**
 * 一个包的私有内部实现：嵌套在包子文件夹内部的任何内容。
 * 包根目录下的文件是它的入口点，不会被这里匹配到——
 * 它们仍可从外部导入。
 */
const PACKAGE_INTERNALS = `^${R}/[^/]+/[^/]+/`;

/** @type {import('dependency-cruiser').IConfiguration} */
module.exports = {
  forbidden: [
    {
      name: "entrypoint-boundary-from-app",
      comment:
        "应用/根目录代码可以导入某个包的入口点（其根目录文件），但不能导入其子文件夹内的任何内容。",
      severity: "error",
      from: { pathNot: `^${R}/` }, // 导入方不在任何包内部
      to: { path: PACKAGE_INTERNALS },
    },
    {
      name: "entrypoint-boundary-across-packages",
      comment:
        "一个包自己的文件之间可以自由相互导入，但只能通过入口点访问其他包——绝不能访问其内部实现。",
      severity: "error",
      // 导入方位于某个包内部（$1），且不是测试文件
      from: { path: `^${R}/([^/]+)/`, pathNot: `^${R}/[^/]+/tests/` },
      to: {
        path: PACKAGE_INTERNALS,
        pathNot: `^${R}/$1/`, // 同一个包 → 包内自由导入
      },
    },
    {
      name: "tests-through-entrypoints",
      comment:
        "一个包的测试和其他所有人一样，通过入口点来使用它：测试可以导入任何包的入口点以及自己的 tests/ 夹具，但绝不能导入任何包的内部实现——包括它自己的。",
      severity: "error",
      from: { path: `^${R}/([^/]+)/tests/` }, // 一个测试文件，位于包 $1 中
      to: {
        path: PACKAGE_INTERNALS,
        pathNot: `^${R}/$1/tests/`, // 自己的 tests/ 夹具 → 允许
      },
    },
    {
      name: "tests-folder-is-private",
      comment:
        "一个包的 tests/ 文件夹只能被测试访问——其他任何代码都不能导入夹具。",
      severity: "error",
      from: { pathNot: `^${R}/[^/]+/tests/` }, // 导入方本身不是测试
      to: { path: `^${R}/[^/]+/tests/` },
    },
    {
      name: "no-circular",
      comment: "不允许依赖环。如果你想在包之外允许存在环，可将范围限定为 `^${R}/`。",
      severity: "error",
      from: {},
      to: { circular: true },
    },

    // --- 分层（可选，默认关闭） ----------------------------------
    // 接口隐藏控制的是你如何导入（通过入口点）。
    // 分层控制的是哪些包可以依赖哪些包。在此添加你自己的规则，
    // 例如：
    //
    // {
    //   name: "ui-may-not-depend-on-billing",
    //   severity: "error",
    //   from: { path: `^${R}/ui/` },
    //   to:   { path: `^${R}/billing/` },
    // },
  ],
  options: {
    doNotFollow: { path: "node_modules" },
    tsConfig: { fileName: "tsconfig.json" },
    enhancedResolveOptions: {
      extensions: [".ts", ".tsx", ".js", ".jsx", ".json"],
    },
  },
};
