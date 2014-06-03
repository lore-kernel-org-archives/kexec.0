Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WroS8-0001D2-Pe
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 13:08:33 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 06/13] kexec: New syscall kexec_file_load() declaration
Date: Tue,  3 Jun 2014 09:06:55 -0400
Message-Id: <1401800822-27425-7-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, hpa@zytor.com, Vivek Goyal <vgoyal@redhat.com>, bp@alien8.de, ebiederm@xmission.com, greg@kroah.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

This is the new syscall kexec_file_load() declaration/interface. I have
reserved the syscall number only for x86_64 so far. Other architectures
(including i386) can reserve syscall number when they enable the support
for this new syscall.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 arch/x86/syscalls/syscall_64.tbl | 1 +
 include/linux/syscalls.h         | 3 +++
 kernel/kexec.c                   | 7 +++++++
 kernel/sys_ni.c                  | 1 +
 4 files changed, 12 insertions(+)

diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_64.tbl
index 04376ac..94482db 100644
--- a/arch/x86/syscalls/syscall_64.tbl
+++ b/arch/x86/syscalls/syscall_64.tbl
@@ -323,6 +323,7 @@
 314	common	sched_setattr		sys_sched_setattr
 315	common	sched_getattr		sys_sched_getattr
 316	common	renameat2		sys_renameat2
+317	common	kexec_file_load		sys_kexec_file_load
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a4a0588..9db7555 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -317,6 +317,9 @@ asmlinkage long sys_restart_syscall(void);
 asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 				struct kexec_segment __user *segments,
 				unsigned long flags);
+asmlinkage long sys_kexec_file_load(int kernel_fd, int initrd_fd,
+				const char __user *cmdline_ptr,
+				unsigned long cmdline_len, unsigned long flags);
 
 asmlinkage long sys_exit(int error_code);
 asmlinkage long sys_exit_group(int error_code);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index c435c5f..a3044e6 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1098,6 +1098,13 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 }
 #endif
 
+SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
+		const char __user *, cmdline_ptr, unsigned long,
+		cmdline_len, unsigned long, flags)
+{
+	return -ENOSYS;
+}
+
 void crash_kexec(struct pt_regs *regs)
 {
 	/* Take the kexec_mutex here to prevent sys_kexec_load
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index bc8d1b7..4534626 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -25,6 +25,7 @@ cond_syscall(sys_swapon);
 cond_syscall(sys_swapoff);
 cond_syscall(sys_kexec_load);
 cond_syscall(compat_sys_kexec_load);
+cond_syscall(sys_kexec_file_load);
 cond_syscall(sys_init_module);
 cond_syscall(sys_finit_module);
 cond_syscall(sys_delete_module);
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
