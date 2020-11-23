Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kh3cV-0006zQ-4t
 for kexec@lists.infradead.org; Mon, 23 Nov 2020 04:38:31 +0000
Received: by mail-pg1-x541.google.com with SMTP id w4so13057548pgg.13
 for <kexec@lists.infradead.org>; Sun, 22 Nov 2020 20:38:30 -0800 (PST)
From: Alexander Kamensky <alexander.kamensky42@gmail.com>
Subject: [RFC PATCH 3/3] arm64: use kernel version from OSRELEASE to determine
 linear mapping position
Date: Sun, 22 Nov 2020 20:37:58 -0800
Message-Id: <20201123043758.105713-4-alexander.kamensky42@gmail.com>
In-Reply-To: <20201123043758.105713-1-alexander.kamensky42@gmail.com>
References: <20201123043758.105713-1-alexander.kamensky42@gmail.com>
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
To: kexec@lists.infradead.org, Kazuhito Hagio <k-hagio-ab@nec.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: Alexander Kamensky <alexander.kamensky42@gmail.com>

Address mailing list review comment that for determining linear mapping
use (before/after 5.4 kernel linear mapping swap) of OSRELEASE from vmcore
rather than kernel version that makedumpfile is currently running on.

Specifically:

- user info->release_kernel_version added by previous commit, instead of
info->kernel_version

- remove early call to populate_kernel_version from arm64.c

Signed-off-by: Alexander Kamensky <alexander.kamensky42@gmail.com>
---
 arch/arm64.c   | 10 +++-------
 makedumpfile.c |  2 +-
 makedumpfile.h |  3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 7fd7039..f72035e 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -236,7 +236,7 @@ pmd_page_paddr(pmd_t pmd)
  * space. Testing the top bit for the start of the region is a
  * sufficient check and avoids having to worry about the tag.
  */
-#define is_linear_addr(addr)	((info->kernel_version < KERNEL_VERSION(5, 4, 0)) ?	\
+#define is_linear_addr(addr)	((info->release_kernel_version < KERNEL_VERSION(5, 4, 0)) ?	\
 	(!!((unsigned long)(addr) & (1UL << (vabits_actual - 1)))) : \
 	(!((unsigned long)(addr) & (1UL << (vabits_actual - 1)))))
 
@@ -245,7 +245,7 @@ __pa(unsigned long vaddr)
 {
 	if (kimage_voffset == NOT_FOUND_NUMBER ||
 			is_linear_addr(vaddr)) {
-		if (info->kernel_version < KERNEL_VERSION(5, 4, 0))
+		if (info->release_kernel_version < KERNEL_VERSION(5, 4, 0))
 			return ((vaddr & ~PAGE_OFFSET) + info->phys_base);
 		else
 			return (vaddr + info->phys_base - PAGE_OFFSET);
@@ -492,15 +492,11 @@ get_page_offset_arm64(void)
 					vabits_actual);
 	}
 
-	if (!populate_kernel_version()) {
-		ERRMSG("Cannot get information about current kernel\n");
-		return;
-	}
 
 	/* See arch/arm64/include/asm/memory.h for more details of
 	 * the PAGE_OFFSET calculation.
 	 */
-	if (info->kernel_version < KERNEL_VERSION(5, 4, 0))
+	if (info->release_kernel_version < KERNEL_VERSION(5, 4, 0))
 		info->page_offset = ((0xffffffffffffffffUL) -
 				((1UL) << (vabits_actual - 1)) + 1);
 	else
diff --git a/makedumpfile.c b/makedumpfile.c
index e2b0bc2..c352d4f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1133,7 +1133,7 @@ fallback_to_current_page_size(void)
 	return TRUE;
 }
 
-int populate_kernel_version(void)
+static int populate_kernel_version(void)
 {
 	struct utsname utsname;
 
diff --git a/makedumpfile.h b/makedumpfile.h
index b36766a..58657b4 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -974,7 +974,7 @@ unsigned long long vaddr_to_paddr_arm64(unsigned long vaddr);
 int get_versiondep_info_arm64(void);
 int get_xen_basic_info_arm64(void);
 int get_xen_info_arm64(void);
-#define paddr_to_vaddr_arm64(X) ((info->kernel_version < KERNEL_VERSION(5, 4, 0)) ?	\
+#define paddr_to_vaddr_arm64(X) ((info->release_kernel_version < KERNEL_VERSION(5, 4, 0)) ? \
 				 ((X) - (info->phys_base - PAGE_OFFSET)) :		\
 				 (((X) - info->phys_base) | PAGE_OFFSET))
 
@@ -2393,6 +2393,5 @@ ulong htol(char *s, int flags);
 int hexadecimal(char *s, int count);
 int decimal(char *s, int count);
 int file_exists(char *file);
-int populate_kernel_version(void);
 
 #endif /* MAKEDUMPFILE_H */
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
