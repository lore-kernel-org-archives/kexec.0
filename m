Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from email6.ustc.edu.cn ([2001:da8:d800::8] helo=ustc.edu.cn)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ls3UA-008ZF1-Uo
 for kexec@lists.infradead.org; Sat, 12 Jun 2021 13:15:43 +0000
Date: Sat, 12 Jun 2021 21:09:53 +0800
From: Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Subject: [PATCH] fs/proc/vmcore: hide mmap_vmcore_fault() and
 vmcore_mmap_ops for nommu
Message-ID: <20210612210953.34dff323@xhacker>
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
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Without CONFIG_MMU, we get a W=1 build warning:

fs/proc/vmcore.c:443:42: warning: unused variable 'vmcore_mmap_ops' [-Wunused-const-variable]
static const struct vm_operations_struct vmcore_mmap_ops = {

The vmcore_mmap_ops is only referenced from an #ifdef'ed caller, so
this uses the same #ifdef around vmcore_mmap_ops and mmap_vmcore_fault().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 fs/proc/vmcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334da208..d902a67cc3ea 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -401,6 +401,7 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
 }
 
+#ifdef CONFIG_MMU
 /*
  * The vmcore fault handler uses the page cache and fills data using the
  * standard __vmcore_read() function.
@@ -443,6 +444,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 static const struct vm_operations_struct vmcore_mmap_ops = {
 	.fault = mmap_vmcore_fault,
 };
+#endif
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
-- 
2.32.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
