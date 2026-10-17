# 成本标定原始表（附录 C）

> 生成时间（UTC）：2026-10-15T12:34:04+00:00
> GPU：NVIDIA H20
> 证明系统：EZKL（domain = integer）
> 数据来源：**measured**

> 热稳态预热：**2/24** 个配置达到稳态（`app:env` 的 notes 声称 *we still warm up to steady state before cost measurement* —— 这一行是那句话的凭据）。
>
> ⚠ **未达到稳态的配置**（其耗时不可与其它配置直接比较）：
>   - `LogReg 784-10 | m=32 | integral`：未收敛，预热 24 轮，最终 4 次耗时离散度 9.8%
>   - `LogReg 784-10 | m=32 | s=8`：未收敛，预热 24 轮，最终 4 次耗时离散度 12.1%
>   - `LogReg 784-10 | m=64 | integral`：未收敛，预热 24 轮，最终 4 次耗时离散度 6.4%
>   - `LogReg 784-10 | m=64 | s=8`：未收敛，预热 24 轮，最终 4 次耗时离散度 7.2%
>   - `LogReg 784-10 | m=128 | integral`：未收敛，预热 24 轮，最终 4 次耗时离散度 10.5%
>   - `LogReg 784-10 | m=128 | s=8`：未收敛，预热 24 轮，最终 4 次耗时离散度 3.2%
>   - `MLP-2 784-128-10 | m=32 | integral`：未收敛，预热 24 轮，最终 4 次耗时离散度 7.8%
>   - `MLP-2 784-128-10 | m=32 | s=8`：未收敛，预热 24 轮，最终 4 次耗时离散度 7.3%
>   - `MLP-2 784-128-10 | m=64 | integral`：未收敛，预热 24 轮，最终 4 次耗时离散度 7.2%
>   - `MLP-2 784-128-10 | m=64 | s=8`：未收敛，预热 24 轮，最终 4 次耗时离散度 3.3%
>   - `MLP-2 784-128-10 | m=128 | integral`：未收敛，预热 24 轮，最终 4 次耗时离散度 15.5%
>   - `MLP-2 784-128-10 | m=128 | s=8`：未收敛，预热 24 轮，最终 4 次耗时离散度 8.5%

| Model | m | Granularity | Constraints | Constr. source | Blocks | Prove time (s) | Peak VRAM incr | Peak RAM incr | Note |
|---|---|---|---|---|---|---|---|---|---|
| LogReg 784-10 | 32 | integral | 32,768 | measured (2^logrows) | 1 | 1.315 | 0 MB | 405 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LogReg 784-10 | 32 | s=8 | 32,768 | measured (2^logrows) | 4 | 1.336 | 0 MB | 396 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LogReg 784-10 | 64 | integral | 32,768 | measured (2^logrows) | 1 | 1.389 | 0 MB | 403 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LogReg 784-10 | 64 | s=8 | 32,768 | measured (2^logrows) | 8 | 1.354 | 0 MB | 401 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LogReg 784-10 | 128 | integral | 32,768 | measured (2^logrows) | 1 | 1.401 | 0 MB | 408 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LogReg 784-10 | 128 | s=8 | 32,768 | measured (2^logrows) | 16 | 1.414 | 0 MB | 400 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| MLP-2 784-128-10 | 32 | integral | 65,536 | measured (2^logrows) | 1 | 2.685 | 0 MB | 801 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| MLP-2 784-128-10 | 32 | s=8 | 65,536 | measured (2^logrows) | 4 | 2.774 | 0 MB | 799 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| MLP-2 784-128-10 | 64 | integral | 65,536 | measured (2^logrows) | 1 | 2.817 | 0 MB | 791 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| MLP-2 784-128-10 | 64 | s=8 | 65,536 | measured (2^logrows) | 8 | 2.698 | 0 MB | 794 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| MLP-2 784-128-10 | 128 | integral | 65,536 | measured (2^logrows) | 1 | 2.748 | 0 MB | 788 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| MLP-2 784-128-10 | 128 | s=8 | 65,536 | measured (2^logrows) | 16 | 2.757 | 0 MB | 786 MB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LeNet (32x32) | 32 | integral | 524,288 | measured (2^logrows) | 1 | 23.264 | 0 MB | 5.19 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LeNet (32x32) | 32 | s=8 | 524,288 | measured (2^logrows) | 4 | 23.130 | 0 MB | 5.15 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LeNet (32x32) | 64 | integral | 524,288 | measured (2^logrows) | 1 | 24.118 | 0 MB | 5.22 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LeNet (32x32) | 64 | s=8 | 524,288 | measured (2^logrows) | 8 | 22.411 | 0 MB | 5.27 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LeNet (32x32) | 128 | integral | 524,288 | measured (2^logrows) | 1 | 20.721 | 0 MB | 5.18 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| LeNet (32x32) | 128 | s=8 | 524,288 | measured (2^logrows) | 16 | 21.524 | 0 MB | 5.14 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| CNN-3conv (32x32) | 32 | integral | 2,097,152 | measured (2^logrows) | 1 | 74.735 | 0 MB | 20.02 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| CNN-3conv (32x32) | 32 | s=8 | 2,097,152 | measured (2^logrows) | 4 | 76.641 | 0 MB | 20.02 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| CNN-3conv (32x32) | 64 | integral | 2,097,152 | measured (2^logrows) | 1 | 77.750 | 0 MB | 20.02 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| CNN-3conv (32x32) | 64 | s=8 | 2,097,152 | measured (2^logrows) | 8 | 75.282 | 0 MB | 19.51 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| CNN-3conv (32x32) | 128 | integral | 2,097,152 | measured (2^logrows) | 1 | 76.743 | 0 MB | 19.77 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |
| CNN-3conv (32x32) | 128 | s=8 | 2,097,152 | measured (2^logrows) | 16 | 74.142 | 0 MB | 20.01 GB | ok; verify=pass; 内存口径=子进程峰值 RSS |

**约束数的口径 = 实测电路行数（2^logrows）**，从 `compile-circuit` 后的 settings.json 读出；仍标 `budget-model` 的行表示该行没取到实测值。

ResNet-18 不在表内：它只跑机制实验，不进证明流水线（按预算模型，H20 上整体证明 >9000 GB，越界；论文 Table~\ref{tab:blocking} 把它路由到 Tier 2）。显式写出边界比默默省略更可取。

## 与预算模型估算的对照

| 配置 | 预算模型 | 本次实测 | 偏差 |
|---|---|---|---|
| MLP-2 784-128-10 m=64 integral | 9.0 GB | 0.77 GB | -91% |
| MLP-2 784-128-10 m=64 s=8 | 2.4 GB | 0.78 GB | -68% |
| LeNet (32x32) m=64 integral | 26.4 GB | 5.22 GB | -80% |
| LeNet (32x32) m=64 s=8 | 4.6 GB | 5.27 GB | +15% |
| SmallCNN m=64 integral | 368.1 GB | **测不了** | 只能外推 |
| SmallCNN m=64 s=8 | 47.3 GB | **测不了** | 只能外推 |
| ResNet-18 m=64 integral | — | **测不了** | 只能外推 |

**"测不了"的行**（见 `BUDGET_MODEL_UNMEASURABLE`）：
- SmallCNN m=64 integral：无对应架构/ONNX（刻意不造）且有预算模型 368.1 GB 越界 ⇒ 只能由实测内存拟合外推（derive_memory_crossover）
- SmallCNN m=64 s=8：同上：无对应 ONNX ⇒ 只能外推
- ResNet-18 m=64 integral：预算 >9000 GB，越界；稿件把它路由到 Tier 2，不进证明流水线

**替换指引（四处，别只改一处）**：实测值必须在 `app:cost`（本表）、`app:env`（环境指纹）、正文里由成本权重得到的 $m^{*}$、以及**正文的 `tab:blocking`** 四处同步替换，否则正文与附录不一致。⚠ `tab:blocking` 身上**没有 \TODO 标记**，最容易漏。
