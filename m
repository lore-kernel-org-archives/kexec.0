Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from isilmar-4.linta.de ([136.243.71.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1VhA-0004tl-VT
 for kexec@lists.infradead.org; Thu, 29 Mar 2018 11:26:19 +0000
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 102/109] kexec: move sys_kexec_load() prototype to syscalls.h
Date: Thu, 29 Mar 2018 13:24:19 +0200
Message-Id: <20180329112426.23043-103-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
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
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, kexec@lists.infradead.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, Eric Biederman <ebiederm@xmission.com>

As the syscall function should only be called from the system call table
but not from elsewhere in the kernel, move the prototype for
sys_kexec_load() to include/syscall.h.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/kexec.h    | 4 ----
 include/linux/syscalls.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f16f6ceb3875..0ebcbeb21056 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -223,10 +223,6 @@ struct kimage {
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
-extern asmlinkage long sys_kexec_load(unsigned long entry,
-					unsigned long nr_segments,
-					struct kexec_segment __user *segments,
-					unsigned long flags);
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 815fbdd9cca1..8330f046541e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -936,6 +936,10 @@ asmlinkage long sys_pkey_mprotect(unsigned long start, size_t len,
 				  unsigned long prot, int pkey);
 asmlinkage long sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 asmlinkage long sys_pkey_free(int pkey);
+asmlinkage long sys_kexec_load(unsigned long entry,
+			       unsigned long nr_segments,
+			       struct kexec_segment __user *segments,
+			       unsigned long flags);
 asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 
-- 
2.16.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
