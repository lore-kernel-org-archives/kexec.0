Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2w9N-0008Ai-0v
 for kexec@lists.infradead.org; Sun, 10 Mar 2019 10:57:51 +0000
Received: by mail-pf1-f193.google.com with SMTP id n125so1543393pfn.5
 for <kexec@lists.infradead.org>; Sun, 10 Mar 2019 03:57:48 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 1/3] tree-wide: Retrieve 'MAX_PHYSMEM_BITS' from vmcoreinfo
 (if available)
Date: Sun, 10 Mar 2019 16:27:33 +0530
Message-Id: <1552215455-12696-2-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1552215455-12696-1-git-send-email-bhsharma@redhat.com>
References: <1552215455-12696-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: bhupesh.linux@gmail.com, bhsharma@redhat.com, k-hagio@ab.jp.nec.com

This patch adds a common feature for archs (except arm64, for which
similar support is added via subsequent patch) to retrieve
'MAX_PHYSMEM_BITS' from vmcoreinfo (if available).

I recently posted a kernel patch (see [0]) which appends
'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself rather than
in arch-specific code, so that user-space code can also benefit from
this addition to the vmcoreinfo and use it as a standard way of
determining 'SECTIONS_SHIFT' value in 'makedumpfile' utility.

This patch ensures backward compatibility for kernel versions in which
'MAX_PHYSMEM_BITS' is not available in vmcoreinfo.

[0]. http://lists.infradead.org/pipermail/kexec/2019-March/022531.html

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm.c     |  8 +++++++-
 arch/ia64.c    |  7 ++++++-
 arch/ppc.c     |  8 +++++++-
 arch/ppc64.c   | 49 ++++++++++++++++++++++++++++---------------------
 arch/s390x.c   | 29 ++++++++++++++++++-----------
 arch/sparc64.c |  9 +++++++--
 arch/x86.c     | 34 ++++++++++++++++++++--------------
 arch/x86_64.c  | 27 ++++++++++++++++-----------
 8 files changed, 109 insertions(+), 62 deletions(-)

diff --git a/arch/arm.c b/arch/arm.c
index af7442ac70bf..33536fc4dfc9 100644
--- a/arch/arm.c
+++ b/arch/arm.c
@@ -81,7 +81,13 @@ int
 get_machdep_info_arm(void)
 {
 	info->page_offset = SYMBOL(_stext) & 0xffff0000UL;
-	info->max_physmem_bits = _MAX_PHYSMEM_BITS;
+
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else
+		info->max_physmem_bits = _MAX_PHYSMEM_BITS;
+
 	info->kernel_start = SYMBOL(_stext);
 	info->section_size_bits = _SECTION_SIZE_BITS;
 
diff --git a/arch/ia64.c b/arch/ia64.c
index 6c33cc7c8288..fb44dda47172 100644
--- a/arch/ia64.c
+++ b/arch/ia64.c
@@ -85,7 +85,12 @@ get_machdep_info_ia64(void)
 	}
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
 
 	return TRUE;
 }
diff --git a/arch/ppc.c b/arch/ppc.c
index 37c6a3b60cd3..ed9447427a30 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -31,7 +31,13 @@ get_machdep_info_ppc(void)
 	unsigned long vmlist, vmap_area_list, vmalloc_start;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+
 	info->page_offset = __PAGE_OFFSET;
 
 	if (SYMBOL(_stext) != NOT_FOUND_SYMBOL)
diff --git a/arch/ppc64.c b/arch/ppc64.c
index 9d8f2525f608..a3984eebdced 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -466,30 +466,37 @@ int
 set_ppc64_max_physmem_bits(void)
 {
 	long array_len = ARRAY_LENGTH(mem_section);
-	/*
-	 * The older ppc64 kernels uses _MAX_PHYSMEM_BITS as 42 and the
-	 * newer kernels 3.7 onwards uses 46 bits.
-	 */
-
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
-	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
-		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
-		return TRUE;
-
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_7;
-	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
-		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
-		return TRUE;
 
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
-	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
-		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
 		return TRUE;
+	} else {
+		/*
+		 * The older ppc64 kernels uses _MAX_PHYSMEM_BITS as 42 and the
+		 * newer kernels 3.7 onwards uses 46 bits.
+		 */
 
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
-	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
-		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
-		return TRUE;
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
+		if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+				|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+			return TRUE;
+
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_7;
+		if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+				|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+			return TRUE;
+
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
+		if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+				|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+			return TRUE;
+
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
+		if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+				|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+			return TRUE;
+	}
 
 	return FALSE;
 }
diff --git a/arch/s390x.c b/arch/s390x.c
index bf9d58e54fb7..4d17a783e5bd 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -63,20 +63,27 @@ int
 set_s390x_max_physmem_bits(void)
 {
 	long array_len = ARRAY_LENGTH(mem_section);
-	/*
-	 * The older s390x kernels uses _MAX_PHYSMEM_BITS as 42 and the
-	 * newer kernels uses 46 bits.
-	 */
 
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
-	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
-		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
 		return TRUE;
+	} else {
+		/*
+		 * The older s390x kernels uses _MAX_PHYSMEM_BITS as 42 and the
+		 * newer kernels uses 46 bits.
+		 */
 
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_3;
-	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
-		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
-		return TRUE;
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
+		if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+				|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+			return TRUE;
+
+		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_3;
+		if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+				|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+			return TRUE;
+	}
 
 	return FALSE;
 }
diff --git a/arch/sparc64.c b/arch/sparc64.c
index 1cfaa854ce6d..b93a05bdfe59 100644
--- a/arch/sparc64.c
+++ b/arch/sparc64.c
@@ -25,10 +25,15 @@ int get_versiondep_info_sparc64(void)
 {
 	info->section_size_bits = _SECTION_SIZE_BITS;
 
-	if (info->kernel_version >= KERNEL_VERSION(3, 8, 13))
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else if (info->kernel_version >= KERNEL_VERSION(3, 8, 13))
 		info->max_physmem_bits = _MAX_PHYSMEM_BITS_L4;
-	else {
+	else
 		info->max_physmem_bits = _MAX_PHYSMEM_BITS_L3;
+
+	if (info->kernel_version < KERNEL_VERSION(3, 8, 13)) {
 		info->flag_vmemmap = TRUE;
 		info->vmemmap_start = VMEMMAP_BASE_SPARC64;
 		info->vmemmap_end = VMEMMAP_BASE_SPARC64 +
diff --git a/arch/x86.c b/arch/x86.c
index 3fdae93084b8..f1b43d4c8179 100644
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -72,21 +72,27 @@ get_machdep_info_x86(void)
 {
 	unsigned long vmlist, vmap_area_list, vmalloc_start;
 
-	/* PAE */
-	if ((vt.mem_flags & MEMORY_X86_PAE)
-	    || ((SYMBOL(pkmap_count) != NOT_FOUND_SYMBOL)
-	      && (SYMBOL(pkmap_count_next) != NOT_FOUND_SYMBOL)
-	      && ((SYMBOL(pkmap_count_next)-SYMBOL(pkmap_count))/sizeof(int))
-	      == 512)) {
-		DEBUG_MSG("\n");
-		DEBUG_MSG("PAE          : ON\n");
-		vt.mem_flags |= MEMORY_X86_PAE;
-		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_PAE;
-	} else {
-		DEBUG_MSG("\n");
-		DEBUG_MSG("PAE          : OFF\n");
-		info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	else {
+		/* PAE */
+		if ((vt.mem_flags & MEMORY_X86_PAE)
+				|| ((SYMBOL(pkmap_count) != NOT_FOUND_SYMBOL)
+					&& (SYMBOL(pkmap_count_next) != NOT_FOUND_SYMBOL)
+					&& ((SYMBOL(pkmap_count_next)-SYMBOL(pkmap_count))/sizeof(int))
+					== 512)) {
+			DEBUG_MSG("\n");
+			DEBUG_MSG("PAE          : ON\n");
+			vt.mem_flags |= MEMORY_X86_PAE;
+			info->max_physmem_bits  = _MAX_PHYSMEM_BITS_PAE;
+		} else {
+			DEBUG_MSG("\n");
+			DEBUG_MSG("PAE          : OFF\n");
+			info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+		}
 	}
+
 	info->page_offset = __PAGE_OFFSET;
 
 	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
diff --git a/arch/x86_64.c b/arch/x86_64.c
index 9db1f8139f28..98747fa883ef 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -259,17 +259,22 @@ get_machdep_info_x86_64(void)
 int
 get_versiondep_info_x86_64(void)
 {
-	/*
-	 * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
-	 */
-	if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
-		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
-	else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
-		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
-	else if(check_5level_paging())
-		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
-	else
-		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
+	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
+	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER) {
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+	} else {
+		/*
+		 * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
+		 */
+		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
+			info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
+		else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
+			info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
+		else if(check_5level_paging())
+			info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
+		else
+			info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
+	}
 
 	if (!get_page_offset_x86_64())
 		return FALSE;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
