Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TiLuG-0002Xy-6x
 for kexec@lists.infradead.org; Tue, 11 Dec 2012 09:13:40 +0000
Message-ID: <50C6F8C6.9000008@cn.fujitsu.com>
Date: Tue, 11 Dec 2012 17:11:34 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] [RESEND] x86/kexec: crash_vmclear_local_vmcss needs __rcu
References: <50C18168.305@cn.fujitsu.com>
In-Reply-To: <50C18168.305@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Gleb Natapov <gleb@redhat.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

This removes the sparse warning:
arch/x86/kernel/crash.c:49:32: sparse: incompatible types in comparison expression (different address spaces)

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/include/asm/kexec.h |    3 ++-
 arch/x86/kernel/crash.c      |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 28feeba..6080d26 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -163,7 +163,8 @@ struct kimage_arch {
 };
 #endif
 
-extern void (*crash_vmclear_loaded_vmcss)(void);
+typedef void crash_vmclear_fn(void);
+extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2f6b8e8..74467fe 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -38,12 +38,12 @@ int in_crash_kexec;
  *
  * protected by rcu.
  */
-void (*crash_vmclear_loaded_vmcss)(void) = NULL;
+crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss = NULL;
 EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
 
 static inline void cpu_crash_vmclear_loaded_vmcss(void)
 {
-	void (*do_vmclear_operation)(void) = NULL;
+	crash_vmclear_fn *do_vmclear_operation = NULL;
 
 	rcu_read_lock();
 	do_vmclear_operation = rcu_dereference(crash_vmclear_loaded_vmcss);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
