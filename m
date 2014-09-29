Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYamn-0004M2-49
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 13:14:41 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 29 Sep 2014 14:14:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6CB2C1B0805F
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 14:15:26 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8TDEEDh54001690
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 13:14:14 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8TDEEpg006132
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 07:14:14 -0600
Date: Mon, 29 Sep 2014 15:14:13 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20140929151413.4e9bd1ab@holzheu>
In-Reply-To: <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Implement is_vmalloc_addr() using /proc/iommem parsing to enable the new
makedumpfile option "--mem-usage".

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |   26 ++++++++++++++++++++++++++
 makedumpfile.h |    3 ++-
 2 files changed, 28 insertions(+), 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9227,6 +9227,32 @@ int is_crashkernel_mem_reserved(void)
 	return !!crash_reserved_mem_nr;
 }
 
+struct addr_check {
+	unsigned long addr;
+	int found;
+};
+
+static int phys_addr_callback(void *data, int nr, char *str,
+			      unsigned long base, unsigned long length)
+{
+	struct addr_check *addr_check = data;
+	unsigned long addr = addr_check->addr;
+
+	if (addr >= base && addr < base + length) {
+		addr_check->found = 1;
+		return -1;
+	}
+	return 0;
+}
+
+int is_iomem_phys_addr(unsigned long addr)
+{
+	struct addr_check addr_check = {addr, 0};
+
+	iomem_for_each_line("System RAM\n", phys_addr_callback, &addr_check);
+	return addr_check.found;
+}
+
 static int get_page_offset(void)
 {
 	struct utsname utsname;
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -820,7 +820,7 @@ unsigned long long vaddr_to_paddr_s390x(
 #define get_machdep_info()	get_machdep_info_s390x()
 #define get_versiondep_info()	TRUE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
-#define is_vmalloc_addr(X)	TRUE
+#define is_vmalloc_addr(X)	(!is_iomem_phys_addr(X))
 #endif          /* s390x */
 
 #ifdef __ia64__ /* ia64 */
@@ -1567,6 +1567,7 @@ int read_disk_dump_header(struct disk_du
 int read_kdump_sub_header(struct kdump_sub_header *kh, char *filename);
 void close_vmcoreinfo(void);
 int close_files_for_creating_dumpfile(void);
+int is_iomem_phys_addr(unsigned long addr);
 
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
