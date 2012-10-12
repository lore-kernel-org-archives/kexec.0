Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TMZ0z-00065c-56
 for kexec@lists.infradead.org; Fri, 12 Oct 2012 06:46:33 +0000
Message-ID: <5077BC82.6050105@cn.fujitsu.com>
Date: Fri, 12 Oct 2012 14:45:22 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] sysctl: introduce a new interface to control
 kdump-vmcs-clear behaviour
References: <5077BB7B.4030203@cn.fujitsu.com>
In-Reply-To: <5077BB7B.4030203@cn.fujitsu.com>
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
To: x86@kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: linux-kernel@vger.kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

This patch exports the variable clear_loaded_vmcs_enabled to userspace.

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 Documentation/sysctl/kernel.txt |    8 ++++++++
 kernel/sysctl.c                 |   10 ++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 6d78841..038148b 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -25,6 +25,7 @@ show up in /proc/sys/kernel:
 - bootloader_version	     [ X86 only ]
 - callhome		     [ S390 only ]
 - cap_last_cap
+- clear_loaded_vmcs	     [ X86 only ]
 - core_pattern
 - core_pipe_limit
 - core_uses_pid
@@ -164,6 +165,13 @@ CAP_LAST_CAP from the kernel.
 
 ==============================================================
 
+clear_loaded_vmcs
+
+Controls if VMCSs should be cleared when host is doing kdump.  Exports
+clear_loaded_vmcs_enabled from the kernel.
+
+==============================================================
+
 core_pattern:
 
 core_pattern is used to specify a core dumpfile pattern name.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4ab1187..3ab7d9c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -63,6 +63,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
+#include <asm/kexec.h>
 
 #ifdef CONFIG_X86
 #include <asm/nmi.h>
@@ -994,6 +995,15 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_KEXEC
+	{
+		.procname	= "clear_loaded_vmcs",
+		.data		= &clear_loaded_vmcs_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
 	{ }
 };
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
