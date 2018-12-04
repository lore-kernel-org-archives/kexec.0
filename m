Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8H8-0004lA-Hc
 for kexec@lists.infradead.org; Tue, 04 Dec 2018 10:50:00 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB4AdlPV111111
 for <kexec@lists.infradead.org>; Tue, 4 Dec 2018 05:49:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p5pmsv1h5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 04 Dec 2018 05:49:46 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.ibm.com>;
 Tue, 4 Dec 2018 10:49:43 -0000
Subject: [PATCH] makedumpfile/ppc64: increase MAX_PHYSMEM_BITS to 2PB
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Tue, 04 Dec 2018 16:19:38 +0530
MIME-Version: 1.0
Message-Id: <154392057860.8770.14995516431234212273.stgit@hbathini.in.ibm.com>
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
Cc: Dave Young <dyoung@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Kexec-ml <kexec@lists.infradead.org>

* Required for kernel 4.20

With kernel commit 4ffe713b7587 ("powerpc/mm: Increase the max addressable
memory to 2PB"), MAX_PHYSMEM_BITS is bumped up to 51 for SPARSEMEM_VMEMMAP
and SPARSEMEM_EXTREME case. Make the appropriate update here.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/ppc64.c   |    5 +++++
 makedumpfile.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 947a125..5b8231e 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -486,6 +486,11 @@ set_ppc64_max_physmem_bits(void)
 		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
 		return TRUE;
 
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
 	return FALSE;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 73813ed..d49f1f1 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -672,6 +672,7 @@ unsigned long get_kvbase_arm64(void);
 #define _MAX_PHYSMEM_BITS_ORIG  (44)
 #define _MAX_PHYSMEM_BITS_3_7   (46)
 #define _MAX_PHYSMEM_BITS_4_19  (47)
+#define _MAX_PHYSMEM_BITS_4_20  (51)
 #define REGION_SHIFT            (60UL)
 #define VMEMMAP_REGION_ID       (0xfUL)
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
