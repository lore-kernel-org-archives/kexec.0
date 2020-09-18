Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
Date: Fri, 18 Sep 2020 15:24:36 +0200
Message-Id: <20200918132439.1475479-2-arnd@arndb.de>
In-Reply-To: <20200918132439.1475479-1-arnd@arndb.de>
References: <20200918132439.1475479-1-arnd@arndb.de>
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
To: Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org

sys_move_pages() is an optional syscall, and once we remove
the compat version of it in favor of the native one with an
in_compat_syscall() check, the x32 syscall table refers to
a __x32_sys_move_pages symbol that may not exist when the
syscall is disabled.

Change the COND_SYSCALL() definition on x86 to also include
the redirection for x32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/syscall_wrapper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..5eacd35a7f97 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -171,12 +171,16 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __X32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x32, sys_##name)
+
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x32, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_NI(name)					\
 	__SYS_NI(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
+#define __X32_COND_SYSCALL(name)
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
@@ -253,6 +257,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	static long __do_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
+	__X32_COND_SYSCALL(name)					\
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
