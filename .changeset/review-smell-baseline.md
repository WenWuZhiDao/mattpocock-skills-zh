---
"mattpocock-skills": patch
---

给处于进行中的 **`code-review`** 技能在其标准（Standards）轴上增加一个始终开启的 Fowler 坏味道基线。一组精选的约 12 条高信号"Bad Smells in Code"（Mysterious Name、Duplicated Code、Feature Envy、Data Clumps、Primitive Obsession、Repeated Switches、Shotgun Surgery、Divergent Change、Speculative Generality、Message Chains、Middle Man、Refused Bequest）被内联到 `SKILL.md` 中，作为一个固定基线，与仓库所记录的任何标准并列——而不是一个新的第三轴。两条约束规则保证它安全：仓库中已记录的标准会覆盖基线，且每条坏味道都作为判断性意见报告，绝不是硬性违规。
