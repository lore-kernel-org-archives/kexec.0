Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byiRc-0006MW-5G
 for kexec@lists.infradead.org; Mon, 24 Oct 2016 16:49:53 +0000
Received: by mail-qk0-f173.google.com with SMTP id x11so34945290qka.1
 for <kexec@lists.infradead.org>; Mon, 24 Oct 2016 09:49:30 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 3/4] x86_64: kill is_vmalloc_addr_x86_64()
Date: Mon, 24 Oct 2016 22:18:45 +0530
Message-Id: <81ec62b304f3a1e28e128e19d2744ffed2e4cf65.1477327674.git.panand@redhat.com>
In-Reply-To: <cover.1477327674.git.panand@redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
In-Reply-To: <cover.1477327674.git.panand@redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

From kernel documentation:
ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
ffffffffa0000000 - ffffffffff5fffff (=1526 MB) module mapping space

So, it is only the module area which is lying above __START_KERNEL_map.
However, kexec-tools only creates PT_LOAD segments for kernel text region
and crash memory region. So, we can safely remove the check for
!is_vmalloc_addr_x86_64() from get_phys_base_x86_64().

Since, this was the last usage of is_vmalloc_addr_x86_64(), so kill it as
well.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c  | 14 +-------------
 makedumpfile.h |  3 +--
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index fe2764a8bec2..597cdac36dfc 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -21,17 +21,6 @@
 extern struct vmap_pfns *gvmem_pfns;
 extern int nr_gvmem_pfns;
 
-int
-is_vmalloc_addr_x86_64(ulong vaddr)
-{
-	/*
-	 *  vmalloc, virtual memmap, and module space as VMALLOC space.
-	 */
-	return ((vaddr >= VMALLOC_START && vaddr <= VMALLOC_END)
-	    || (vaddr >= VMEMMAP_START && vaddr <= VMEMMAP_END)
-	    || (vaddr >= MODULES_VADDR && vaddr <= MODULES_END));
-}
-
 static unsigned long
 get_xen_p2m_mfn(void)
 {
@@ -75,8 +64,7 @@ get_phys_base_x86_64(void)
 	info->phys_base = 0; /* default/traditional */
 
 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
-		if ((virt_start >= __START_KERNEL_map) &&
-		    !(is_vmalloc_addr_x86_64(virt_start))) {
+		if (virt_start >= __START_KERNEL_map) {
 
 			info->phys_base = phys_start -
 			    (virt_start & ~(__START_KERNEL_map));
diff --git a/makedumpfile.h b/makedumpfile.h
index 13559651feb6..8a96da1f61bd 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -859,7 +859,6 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
 #endif /* x86 */
 
 #ifdef __x86_64__
-int is_vmalloc_addr_x86_64(ulong vaddr);
 int get_phys_base_x86_64(void);
 int get_machdep_info_x86_64(void);
 int get_versiondep_info_x86_64(void);
@@ -869,7 +868,7 @@ unsigned long long vtop4_x86_64(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_x86_64()
 #define get_versiondep_info()	get_versiondep_info_x86_64()
 #define vaddr_to_paddr(X)	vtop4_x86_64(X)
-#define is_phys_addr(X)		(!is_vmalloc_addr_x86_64(X))
+#define is_phys_addr(X)		stub_true_ul(X)
 #endif /* x86_64 */
 
 #ifdef __powerpc64__ /* powerpc64 */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
