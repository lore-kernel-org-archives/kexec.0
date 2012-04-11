Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHmpe-0001y3-B6
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 01:58:50 +0000
Message-ID: <4F84E54A.1080903@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 09:58:34 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 4/4] kexec: Add crash_save_vmcsinfo to update VMCSINFO
References: <4F84E0DF.8040206@cn.fujitsu.com>
In-Reply-To: <4F84E0DF.8040206@cn.fujitsu.com>
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
To: avi@redhat.com, mtosatti@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, gregkh@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

crash_save_vmcsinfo updates the VMCSINFO when kernel crashes.
If no VMCSINFO has been saved before, this function will do nothing.

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 include/linux/kexec.h |    1 +
 kernel/kexec.c        |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0d7d6a1..6e8ff13 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -145,6 +145,7 @@ void arch_crash_save_vmcoreinfo(void);
 __printf(1, 2)
 void vmcoreinfo_append_str(const char *fmt, ...);
 unsigned long paddr_vmcoreinfo_note(void);
+void crash_save_vmcsinfo(void);
 
 #define VMCOREINFO_OSRELEASE(value) \
 	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 4e2e472..19843ef 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -38,6 +38,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/sections.h>
+#include <asm/vmcsinfo.h>
 
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
@@ -1094,6 +1095,7 @@ void crash_kexec(struct pt_regs *regs)
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
+			crash_save_vmcsinfo();
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
@@ -1458,6 +1460,18 @@ unsigned long __attribute__ ((weak)) paddr_vmcoreinfo_note(void)
 	return __pa((unsigned long)(char *)&vmcoreinfo_note);
 }
 
+#ifdef CONFIG_X86
+void crash_save_vmcsinfo(void)
+{
+	if (!vmcsinfo_size)
+		return;
+	vmcsinfo_append_str("CRASHTIME=%ld", get_seconds());
+	update_vmcsinfo_note();
+}
+#else
+void crash_save_vmcsinfo(void) {}
+#endif /* CONFIG_X86 */
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
