Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beILE-0004NO-VF
 for kexec@lists.infradead.org; Mon, 29 Aug 2016 08:54:54 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] makedumpfile: Add support for MM randomization
Date: Mon, 29 Aug 2016 16:54:22 +0800
Message-Id: <1472460862-29842-4-git-send-email-bhe@redhat.com>
In-Reply-To: <1472460862-29842-1-git-send-email-bhe@redhat.com>
References: <1472460862-29842-1-git-send-email-bhe@redhat.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, thgarnie@google.com, Baoquan He <bhe@redhat.com>

In kernel patchset "x86/mm: memory area address KASLR", PAGE_OFFSET,
VMALLOC_START and VMEMMAP_START are all randomized. Please check below
link:
	https://lwn.net/Articles/692289/

And these need be exported into vmcoreinfo and tell makedumpfile. In
this patch get and handle them to support MM randomization.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86_64.c  | 26 +++++++++-----------------
 makedumpfile.c | 29 ++++++++++++++++++++++++++++-
 makedumpfile.h |  3 +++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index ddf7be6..ff787cc 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -146,8 +146,9 @@ get_machdep_info_x86_64(void)
 	return TRUE;
 }
 
-int
-get_versiondep_info_x86_64(void)
+#define VMALLOC_SIZE            (0x200000000000)
+#define VMEMMAP_SIZE            (0x10000000000)
+int get_versiondep_info_x86_64(void)
 {
 	/*
 	 * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
@@ -159,22 +160,13 @@ get_versiondep_info_x86_64(void)
 	else
 		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
 
-	if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
-		info->page_offset = __PAGE_OFFSET_ORIG;
-	else
-		info->page_offset = __PAGE_OFFSET_2_6_27;
+	info->page_offset = NUMBER(page_offset);
 
-	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
-		info->vmalloc_start = VMALLOC_START_ORIG;
-		info->vmalloc_end   = VMALLOC_END_ORIG;
-		info->vmemmap_start = VMEMMAP_START_ORIG;
-		info->vmemmap_end   = VMEMMAP_END_ORIG;
-	} else {
-		info->vmalloc_start = VMALLOC_START_2_6_31;
-		info->vmalloc_end   = VMALLOC_END_2_6_31;
-		info->vmemmap_start = VMEMMAP_START_2_6_31;
-		info->vmemmap_end   = VMEMMAP_END_2_6_31;
-	}
+
+	info->vmalloc_start = NUMBER(vmalloc_start);
+	info->vmalloc_end   = info->vmalloc_start + VMALLOC_SIZE - 1;
+	info->vmemmap_start = NUMBER(vmemmap_start);
+	info->vmemmap_end   = info->vmemmap_start + VMEMMAP_SIZE - 1;
 
 	return TRUE;
 }
diff --git a/makedumpfile.c b/makedumpfile.c
index 2713f8a..6b0c6ab 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1985,6 +1985,7 @@ get_value_for_old_linux(void)
 			NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) =
 			PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_39_to_latest_version;
 	}
+	ERRMSG("info->kernel_version=%d\n", info->kernel_version);
 #ifdef __x86_64__
 	if (NUMBER(KERNEL_IMAGE_SIZE) == NOT_FOUND_NUMBER) {
 		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
@@ -1992,6 +1993,26 @@ get_value_for_old_linux(void)
 		else
 			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_2_6_26;
 	}
+	if (NUMBER(page_offset) == NOT_FOUND_NUMBER) {
+		if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
+			NUMBER(page_offset) = __PAGE_OFFSET_ORIG;
+		else
+			NUMBER(page_offset) = __PAGE_OFFSET_2_6_27;
+	}
+	if (NUMBER(vmalloc_start) == NOT_FOUND_NUMBER) {
+		if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
+			NUMBER(vmalloc_start) = VMALLOC_START_ORIG;
+		} else {
+			NUMBER(vmalloc_start) = VMALLOC_START_2_6_31;
+		}
+	}
+	if (NUMBER(vmemmap_start) == NOT_FOUND_NUMBER) {
+		if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
+			NUMBER(vmemmap_start) = VMEMMAP_START_ORIG;
+		else
+			NUMBER(vmemmap_start) = VMEMMAP_START_2_6_31;
+	}
+
 #endif
 	if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
 		if (info->kernel_version >= KERNEL_VERSION(2, 6, 27))
@@ -2249,6 +2270,9 @@ write_vmcoreinfo_data(void)
 
 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
+	WRITE_NUMBER("PAGE_OFFSET", page_offset);
+	WRITE_NUMBER("VMALLOC_START", vmalloc_start);
+	WRITE_NUMBER("VMEMMAP_START", vmemmap_start);
 
 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 
@@ -2595,6 +2619,9 @@ read_vmcoreinfo(void)
 
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
+	READ_NUMBER("PAGE_OFFSET", page_offset);
+	READ_NUMBER("VMALLOC_START", vmalloc_start);
+	READ_NUMBER("VMEMMAP_START", vmemmap_start);
 
 	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 
@@ -3826,7 +3853,7 @@ initial(void)
 		debug_info = TRUE;
 	}
 
-	info->kernel_version = get_kernel_version(info.release);
+	info->kernel_version = get_kernel_version(info->release);
 	if (info->kernel_version == FALSE) {
 		ERRMSG("Can't get the kernel version.\n");
 		return FALSE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 533e5b8..0e34fae 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1685,6 +1685,9 @@ struct number_table {
 
 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
 	long	KERNEL_IMAGE_SIZE;
+	long	page_offset;
+	long	vmalloc_start;
+	long	vmemmap_start;
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
 	long    HUGETLB_PAGE_DTOR;
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
