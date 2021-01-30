Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v14 06/11] x86/elf: Move vmcore_elf_check_arch_cross to
 arch/x86/include/asm/elf.h
Date: Sat, 30 Jan 2021 15:10:20 +0800
Message-ID: <20210130071025.65258-7-chenzhou10@huawei.com>
In-Reply-To: <20210130071025.65258-1-chenzhou10@huawei.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mingo@redhat.com, tglx@linutronix.de, rppt@kernel.org, dyoung@redhat.com, bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org, nsaenzjulienne@suse.de, corbet@lwn.net, John.P.donnelly@oracle.com, bhsharma@redhat.com, prabhakar.pkin@gmail.com
Cc: wangkefeng.wang@huawei.com, kernel test robot <lkp@intel.com>, arnd@arndb.de, xiexiuqi@huawei.com, chenzhou10@huawei.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, james.morse@arm.com, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

Move macro vmcore_elf_check_arch_cross from arch/x86/include/asm/kexec.h
to arch/x86/include/asm/elf.h to fix the following compiling warning:

make ARCH=i386
In file included from arch/x86/kernel/setup.c:39:0:
./arch/x86/include/asm/kexec.h:77:0: warning: "vmcore_elf_check_arch_cross" redefined
 # define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)

In file included from arch/x86/kernel/setup.c:9:0:
./include/linux/crash_dump.h:39:0: note: this is the location of the previous definition
 #define vmcore_elf_check_arch_cross(x) 0

The root cause is that vmcore_elf_check_arch_cross under CONFIG_CRASH_CORE
depend on CONFIG_KEXEC_CORE. Commit 2db65f1db17d ("x86: kdump: move
reserve_crashkernel[_low]() into crash_core.c") triggered the issue.

Suggested by Mike, simply move vmcore_elf_check_arch_cross from
arch/x86/include/asm/kexec.h to arch/x86/include/asm/elf.h to fix
the warning.

Fixes: 2db65f1db17d ("x86: kdump: move reserve_crashkernel[_low]() into crash_core.c")
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/include/asm/elf.h   | 3 +++
 arch/x86/include/asm/kexec.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 66bdfe838d61..5333777cc758 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -94,6 +94,9 @@ extern unsigned int vdso32_enabled;
 
 #define elf_check_arch(x)	elf_check_arch_ia32(x)
 
+/* We can also handle crash dumps from 64 bit kernel. */
+# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
+
 /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
    contains a pointer to a function which might be registered using `atexit'.
    This provides a mean for the dynamic linker to call DT_FINI functions for
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 2b18f918203e..6fcae01a9cca 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -72,9 +72,6 @@ struct kimage;
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
-
-/* We can also handle crash dumps from 64 bit kernel. */
-# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
 #else
 /* Maximum physical address we can use pages from */
 # define KEXEC_SOURCE_MEMORY_LIMIT      (MAXMEM-1)
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
