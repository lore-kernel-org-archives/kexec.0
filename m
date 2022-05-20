From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Fri, 20 May 2022 08:45:21 -0700 (PDT)
Subject: [PATCH v3 -next 0/6] riscv: kexec: add kexec_file_load() support
In-Reply-To: <20220408100914.150110-1-lizhengyu3@huawei.com>
Message-ID: <mhng-86400921-7491-46ce-8248-d09a4d49f673@palmer-mbp2014>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 08 Apr 2022 03:09:08 PDT (-0700), lizhengyu3 at huawei.com wrote:
> This patchset implement kexec_file_load() support on riscv, Most of the
> code is based on the kexec-tool-patch repo developed by Nick Kossifids.
>
> This patch series enables us to load the riscv vmlinux by specifying
> its file decriptor, instead of user-filled buffer via kexec_file_load()
> syscall.
> ``
> Contrary to kexec_load() system call, we reuse the dt blob of the first
> kernel to the 2nd explicitly.
>
> To use kexec_file_load() system call, instead of kexec_load(), at kexec
> command, '-s' options must be specified. The patch for kexec_tools has
> to be apply to riscv architecture source like this:
>
> int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
> 	...
> 	if (info->file_mode) {
> 		return prepare_kexec_file_options(info);
> 	}
> 	...
>
> Add following routine to prepare cmdline_ptr, cmdline_len and initrd_fd
> for syscall kexec_file_load:
>
> int prepare_kexec_file_options(struct kexec_info *info)
> {
> 	int fd;
> 	ssize_t result;
> 	struct stat stats;
>
> 	if (arch_options.cmdline) {
> 		info->command_line = (char *)arch_options.cmdline;
> 		info->command_line_len = strlen(info->command_line) + 1;
> 	}
>
> 	if (!arch_options.initrd_path) {
> 		info->initrd_fd = -1;
> 		return 0;
> 	}
>
> 	fd = open(arch_options.initrd_path, O_RDONLY | _O_BINARY);
> 	if (fd < 0) {
> 		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_path,
> 				strerror(errno));
> 		return -EINVAL;
> 	}
> 	result = fstat(fd, &stats);
> 	if (result < 0) {
> 		close(fd);
> 		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_path,
> 				strerror(errno));
> 		return -EINVAL;
> 	}
> 	info->initrd_fd = fd;
> 	return 0;
> }
>
> The basic usage of kexec_file is:
> 1) Reload capture kernel image:
> $ kexec -s -l <riscv-vmlinux> --reuse-cmdline
>
> 2) Startup capture kernel:
> $ kexec -e
>
> For kdump:
> 1) Reload capture kernel image:
> $ kexec -s -p <riscv-vmlinux> --reuse-cmdline
>
> 2) Do something to crash, like:
> $ echo c > /proc/sysrq-trigger
>
> v3:
>  * Rebase on v5.18-rc1
>  * Workaround for -Wmissing-prototypes
>
> v2:
>  * Support kdump
>  * Support purgatory
>  * Minor cleanups
>
> Li Zhengyu (3):
>   RISC-V: Support for kexec_file on panic
>   RISC-V: Add purgatory
>   RISC-V: Load purgatory in kexec_file
>
> Liao Chang (3):
>   kexec_file: Fix kexec_file.c build error for riscv platform
>   RISC-V: use memcpy for kexec_file mode
>   RISC-V: Add kexec_file support
>
>  arch/riscv/Kbuild                      |   2 +
>  arch/riscv/Kconfig                     |  17 +
>  arch/riscv/include/asm/kexec.h         |   4 +
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/elf_kexec.c          | 448 +++++++++++++++++++++++++
>  arch/riscv/kernel/machine_kexec.c      |   4 +-
>  arch/riscv/kernel/machine_kexec_file.c |  14 +
>  arch/riscv/purgatory/.gitignore        |   4 +
>  arch/riscv/purgatory/Makefile          |  95 ++++++
>  arch/riscv/purgatory/entry.S           |  47 +++
>  arch/riscv/purgatory/purgatory.c       |  45 +++
>  include/linux/kexec.h                  |   2 +-
>  kernel/kexec_file.c                    |   4 +-
>  13 files changed, 683 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/kernel/elf_kexec.c
>  create mode 100644 arch/riscv/kernel/machine_kexec_file.c
>  create mode 100644 arch/riscv/purgatory/.gitignore
>  create mode 100644 arch/riscv/purgatory/Makefile
>  create mode 100644 arch/riscv/purgatory/entry.S
>  create mode 100644 arch/riscv/purgatory/purgatory.c

This doesn't build on 32-bit, there's some issues both in the arch code 
and the generic code.  Looks like nobody else supports these bits on 
32-bit platforms, so I've restricted this to rv64 for now and sent along 
a patch set to fix everything up for 32-bit platforms.

This, with that minor Kconfig change just squashed in, is on for-next.  
It passes my tests, but I don't have anything specific to kexec_file() 
so that's probbaly not so exciting.

Thanks!

