Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5D7d-0005Kq-Hs
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 16:57:12 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8QGs1Jd007342
 for <kexec@lists.infradead.org>; Wed, 26 Sep 2018 12:56:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mrdrbgxev-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 26 Sep 2018 12:56:34 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.ibm.com>;
 Wed, 26 Sep 2018 17:56:31 +0100
Subject: [PATCH] makedumpfile/ppc64: increase MAX_PHYSMEM_BITS to 128TB
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Wed, 26 Sep 2018 22:26:26 +0530
MIME-Version: 1.0
Message-Id: <153798098618.3701.11236762967901266676.stgit@hbathini.in.ibm.com>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Kexec-ml <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>, Petr Tesarik <ptesarik@suse.cz>

* Required for kernel 4.19

With kernel commit 7d4340bb92a9 ("powerpc/mm: Increase MAX_PHYSMEM_BITS
to 128TB with SPARSEMEM_VMEMMAP config"), MAX_PHYSMEM_BITS is bumped up
to 47. Make the appropriate update here.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/ppc64.c   |    5 +++++
 makedumpfile.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 8b6f7d5..947a125 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -481,6 +481,11 @@ set_ppc64_max_physmem_bits(void)
 		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
 		return TRUE;
 
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
 	return FALSE;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index d1fcd87..46ebe2e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -673,6 +673,7 @@ unsigned long get_kvbase_arm64(void);
 #define _SECTION_SIZE_BITS	(24)
 #define _MAX_PHYSMEM_BITS_ORIG  (44)
 #define _MAX_PHYSMEM_BITS_3_7   (46)
+#define _MAX_PHYSMEM_BITS_4_19  (47)
 #define REGION_SHIFT            (60UL)
 #define VMEMMAP_REGION_ID       (0xfUL)
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
