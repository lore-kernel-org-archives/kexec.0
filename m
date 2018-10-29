Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH2KL-0005kw-EP
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 07:51:11 +0000
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so554413pfn.8
 for <kexec@lists.infradead.org>; Mon, 29 Oct 2018 00:50:59 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 2/2] makedumpfile/x86_64: Add 'page_offset_base' reading
 capability from VMCOREINFO
Date: Mon, 29 Oct 2018 13:20:31 +0530
Message-Id: <1540799431-11064-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, Baoquan He <bhe@redhat.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>

makedumpfile '--mem-usage' use-case is currently broken on x86_64 with
latest kernels (see a sample log below with 4.19 kernel):

[root@hp-dl380pgen8-02-vm-15 ~]# makedumpfile -f --mem-usage /proc/kcore
   The kernel version is not supported.
   The makedumpfile operation may be incomplete.
   <snip..>
   set_kcore_vmcoreinfo: Can't get the offset of VMCOREINFO(/proc/kcore).
   Success

   makedumpfile Failed.

It seems that the issue is seen because KCORE_REMAP which was added
to recent kernels and appears as a PT_LOAD in '/proc/kcore'.

I have recently proposed a kernel patch which allows appending
'page_offset_base' for x86_64 platforms to vmcoreinfo, so that
user-space tools can use the same as a standard interface to determine
the start of direct mapping of all physical memory (see [0]).

This in in-line with the philosophy being proposed by kernel
maintainers where one can use the vmcoreinfo note in user-land (from
'/proc/kcore') to retrieve machine specific symbols or strings being
appended to the vmcoreinfo even for live-debugging of the
primary kernel as a standard interface exposed by kernel for
sharing machine specific details with the user-land.

With this fix, the '--mem-usage' use case works fine on the x86_64
machines even with newer kernels:

[root@ibm-x3650m4-01-vm-16 makedumpfile]# makedumpfile -f --mem-usage /proc/kcore -D
   The kernel version is not supported.
   The makedumpfile operation may be incomplete.
   <..snip..>
   Linux kdump
   VMCOREINFO PT_NOTE found in /proc/kcore
   page_size    : 4096
   info->page_offset : ffff880000000000
   <..snip..>The kernel doesn't support mmap(),read() will be used instead.

   TYPE		PAGES			EXCLUDABLE	DESCRIPTION
   ----------------------------------------------------------------------
   ZERO		20846           	yes		Pages filled with zero
   NON_PRI_CACHE	57371           	yes		Cache pages without private flag
   PRI_CACHE	1               	yes		Cache pages with private flag
   USER		13841           	yes		User process pages
   FREE		777956          	yes		Free pages
   KERN_DATA	55625           	no		Dumpable kernel data

   page size:		4096
   Total pages on system:	925640
   Total size on system:	3791421440       Byte

[0]. https://lkml.org/lkml/2018/10/27/86

I will send a follow-up patch to read 'kaslr_offset' for x86_64 cases
from vmcoreinfo inside '/proc/kcore' after this patchset is applied.

Cc: Baoquan He <bhe@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/x86_64.c  | 17 +++++++++++++++++
 makedumpfile.c |  2 ++
 makedumpfile.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 2b3c0bb356a1..a5fbdf26b8e7 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -98,6 +98,22 @@ get_page_offset_x86_64(void)
 		return TRUE;
 	}
 
+	/* Calculate 'info->page_offset'. */
+
+	/* Since kernel version 4.19, '/proc/kcore' contains a new
+	 * PT_NOTE which carries the VMCOREINFO information.
+	 *
+	 * If the same is available, use it as it already contains the
+	 * value of 'page_offset_base' on the machine.
+	 */
+	if (info->flag_kcore_contains_vmcoreinfo &&
+	    (NUMBER(page_offset_base) != NOT_FOUND_NUMBER)) {
+		page_offset_base = NUMBER(page_offset_base);
+		info->page_offset = page_offset_base;
+		DEBUG_MSG("info->page_offset : %lx\n", info->page_offset);
+		return TRUE;
+	}
+
 	if (get_num_pt_loads()) {
 		for (i = 0;
 			get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
@@ -106,6 +122,7 @@ get_page_offset_x86_64(void)
 					&& virt_start < __START_KERNEL_map
 					&& phys_start != NOT_PADDR) {
 				info->page_offset = virt_start - phys_start;
+				DEBUG_MSG("info->page_offset : %lx\n", info->page_offset);
 				return TRUE;
 			}
 		}
diff --git a/makedumpfile.c b/makedumpfile.c
index a1b8d8ff5a84..668e3ec3956c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2319,6 +2319,7 @@ write_vmcoreinfo_data(void)
 
 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	WRITE_NUMBER("phys_base", phys_base);
+	WRITE_NUMBER("page_offset_base", page_offset_base);
 
 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
 #ifdef __aarch64__
@@ -2719,6 +2720,7 @@ read_vmcoreinfo(void)
 
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
+	READ_NUMBER("page_offset_base", page_offset_base);
 #ifdef __aarch64__
 	READ_NUMBER("VA_BITS", VA_BITS);
 	READ_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
diff --git a/makedumpfile.h b/makedumpfile.h
index 77f7ec8e3867..09e14f0ef86c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1920,6 +1920,7 @@ struct number_table {
 	long	MAX_PHYSMEM_BITS;
 	long    HUGETLB_PAGE_DTOR;
 	long	phys_base;
+	unsigned long	page_offset_base;
 #ifdef __aarch64__
 	long 	VA_BITS;
 	unsigned long	PHYS_OFFSET;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
