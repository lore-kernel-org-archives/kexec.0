Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1boyvm-0000y9-Da
 for kexec@lists.infradead.org; Tue, 27 Sep 2016 20:24:47 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RKMRAq073873
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:27 -0400
Received: from e28smtp09.in.ibm.com ([125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qxsbaeuu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 27 Sep 2016 16:24:27 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 01:54:24 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 96047125804F
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:54:43 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RKOB4t18940128
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:54:11 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RKOKKx011418
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:54:21 +0530
Subject: [PATCH 4/8] ppc64: address change in _PAGE_PRESNT flag for PowerISA
 v3.0
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 01:54:17 +0530
In-Reply-To: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
References: <147500776701.31772.17117150096883318333.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147500785712.31772.10453421238495214725.stgit@hbathini.in.ibm.com>
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
To: Kexec-ml <kexec@lists.infradead.org>
Cc: Ken'ichi <oomichi@mxs.nes.nec.co.jp>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

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
