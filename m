Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icGdq-000144-Qw
 for kexec@lists.infradead.org; Tue, 03 Dec 2019 22:27:36 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB3MC6HO048678
 for <kexec@lists.infradead.org>; Tue, 3 Dec 2019 17:27:31 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wnp6647dp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 03 Dec 2019 17:27:31 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zaslonko@linux.ibm.com>;
 Tue, 3 Dec 2019 22:27:29 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH] makedumpfile/s390: Add get_kaslr_offset() for s390x
Date: Tue,  3 Dec 2019 23:27:25 +0100
Message-Id: <20191203222725.64734-1-zaslonko@linux.ibm.com>
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
Cc: prudo@linux.ibm.com, k-hagio@ab.jp.nec.com, dyoung@redhat.com

Since kernel v5.2 KASLR is supported on s390. In makedumpfile however no
support has been added yet. This patch adds the arch specific function
get_kaslr_offset() for s390x.
Since the values in vmcoreinfo are already relocated, the patch is
mainly relevant for vmlinux processing (-x option).

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390x.c   | 32 ++++++++++++++++++++++++++++++++
 makedumpfile.h |  3 ++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index bf9d58e..892df14 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -122,6 +122,38 @@ get_machdep_info_s390x(void)
 	return TRUE;
 }
 
+unsigned long
+get_kaslr_offset_s390x(unsigned long vaddr)
+{
+	unsigned int i;
+	char buf[BUFSIZE_FGETS], *endp;
+
+	if (!info->file_vmcoreinfo)
+		return FALSE;
+
+	if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
+		       info->name_vmcoreinfo, strerror(errno));
+		return FALSE;
+	}
+
+	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
+		i = strlen(buf);
+		if (!i)
+			break;
+		if (buf[i - 1] == '\n')
+			buf[i - 1] = '\0';
+		if (strncmp(buf, STR_KERNELOFFSET,
+			    strlen(STR_KERNELOFFSET)) == 0) {
+			info->kaslr_offset =
+				strtoul(buf + strlen(STR_KERNELOFFSET), &endp, 16);
+			DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
+		}
+	}
+
+	return info->kaslr_offset;
+}
+
 static int
 is_vmalloc_addr_s390x(unsigned long vaddr)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index ac11e90..26f6247 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1071,11 +1071,12 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
 int get_machdep_info_s390x(void);
 unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
 int is_iomem_phys_addr_s390x(unsigned long addr);
+unsigned long get_kaslr_offset_s390x(unsigned long vaddr);
 #define find_vmemmap()		stub_false()
 #define get_phys_base()		stub_true()
 #define get_machdep_info()	get_machdep_info_s390x()
 #define get_versiondep_info()	stub_true()
-#define get_kaslr_offset(X)	stub_false()
+#define get_kaslr_offset(X)	get_kaslr_offset_s390x(X)
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
 #define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
