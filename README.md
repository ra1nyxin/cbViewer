# cbViewer (Clipboard Viewer in x86_64 Assembly)

## Introduction / 简介

**cbViewer** is a high-performance, minimalist Windows utility written in pure x86_64 assembly. It retrieves text data from the system clipboard and displays it in a native Windows message box.
**cbViewer** 是一个使用纯 x86_64 汇编编写的 Windows 工具。它能从系统剪贴板获取文本数据并将其显示在原生 Windows 消息框中。

### Key Features / 核心特性

* **Native Unicode Support**: Handles multi-language characters (CJK, etc.) via `UTF-16LE` encoding and `MessageBoxW`.
**原生 Unicode 支持**：通过 `UTF-16LE` 编码和 `MessageBoxW` 处理多语言字符（中日韩等）。
* **Memory Safety**: Implements a strict 4096-character buffer limit to prevent overflows or GUI freezing.
**内存安全**：实现严格的 4096 字符缓冲区限制，防止溢出或 GUI 卡死。
* **Minimal Footprint**: Optimized for size and efficiency with zero external runtime dependencies (when statically linked).
**极小体积**：经过体积与效率优化，零外部运行时依赖（静态链接时）。

---

## Technical Architecture / 技术架构

The tool utilizes the Win64 ABI calling convention, leveraging direct calls to `user32.dll` and `kernel32.dll`. It manages clipboard ownership and global memory handles with robust error checking.
该工具利用 Win64 ABI 调用约定，直接调用 `user32.dll` 和 `kernel32.dll`。它通过健壮的错误检查来管理剪贴板所有权和全局内存句柄。

---

## Compilation / 编译指南

### Prerequisites / 前提条件

* MinGW-w64 (GCC 14.2.0 or later recommended)
* GNU Assembler (`as`)

### Build Command / 编译命令

To produce a standalone, stripped, and optimized executable, run:
执行以下命令生成独立、剥离符号且经过优化的可执行文件：

```bash
gcc -static -s -ffunction-sections -fdata-sections cb_viewer.s -o cb_viewer.exe -Wl,--gc-sections -luser32 -lkernel32 -mwindows

```

**Flag Explanations / 参数解析**:

* `-static`: Link all libraries statically. / 静态链接所有库。
* `-s`: Strip all symbol information to minimize file size. / 剥离所有符号信息以减小体积。
* `-ffunction-sections -fdata-sections`: Place each function/data in its own section. / 将每个函数/数据放入独立节。
* `-Wl,--gc-sections`: Remove unused code sections during linking. / 链接阶段移除未使用的代码节。
* `-mwindows`: Suppress the console window. / 禁用控制台窗口。

---

## Contributing / 欢迎贡献

Contributions are highly welcome. Whether it is a bug fix, feature request, or optimization of the assembly logic, your input helps improve this low-level utility.
非常欢迎各界贡献。无论是修复漏洞、增加新功能还是优化汇编逻辑，您的参与都将提升此底层工具的质量。

1. Fork the repository (`github.com/ra1nyxin/cbViewer`). / 克隆仓库。
2. Create your feature branch. / 创建您的特性分支。
3. Commit your changes with clear logic descriptions. / 提交带有清晰逻辑说明的更改。
4. Push to the branch and open a Pull Request. / 推送分支并开启 PR。

---

## License / 许可证

This project is licensed under the **MIT License**.
本项目基于 **MIT 许可证** 开源。
