Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp7Ck-0000xT-ND
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 05:14:51 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S5ChP1142925
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:30 -0400
Received: from e28smtp06.in.ibm.com ([125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qy5sb8x9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:30 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 10:44:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EE7C0E0024
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:43:41 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S5EDsC45416494
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:13 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S5EC56030236
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:13 +0530
Subject: [RESEND PATCH 4/8] makedumpfile/ppc64: address change in
 _PAGE_PRESNT flag for PowerISA v3.0
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 10:44:11 +0530
In-Reply-To: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
References: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147503964031.1199.10064693934183497003.stgit@hbathini.in.ibm.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

PowerISA v3.0 CPUs expect _PAGE_PRESENT to be at 0x8000_0000_0000_0000
instead of 0x2 in radix mode. This is accomodated by changing the flag
_PAGE_PRESENT for 64-bit POWER server processors with kernel commit
849f86a6. This patch makes the corresponding change here.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 makedumpfile.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index e45ad09..7f9dfb1 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -660,7 +660,10 @@ int get_va_bits_arm64(void);
 	((vaddr >> (info->l2_shift)) & (info->ptrs_per_l2 - 1))
 
 #define _PAGE_PRESENT		\
-	(info->kernel_version >= KERNEL_VERSION(4, 5, 0) ? 0x2UL : 0x1UL)
+	(info->kernel_version >= KERNEL_VERSION(4, 6, 0) ? \
+	(0x1UL << 63) : (info->kernel_version >= KERNEL_VERSION(4, 5, 0) ? \
+			0x2UL : 0x1UL))
+
 #endif
 
 #ifdef __powerpc32__


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
